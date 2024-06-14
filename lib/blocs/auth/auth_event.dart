abstract class AuthEvent {}

class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  SignInRequested(this.email, this.password);
}

class SignOutRequested extends AuthEvent {}

class SignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String fullName;
  final String nickname;
  final String cpf;
  final String cep;
  final String street;
  final String number;
  final String neighborhood;
  final String city;
  final String state;

  SignUpRequested({
    required this.email,
    required this.password,
    required this.fullName,
    required this.nickname,
    required this.cpf,
    required this.cep,
    required this.street,
    required this.number,
    required this.neighborhood,
    required this.city,
    required this.state,
  });
}

class AuthCheckRequested extends AuthEvent {}
