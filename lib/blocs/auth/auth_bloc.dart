import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:http/http.dart' as http;
import 'package:pagameto_credit_pix/models/user_model.dart' as user_model;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_event.dart';
import 'auth_state.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;

  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is SignInRequested) {
        await _mapSignInRequestedToState(event, emit);
      } else if (event is SignOutRequested) {
        await _mapSignOutRequestedToState(emit);
      } else if (event is SignUpRequested) {
        await _mapSignUpRequestedToState(event, emit);
      } else if (event is AuthCheckRequested) {
        await _mapAuthCheckRequestedToState(emit);
      }
    });
  }

  Future<void> _mapSignInRequestedToState(SignInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      firebase_auth.UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: event.email, password: event.password);
      await _saveUserSession(userCredential.user);
      emit(AuthAuthenticated(userCredential.user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _mapSignOutRequestedToState(Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await _auth.signOut();
    await _clearUserSession();
    emit(AuthUnauthenticated());
  }

  Future<void> _mapSignUpRequestedToState(SignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      // Primeiro, crie o usuário com email e senha no Firebase
      firebase_auth.UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: event.email, password: event.password);

      // Em seguida, atualize os dados do perfil do usuário no Firebase
      firebase_auth.User? user = userCredential.user;
      if (user != null) {
        await user.updateProfile(displayName: event.fullName);
        await user.reload();
        user = _auth.currentUser;

        // Enviar os dados adicionais para o backend em Laravel
        final response = await http.post(
          Uri.parse('https://your-backend-url.com/api/register'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'email': event.email,
            'password': event.password,
            'fullName': event.fullName,
            'nickname': event.nickname,
            'cpf': event.cpf,
            'cep': event.cep,
            'street': event.street,
            'number': event.number,
            'neighborhood': event.neighborhood,
            'city': event.city,
            'state': event.state,
          }),
        );

        if (response.statusCode == 201) {
          await _saveUserSession(user);
          emit(AuthAuthenticated(user));
        } else {
          emit(AuthError('Failed to register user on backend'));
        }
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _mapAuthCheckRequestedToState(Emitter<AuthState> emit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    String? password = prefs.getString('password');

    if (email != null && password != null) {
      try {
        firebase_auth.UserCredential userCredential = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        emit(AuthAuthenticated(userCredential.user));
      } catch (e) {
        emit(AuthUnauthenticated());
      }
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _saveUserSession(firebase_auth.User? user) async {
    if (user != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', user.email ?? '');
      // Note: Saving the password is not recommended in a real-world app
    }
  }

  Future<void> _clearUserSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    await prefs.remove('password');
  }
}
