part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class AuthSuccessState extends AuthState {
  final String message;

  AuthSuccessState({required this.message});
}
class AuthLoadingState extends AuthState {}
class AuthErrorState extends AuthState {
  final String message;

  AuthErrorState({required this.message});
}

