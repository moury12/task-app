import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? title;
  final Widget? label;
  final Function()? onPressed;
  const CustomButton({
    super.key,  this.title,  this.onPressed, this.label,
  });

  @override
  Widget build(BuildContext context) {
    final isDisabled = onPressed == null;
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: isDisabled ? Colors.grey : Colors.white, // Text color
            backgroundColor: isDisabled ? Colors.grey.shade300 : Theme.of(context).primaryColor, // Button color
            shadowColor: isDisabled ? Colors.transparent : null, // Remove shadow if disabled
            splashFactory: isDisabled
                ? NoSplash.splashFactory
                : InkRipple.splashFactory, // Remove splash effect when disabled
          ),
          onPressed:onPressed, child:label?? Text(title??'')),
    );
  }
}
