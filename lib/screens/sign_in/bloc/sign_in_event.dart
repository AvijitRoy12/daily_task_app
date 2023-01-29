abstract class SignInEvent {}

class SignInTextChangedEvent extends SignInEvent {
  final String emailvalue;
  final String passwordValue;

  SignInTextChangedEvent(this.emailvalue, this.passwordValue);
}

class SignInSubmittedEvent extends SignInEvent {
  final String email;
  final String password;

  SignInSubmittedEvent(this.email, this.password);
}
