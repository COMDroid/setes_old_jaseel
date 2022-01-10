import 'package:flutter/material.dart';
import 'package:setes_mobile/method/login.dart';
import 'package:setes_mobile/module/simple.dart';
import 'package:setes_mobile/screen/login.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);
    return Scaffold(
      body: SizedBox(
        width: scr.width,
        height: scr.height,
        child: IntroPageBody(),
      ),
    );
  }
}

class IntroPageBody extends StatefulWidget {
  const IntroPageBody({Key? key}) : super(key: key);

  @override
  _IntroPageBodyState createState() => _IntroPageBodyState();
}

class _IntroPageBodyState extends State<IntroPageBody> {
  String? error;
  bool loading = false;
  seterror(v) => setState(() => error = v);
  setloading(v) => setState(() => loading = v);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("Intro page"),
        const SizedBox(height: 5),
        if (error != null)
          Text(
            error ?? "dfd",
            style: TextStyle(color: Colors.red),
          ),
        TextButton(
          onPressed: () => guestLogin(this),
          child: Text(loading ? "Loading.." : "Enter as Guest."),
        ),
        TextButton(
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginPage())),
          child: Text("Click here to Login."),
        ),
      ],
    );
  }
}
