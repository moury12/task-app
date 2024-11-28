import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_management/core/base/bloc/auth/auth_bloc.dart';
import 'package:task_management/core/components/custom_text_field.dart';
import 'package:task_management/core/components/custom_text_field.dart';
import 'package:task_management/core/components/custom_text_field.dart';
import 'package:task_management/core/components/custom_text_field.dart';
import 'package:task_management/core/components/custom_text_field.dart';
import 'package:task_management/core/utils/helper_function.dart';

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
      appBar: AppBar(
        title: Text('User Registration'),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        bloc: authBloc,
        listener: (context, state) {
          if (state is AuthSuccessState) {
            SnackbarService.showSnackbar(
              context: context,
              title: "Success",
              message: state.message,
            );
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
                children: [
                  GestureDetector(
                    onTap: pickImage,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: _imageFile != null
                          ? FileImage(_imageFile!)
                          : NetworkImage(
                              'https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png'),
                      child: _imageFile == null
                          ? Icon(Icons.camera_alt, size: 30)
                          : null,
                    ),
                  ),
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
                  CustomTextFormField(
                    controller: lastNameController,
                    title: 'Last Name',
                    hintText: 'Enter your last name',
                  ),
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
                  CustomTextFormField(
                    controller: passwordController,
                    title: 'Password',
                    hintText: 'Enter your password',
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
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
                  SizedBox(height: 20),
                  ElevatedButton(
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
                      }
                      log(_imageFile.toString());
                    },
                    child: Text('Register'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
