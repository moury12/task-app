import 'package:flutter/material.dart';

class DefaultCircularProgress extends StatelessWidget {
  const DefaultCircularProgress({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator(
      color: Colors.black,
    ));
  }
}
