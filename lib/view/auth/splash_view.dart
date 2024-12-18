import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_management/core/base/bloc/splash/splash_bloc.dart';
import 'package:task_management/core/constants/image_constant.dart';
import 'package:task_management/core/constants/text_style_constant.dart';
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
        listener: (context, state) async{
        if(state is SplashLoadedState){
          await Future.delayed(const Duration(seconds: 2));
          if (state.isLoggedIn) {
            Navigator.pushReplacementNamed(context, HomeView.routeName);
          } else {
            Navigator.pushReplacementNamed(context, LoginView.routeName);
          }
        }
        },
        child:  Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(splashImg,height: 200.w,width: 200.w,),
                Text('Welcome to task management....',style: textStyle18BoldBlack,)
              ],
            )
        ),
      ),
    );
  }
}
