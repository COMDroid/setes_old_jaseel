import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:setes_mobile/method/login.dart';
import 'package:setes_mobile/module/simple.dart';
import 'package:setes_mobile/style/textbox.dart';

class RegisterPage extends StatefulWidget {
  final Map data;
  const RegisterPage(this.data, {Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final Map state = {
    "nameC": TextEditingController(),
    "emailC": TextEditingController(),
    "loading": false,
    "error": null,
  };
  setstate(v, u) => setState(() => state[v] = u);

  @override
  Widget build(BuildContext context) {
    Size screen = getScreen(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffE2F1F4),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: -50,
            height: screen.height * .45,
            child: Padding(
              padding: EdgeInsets.only(
                left: screen.width * .45,
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
            height: screen.height * .5,
            child: Container(
              padding: EdgeInsets.only(
                left: screen.width * .1,
                bottom: screen.height * .08,
              ),
              color: const Color(0xdd1368A9),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const <Widget>[
                  Text(
                    "Welcome To",
                    style: TextStyle(
                      color: Color(0xFFF7D037),
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    " SETES,",
                    style: TextStyle(
                      color: Color(0xFFF7D037),
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: screen.height * .35,
            left: 12,
            right: 12,
            height: 250,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(20, 0, 0, 0),
                    blurRadius: 14,
                    spreadRadius: 10,
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: screen.height * .35 + 250,
            left: screen.width * .5 - 40,
            width: 80,
            height: 40,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(20, 0, 0, 0),
                    blurRadius: 14,
                    spreadRadius: -4,
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: screen.height * .35,
            left: 12,
            right: 12,
            height: 250,
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
                    const Text("Create Your Profile",
                        style: TextStyle(
                          color: Color(0xFF1368A9),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        )),
                    const SizedBox(height: 20),
                    TextField(
                      controller: state["nameC"],
                      autocorrect: true,
                      keyboardType: TextInputType.text,
                      decoration: textBoxStyle1(
                        'Enter your name (Optional)',
                        Icons.person_outline,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: state["emailC"],
                      autocorrect: true,
                      keyboardType: TextInputType.emailAddress,
                      decoration: textBoxStyle1(
                        'Enter your email (Optional)',
                        Icons.email_outlined,
                      ),
                    ),
                    const SizedBox(height: 10),
                    state["error"] == null
                        ? const Text(
                            'For a better communication we collect\n some of your above data',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black26,
                                fontSize: 10.5,
                                letterSpacing: .2,
                                fontWeight: FontWeight.w500),
                          )
                        : Text(
                            state["error"],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 10.5,
                              letterSpacing: .2,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: screen.height * .35 + 220,
            left: screen.width * .5 - 30,
            width: 60,
            height: 60,
            child: InkWell(
              onTap: () => register(context, setstate, state, widget.data),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1368A9), Color(0xFFE2F1F4)],
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp,
                  ),
                ),
                child: Icon(
                  state["loading"]
                      ? Icons.circle_outlined
                      : Icons.arrow_forward,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: screen.height * .18,
            left: screen.width * .1,
            right: screen.width * .1,
            child: Text(
              "“Follow Your Passion”",
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                color: const Color(0xff1368A9),
                fontSize: 20,
                letterSpacing: .2,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: screen.width * .1,
            right: screen.width * .1,
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
                        fontWeight: FontWeight.w500),
                  ),
                  TextSpan(
                    text: "Terms & Privacy Policy",
                    style: TextStyle(
                        color: Color(0x991368A9),
                        fontSize: 12,
                        letterSpacing: .2,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
