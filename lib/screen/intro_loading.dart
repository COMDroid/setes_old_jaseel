import 'package:flutter/material.dart';
import 'package:setes_mobile/module/simple.dart';

class IntroLoadingScreen extends StatelessWidget {
  const IntroLoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset(
          "assets/setes_loading.png",
          height: scr.height*.8,
        ),
      ),
    );
  }
}
