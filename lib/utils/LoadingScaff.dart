import 'package:flutter/material.dart';

class LoadingScaff extends StatelessWidget {
  const LoadingScaff({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
