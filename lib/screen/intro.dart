import 'package:flutter/material.dart';
import 'package:setes_mobile/method/login.dart';
import 'package:setes_mobile/module/simple.dart';
import 'package:setes_mobile/screen/login.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffE2F1F4),
      body: IntroPageBody(),
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
    Size scr = getScreen(context);
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          right: -50,
          height: scr.height * .45,
          child: Padding(
            padding: EdgeInsets.only(
              left: scr.width * .45,
              top: 0,
              bottom: 0,
            ),
            child: Image.asset(
              "assets/loginBg.jpeg",
              fit: BoxFit.contain,
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: scr.height * .4,
          child: Container(
            padding: EdgeInsets.only(
              left: scr.width * .1,
              bottom: scr.height * .08,
            ),
            color: const Color(0xdd1368A9),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const <Widget>[
                Text(
                  "Welcome To",
                  style: TextStyle(
                    color: Color(0xFFF7D037),
                    fontSize: 26,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  " SETES,",
                  style: TextStyle(
                    color: Color(0xFFF7D037),
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: scr.height * .3,
          left: 12,
          right: 12,
          height: 260,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 5),
                  const Text(
                    "Chose Login Type",
                    style: TextStyle(
                      color: Color(0xFF1368A9),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 20),
                  error == null
                      ? SizedBox()
                      : Text(
                          error ?? '',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 10.5,
                            letterSpacing: .2,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                  for (var i = 0; i < 2; i++)
                    InkWell(
                      onTap: () {
                        if (i == 0) {
                          guestLogin(this);
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        }
                      },
                      child: Container(
                        height: 50,
                        width: scr.width,
                        margin:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(2, 3),
                              spreadRadius: 0,
                              blurRadius: 10,
                              color: Color(0x33000000),
                            ),
                          ],
                          gradient: const LinearGradient(
                            colors: [Color(0xFF1368A9), Color(0xFFE2F1F4)],
                            begin: FractionalOffset(0.0, 1.0),
                            end: FractionalOffset(1.0, 0.0),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              i == 0 ? "Enter as Guest" : "Click here to Login",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontSize: 18),
                            ),
                            Icon(i == 0 ? Icons.gesture : Icons.login,
                                color: Colors.white)
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          left: scr.width * .1,
          right: scr.width * .1,
          child: RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: "By clicking the button you are accepting the ",
                  style: TextStyle(
                    color: Colors.black26,
                    fontSize: 12,
                    letterSpacing: .2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text: "Terms & Privacy Policy",
                  style: TextStyle(
                    color: Color(0x991368A9),
                    fontSize: 12,
                    letterSpacing: .2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
