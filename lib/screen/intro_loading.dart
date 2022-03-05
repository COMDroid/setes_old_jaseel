import 'package:flutter/material.dart';

class IntroLoadingScreen extends StatelessWidget {
  const IntroLoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset("assets/setes_loading.png", width: 60),
      ),
    );
  }
}
