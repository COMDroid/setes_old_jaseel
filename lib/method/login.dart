import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:setes_mobile/module/api_init.dart';
import 'package:setes_mobile/module/gb_var.dart';
import 'package:setes_mobile/screen/home.dart';
import 'package:setes_mobile/screen/intro.dart';
import 'package:setes_mobile/screen/login.dart';
import 'package:setes_mobile/screen/otp.dart';
import 'package:http/http.dart' as http;
import 'package:setes_mobile/screen/register.dart';
import 'package:setes_mobile/screen/toprime.dart';
import 'package:shared_preferences/shared_preferences.dart';

login(context, setstate, state) async {
  if (state["loading"]) {
    return;
  }
  if (state["numberC"].text == "") {
    setstate("error", "Enter your mobile number");
    return;
  }
  if (state["numberC"].text.length != 10) {
    setstate("error", "Enter a valid mobile number");
    return;
  }
  setstate("loading", true);
  setstate("error", null);
  try {
    var res = await http
        .post(setApi("sendotp"), body: {"phone": state["numberC"].text});
    if (res.statusCode == 200) {
      Map data = {
        "pin": await jsonDecode(res.body)["pin"],
        "phone": state["numberC"].text
      };
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => OtpPage(data)));
    } else {
      setstate("error", await jsonDecode(res.body)["msg"]);
    }
  } catch (e) {
    setstate("error", "Network Error");
  }
  setstate("loading", false);
}

validateOtp(context, setstate, state, data) async {
  if (state["loading"]) {
    return;
  }
  if (state["otpC"].text == "") {
    setstate("error", "Enter OTP");
    return;
  }
  setstate("loading", true);
  setstate("error", null);
  try {
    var res = await http.post(
      setApi("login"),
      body: {"otp": state["otpC"].text, "pin": data["pin"]},
    );
    if (res.statusCode == 200) {
      if (await jsonDecode(res.body)["registerd"]) {
        var body = await jsonDecode(res.body);
        gbisGuest = body['guest'] ?? false;
        gbisPrime = body['prime'] ?? false;
        gbUser = body;
        gbUserId = body["_id"];

        gbHeader = {
          'Content-Type': 'application/json',
          'user_id': gbUserId,
          "key": body["key"],
          "version": "1.0",
          'gps': "${gbGPS.latitude},${gbGPS.longitude}",
        };
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userid', gbUserId);
        await prefs.setString('authkey', body["key"]);
        Navigator.pop(context);
        Navigator.pop(context);
        if (upgradingtoPrime && !gbisPrime) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const ToPrimePage()));
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
        }
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => RegisterPage(jsonDecode(res.body)),
          ),
        );
      }
    } else {
      setstate("error", jsonDecode(res.body)["msg"]);
    }
  } catch (e) {
    setstate("error", "Network Error");
  }
  setstate("loading", false);
}

register(context, setstate, state, data) async {
  if (state["loading"]) {
    return;
  }
  setstate("loading", true);
  setstate("error", null);
  try {
    var res = await http.post(
      setApi("register?user_id=" + data["_id"]),
      body: jsonEncode(
          {"name": state["nameC"].text, "email": state["emailC"].text}),
      headers: gbHeader,
    );
    if (res.statusCode == 200) {
      var body = await jsonDecode(res.body);
      gbisGuest = body['guest'] ?? false;
      gbisPrime = body['prime'] ?? false;
      gbUser = body;
      gbUserId = body["_id"];

      gbHeader = {
        'Content-Type': 'application/json',
        'user_id': gbUserId,
        "key": body["key"],
        "version": "1.0",
        'gps': "${gbGPS.latitude},${gbGPS.longitude}",
      };
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userid', gbUserId);
      await prefs.setString('authkey', body["key"]);
      Navigator.pop(context);
      Navigator.pop(context);
      if (upgradingtoPrime) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const ToPrimePage()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      }
    } else {
      setstate("error", await jsonDecode(res.body)["msg"]);
    }
  } catch (e) {
    setstate("error", "Network Error");
  }
  setstate("loading", false);
}

logout(context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('authkey', "");
  await prefs.setString('userid', "");
  gbUserId = "";
  gbUser = {};
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const IntroPage(),
      ),
      (Route<dynamic> route) => false);
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const LoginPage()));
}

guestLogin(props) async {
  props.setState(() => props.loading = true);
  props.setState(() => props.error = null);
  try {
    var res = await http.post(setApi("guestlogin"), headers: gbHeader);
    if (res.statusCode == 200) {
      gbUserId = await jsonDecode(res.body)["_id"];
      var authKey = await jsonDecode(res.body)["key"];
      gbHeader = {
        'Content-Type': 'application/json',
        'user_id': gbUserId,
        "key": authKey,
        "version": "1.0",
        'gps': "${gbGPS.latitude},${gbGPS.longitude}",
      };
      gbisGuest = true;
      gbisPrime = false;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userid', gbUserId);
      await prefs.setString('authkey', authKey);
      Navigator.pushReplacement(props.context,
          MaterialPageRoute(builder: (context) => const HomePage()));
    } else {
      props.setState(() => props.error = jsonDecode(res.body)["msg"]);
    }
  } catch (e) {
    props.setState(() => props.error = "Network Error");
  }
  props.setState(() => props.loading = false);
  return 0;
}
