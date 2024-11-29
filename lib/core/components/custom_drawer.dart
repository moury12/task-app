import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_management/core/constants/color_constants.dart';
import 'package:task_management/core/constants/text_style_constant.dart';
import 'package:task_management/core/utils/boxes.dart';
import 'package:task_management/core/utils/paddings.dart';
import 'package:task_management/core/utils/sizedboxes.dart';
import 'package:task_management/view/auth/login_view.dart';
import 'package:task_management/view/user-profile/user_profile_view.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Padding(
          padding: defaultPadding,
          child: Column(
            children: [
              DrawerCard(
                icon: CupertinoIcons.person_alt_circle,
                title: 'User Profile',
                onPressed: () {
                  Navigator.pushNamed(context, UserProfileView.routeName);
                },
              ),
              spaceH8,
              DrawerCard(
                icon: Icons.logout_rounded,
                title: 'Logout',
                onPressed: () {
                  HiveBoxes.getUserData().delete('token');
                  Navigator.pushReplacementNamed(context, LoginView.routeName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function() onPressed;
  const DrawerCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        child: Row(
          children: [
            Icon(
              icon,
              color: kBlackColor,
              size: 30.sp,
            ),
            spaceW8,
            spaceW8,
            Text(
              title,
              style: textStyle16SemiBoldBlack,
            )
          ],
        ));
  }
}
