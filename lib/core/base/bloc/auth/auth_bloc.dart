import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task_management/core/base/service/auth_service.dart';
import 'package:task_management/core/utils/boxes.dart';
import 'package:task_management/core/utils/helper_function.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginEvent>((event, emit) async {
      Map<String, dynamic> response = await AuthService.loginRequest(
        email: event.email,
        password: event.password,
      );
      if (response['status'] == 'Success') {
        String token = response['data']['token'];
        HiveBoxes.getUserData().put('token', token);
        emit(AuthSuccessState(message: response['message']));
      }else{

        emit(AuthErrorState(message:response['error'] ));
        log('error');
      }
    });
  }
}
