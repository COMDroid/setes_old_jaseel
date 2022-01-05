import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:setes_mobile/module/api_init.dart';
import 'package:setes_mobile/screen/home.dart';
import 'package:setes_mobile/screen/login.dart';
import 'package:setes_mobile/screen/otp.dart';
import 'package:http/http.dart' as http;
import 'package:setes_mobile/screen/register.dart';
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
    var res = await http.post(setApi("login"),
        body: {"otp": state["otpC"].text, "pin": data["pin"]});
    if (res.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (await jsonDecode(res.body)["registerd"]) {
        print(res.body);
        await prefs.setBool('ifuser', true);
        await prefs.setString('authkey', await jsonDecode(res.body)["key"]);
        await prefs.setString('userid', await jsonDecode(res.body)["_id"]);
        Navigator.pop(context);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => RegisterPage(jsonDecode(res.body))));
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
    print(data["_id"]);
    var res = await http.post(setApi("register?user_id=" + data["_id"]),
        body: {"name": state["nameC"].text, "email": state["emailC"].text});
    if (res.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('ifuser', true);
      await prefs.setString('authkey', await jsonDecode(res.body)["key"]);
      await prefs.setString('userid', await jsonDecode(res.body)["_id"]);
      Navigator.pop(context);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    } else {
      print(res.body);
      setstate("error", await jsonDecode(res.body)["msg"]);
    }
  } catch (e) {
    setstate("error", "Network Error");
  }
  setstate("loading", false);
}

logout(context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('ifuser', false);
  await prefs.setString('authkey', "");
  await prefs.setString('userid', "");
  Navigator.pop(context);
  Navigator.pop(context);
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => LoginPage()),
  );
}
