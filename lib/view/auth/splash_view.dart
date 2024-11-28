import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/core/base/bloc/splash/splash_bloc.dart';
import 'package:task_management/main.dart';
import 'package:task_management/view/auth/login_view.dart';
import 'package:task_management/view/home/home_view.dart';

class SplashView extends StatefulWidget {
  static const String routeName = '/';

  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    context.read<SplashBloc>().add(AuthenticateEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
        if(state is SplashLoadedState){
          if (state.isLoggedIn) {
            Navigator.pushReplacementNamed(context, HomeView.routeName);
          } else {
            Navigator.pushReplacementNamed(context, LoginView.routeName);
          }
        }
        },
        child: const Center(
            child: CircularProgressIndicator()
        ),
      ),
    );
  }
}
