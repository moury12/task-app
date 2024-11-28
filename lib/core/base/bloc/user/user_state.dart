part of 'user_bloc.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

class UserLoadedState extends UserState{
  final UserModel user;

  UserLoadedState({required this.user});
}class UserErrorState extends UserState{
  final String message;

  UserErrorState({required this.message});
}
