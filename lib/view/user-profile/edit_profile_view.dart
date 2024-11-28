import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_management/core/base/bloc/user/user_bloc.dart';
import 'package:task_management/core/components/custom_button.dart';
import 'package:task_management/core/components/custom_text_field.dart';
import 'package:task_management/core/init/api_client.dart';
import 'package:task_management/core/utils/helper_function.dart';

class EditProfileView extends StatefulWidget {
  static const String routeName = '/edit-profile';

  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  File? _imageFile;
  String? imageUrl;
  @override
  void initState() {
    context.read<UserBloc>().add(UserLoadedEvent());
    super.initState();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: BlocListener<UserBloc, UserState>(
            listener: (context, state) {
              if (state is UserLoadedState) {
                firstNameController.text = state.user.firstName ?? '';
                lastNameController.text = state.user.lastName ?? '';
                addressController.text = state.user.address ?? '';
                imageUrl =state.user.image;
              }
              if (state is UserErrorState) {
                SnackbarService.showSnackbar(
                  title: "Error",
                    context: context, message: state.message, isError: true);
              }
              if (state is UserSuccessState) {
                SnackbarService.showSnackbar(
                  title: "Success",
                  context: context,
                  message: state.message,
                );
              }
            },
            child: Column(
              children: [
                GestureDetector(
                  onTap: pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _imageFile != null
                        ? FileImage(_imageFile!)
                        : NetworkImage('${ApiClient.baseUrl}/${imageUrl??''}'),

                    child: _imageFile == null
                        ? const Icon(Icons.camera_alt, size: 30)
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
                    if (_formKey.currentState!.validate()) {
                      context.read<UserBloc>().add(UpdateProfileEvent(
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                          address: addressController.text,
                          file: _imageFile ) );
                      context.read<UserBloc>().add(UserLoadedEvent());

                    }
                  },
                  title: 'Update',
                ),
              ],
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
