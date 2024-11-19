abstract class SignUpEvent {}

class SignUpRequestedEvent extends SignUpEvent {
  final String email;
  final String password;

  SignUpRequestedEvent(this.email, this.password);
}
