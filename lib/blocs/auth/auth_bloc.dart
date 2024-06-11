import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:pagameto_credit_pix/models/user_model.dart';
import 'package:pagameto_credit_pix/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';


class AuthBloc extends HydratedBloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is LoginRequested) {
      yield AuthLoading();
      try {
        final user = await authRepository.authenticate(event.email, event.password);
        yield Authenticated(user);
      } catch (e) {
        yield AuthError(e.toString());
      }
    } else if (event is RegisterRequested) {
      yield AuthLoading();
      try {
        final user = await authRepository.register(event.name, event.email, event.password);
        yield Authenticated(user);
      } catch (e) {
        yield AuthError(e.toString());
      }
    } else if (event is LogoutRequested) {
      yield AuthInitial();
    }
  }

  @override
  AuthState fromJson(Map<String, dynamic> json) {
    try {
      final user = User.fromJson(json['user']);
      return Authenticated(user);
    } catch (_) {
      return AuthInitial();
    }
  }

  @override
  Map<String, dynamic> toJson(AuthState state) {
    if (state is Authenticated) {
      return {'user': state.user.toJson()};
    }
    return {};
  }
}
