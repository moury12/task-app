import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task_management/core/base/model/user_model.dart';
import 'package:task_management/core/base/service/auth_service.dart';
import 'package:task_management/core/utils/boxes.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<UserLoadedEvent>((event, emit) async {
      emit(UserInitial());
      String? token = HiveBoxes.getUserData().get('token');

      if (token != null && token.isNotEmpty) {
        final responseData = await AuthService.fetchUserProfile(token: token);
        if (responseData['status'] != null &&
            responseData['status'] == 'Success') {
          UserModel user = UserModel.fromJson(responseData['data']);

          emit(UserLoadedState(user: user));
        } else {
          emit(UserErrorState(message: responseData['error']));
        }
      } else {
        emit(UserErrorState(message: 'Provide a valid Token'));
      }
    });
    on<ActiveUserEvent>((event, emit) async {
      final responseData =
          await AuthService.activeUser(email: event.email, code: event.code);
      if (responseData['status'] != null &&
          responseData['status'] == 'Success') {
        emit(UserSuccessState(message: 'Account activated'));
      } else {
        emit(UserErrorState(message: 'Account activation not successful'));
      }
    })
    ;on<UpdateProfileEvent>((event, emit) async {
      String? token = HiveBoxes.getUserData().get('token');
      if(token != null && token.isNotEmpty){
        final responseData = await AuthService.updateProfile(
            firstName: event.firstName,
            lastName: event.lastName,
            address: event.address,
            file: event.file,
            token: token);
        if (responseData['status'] != null &&
            responseData['status'] == 'Success') {
          emit(UserSuccessState(message: 'Profile update successful'));
        } else {
          emit(UserErrorState(message: 'Something went wrong'));
        }
      }else {
        emit(UserErrorState(message: 'Something went wrong'));
      }
    });
  }
}
