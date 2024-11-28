import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/core/base/bloc/user/user_bloc.dart';
import 'package:task_management/core/utils/helper_function.dart';
import 'package:task_management/main.dart';

class UserProfileView extends StatefulWidget {
  static const String routeName = '/user-profile';

  const UserProfileView({super.key});

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  @override
  void initState() {
    context.read<UserBloc>().add(UserLoadedEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserErrorState) {
          SnackbarService.showSnackbar(
              context: context, message: state.message, isError: true);
        }
        ;
      },
      builder: (BuildContext context, UserState state) {
        if (state is UserInitial) {
          return CircularProgressIndicator();
        } else if (state is UserLoadedState) {
          return Column(
            children: [Text(state.user.email ?? '')],
          );
        }
        return SizedBox.shrink();
      },
    ));
  }
}
