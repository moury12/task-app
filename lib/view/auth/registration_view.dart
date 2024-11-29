import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_management/core/base/bloc/auth/auth_bloc.dart';
import 'package:task_management/core/components/custom_appbar.dart';
import 'package:task_management/core/components/custom_button.dart';
import 'package:task_management/core/components/custom_text_field.dart';

import 'package:task_management/core/constants/text_style_constant.dart';
import 'package:task_management/core/utils/helper_function.dart';
import 'package:task_management/core/utils/sizedboxes.dart';

import 'package:task_management/view/auth/login_view.dart';

class RegistrationView extends StatefulWidget {
  static const String routeName = '/registration';

  const RegistrationView({super.key});

  @override
  _RegistrationViewState createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    addressController.dispose();
    super.dispose();
  }

  AuthBloc authBloc = AuthBloc();
  File? _imageFile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: BlocListener<AuthBloc, AuthState>(
        bloc: authBloc,
        listener: (context, state) {
          if (state is AuthSuccessState) {
            SnackbarService.showSnackbar(
              context: context,
              title: "Success",
              message: state.message,
            );
            clearControllers();
            Navigator.pushNamedAndRemoveUntil(context, LoginView.routeName,(route) => false,);
          } else if (state is AuthErrorState) {
            SnackbarService.showSnackbar(
              context: context,
              title: "Error",
              message: state.message,
              isError: true,
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello! Register to get \nstarted",
                    style: textStyle20BoldBlack,
                  ),
                  spaceH8,
                  GestureDetector(
                    onTap: pickImage,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey.shade50,
                      foregroundColor: Colors.black,
                      radius: 50.r,
                      backgroundImage: _imageFile != null
                          ? FileImage(_imageFile!)
                          : const NetworkImage(
                              "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png"),
                      child: _imageFile == null
                          ? Icon(Icons.camera_alt, size: 30.sp)
                          : null,
                    ),
                  ),
                  spaceH8,
                  CustomTextFormField(
                    controller: firstNameController,
                    title: 'First Name',
                    hintText: 'Enter your first name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                  spaceH8,
                  CustomTextFormField(
                    controller: lastNameController,
                    title: 'Last Name',
                    hintText: 'Enter your last name',
                  ),
                  spaceH8,
                  CustomTextFormField(
                    controller: emailController,
                    title: 'Email',
                    hintText: 'Enter your email',
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  spaceH8,
                  CustomTextFormField(
                    controller: passwordController,
                    title: 'Password',
                    hintText: 'Enter your password',
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  spaceH8,
                  CustomTextFormField(
                    controller: addressController,
                    title: 'Address',
                    hintText: 'Enter your address',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate() &&
                          _imageFile != null) {
                        authBloc.add(AuthRegistrationEvent(body: {
                          "firstName": firstNameController.text,
                          "lastName": lastNameController.text,
                          "email": emailController.text,
                          "password": passwordController.text,
                          "address": addressController.text,
                        }, file: _imageFile!));

                      }else if(_imageFile == null){
                        SnackbarService.showSnackbar(context: context, message: "Provide an image",isError:true);
                      }
                      log(_imageFile.toString());
                    },
                    title: 'Register',
                  ),
                  spaceH8,
                  Row(
                    children: [
                      const Text('Already have an account?'),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, LoginView.routeName);
                          },
                          child: const Text('Login')),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
void clearControllers(){
    emailController.clear();
    passwordController.clear();
    addressController.clear();
    firstNameController.clear();
    lastNameController.clear();
    _imageFile=null;
}

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }
}

