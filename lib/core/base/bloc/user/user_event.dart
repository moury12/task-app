part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}
class UserLoadedEvent extends UserEvent{

}class UpdateProfileEvent extends UserEvent{
  final String firstName;
  final String lastName;
  final String address;
 final File? file;

  UpdateProfileEvent({required this.firstName, required this.lastName, required this.address,  this.file});
}
class ActiveUserEvent extends UserEvent{
  final String email;
  final String code;

  ActiveUserEvent({required this.email, required this.code});
}
