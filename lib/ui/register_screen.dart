import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagameto_credit_pix/blocs/auth/auth_bloc.dart';
import 'package:pagameto_credit_pix/blocs/auth/auth_event.dart';
import 'package:pagameto_credit_pix/blocs/auth/auth_state.dart';


class RegisterScreen extends StatelessWidget {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _neighborhoodController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextField(
                controller: _fullNameController,
                decoration: InputDecoration(labelText: 'Nome Completo'),
              ),
              TextField(
                controller: _nicknameController,
                decoration: InputDecoration(labelText: 'Nickname'),
              ),
              TextField(
                controller: _cpfController,
                decoration: InputDecoration(labelText: 'CPF'),
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Senha'),
                obscureText: true,
              ),
              TextField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(labelText: 'Confirmação de Senha'),
                obscureText: true,
              ),
              TextField(
                controller: _cepController,
                decoration: InputDecoration(labelText: 'CEP'),
              ),
              TextField(
                controller: _streetController,
                decoration: InputDecoration(labelText: 'Rua'),
              ),
              TextField(
                controller: _numberController,
                decoration: InputDecoration(labelText: 'Número'),
              ),
              TextField(
                controller: _neighborhoodController,
                decoration: InputDecoration(labelText: 'Bairro'),
              ),
              TextField(
                controller: _cityController,
                decoration: InputDecoration(labelText: 'Cidade'),
              ),
              TextField(
                controller: _stateController,
                decoration: InputDecoration(labelText: 'Estado'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_passwordController.text != _confirmPasswordController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('As senhas não coincidem')),
                    );
                    return;
                  }

                  BlocProvider.of<AuthBloc>(context).add(
                    SignUpRequested(
                      email: _emailController.text,
                      password: _passwordController.text,
                      fullName: _fullNameController.text,
                      nickname: _nicknameController.text,
                      cpf: _cpfController.text,
                      cep: _cepController.text,
                      street: _streetController.text,
                      number: _numberController.text,
                      neighborhood: _neighborhoodController.text,
                      city: _cityController.text,
                      state: _stateController.text,
                    ),
                  );
                },
                child: Text('Register'),
              ),
              BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthAuthenticated) {
                    Navigator.pushReplacementNamed(context, '/home');
                  } else if (state is AuthError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                },
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
