import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task_management/core/utils/boxes.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<AuthenticateEvent>((event, emit) {
     bool isLoggedIn = HiveBoxes.getUserData().get('token') != null &&
HiveBoxes.getUserData().get('token').toString().isNotEmpty;
     emit(SplashLoadedState(isLoggedIn: isLoggedIn));
    });
  }
}
