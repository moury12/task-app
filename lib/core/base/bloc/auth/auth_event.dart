part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}
class AuthLoginEvent extends AuthEvent{
  final String email;
  final String password;

  AuthLoginEvent({required this.email, required this.password});

}
class AuthRegistrationEvent extends AuthEvent{
  final Map<String , dynamic> body;
  final File file;

  AuthRegistrationEvent( {required this.body,required this.file});
}