import 'package:flutter/material.dart';
import 'package:setes_mobile/module/simple.dart';
import 'package:setes_mobile/screen/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screen = getScreen(context);
    return Scaffold(
      body: SizedBox(
        width: screen.width,
        height: screen.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Intro page"),
            TextButton(
              onPressed: () async {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool('seen', true);
              },
              child: const Text("Click here to Login."),
            ),
          ],
        ),
      ),
    );
  }
}
