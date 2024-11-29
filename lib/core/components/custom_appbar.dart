import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? actions;
  const CustomAppBar({
    super.key, this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading:  IconButton(onPressed: () {
        Navigator.of(context).pop();
      }, icon: const Icon(CupertinoIcons.back)),
      actions:actions??[] ,

    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
