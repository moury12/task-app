part of 'splash_bloc.dart';

@immutable
sealed class SplashState {}

final class SplashInitial extends SplashState {}
class SplashLoadedState extends SplashState{
  final bool isLoggedIn;

  SplashLoadedState({ this.isLoggedIn = false});

}
