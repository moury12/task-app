import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task_management/core/base/model/user_model.dart';
import 'package:task_management/core/base/service/auth_service.dart';
import 'package:task_management/core/utils/boxes.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<UserLoadedEvent>((event, emit) async{
      emit(UserInitial());
      String? token = HiveBoxes.getUserData().get('token');

     if(token!=null && token.isNotEmpty) {
       final responseData =await AuthService.fetchUserProfile(token: token);
       if (responseData['status'] != null &&
           responseData['status'] == 'Success') {

         UserModel user =  UserModel.fromJson(responseData['data']);;
         emit(UserLoadedState(user: user));
       }else{
         emit(UserErrorState(message: responseData['error']));

       }

      }else{
       emit(UserErrorState(message: 'Provide a valid Token'));
     }

    });
  }
}
