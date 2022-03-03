import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:setes_mobile/module/api_init.dart';
import 'package:setes_mobile/module/gb_var.dart';
import 'package:setes_mobile/screen/home.dart';
import 'package:setes_mobile/screen/intro.dart';
import 'package:setes_mobile/screen/warnings.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Setes',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const HomeConfig(),
    );
  }
}

class HomeConfig extends StatelessWidget {
  const HomeConfig({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget page = const LoadingPage();
    config() async {
      http.Response res;
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String userId = prefs.getString('userid') ?? "";
        String authKey = '';
        bool ifUser = true;
        if (userId == "") {
          ifUser = false;
        } else {
          authKey = prefs.getString('authkey') ?? "";
          gbUserKey = authKey;
          gbUserId = userId;
        }
        res = await http.post(
          setApi("isuptodate?user_id=" + userId),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'ver': 1, 'logged': ifUser, 'key': authKey}),
        );
        if (res.statusCode == 200) {
          if (!ifUser) {
            page = const IntroPage();
            return 0;
          }
          var body = await jsonDecode(res.body);
          gbisGuest = body['guest'] ?? false;
          gbisPrime = body['prime'] ?? false;
          gbUser = body;
          page = const HomePage();
        } else {
          if (res.statusCode == 410) {
            page = const ExpiredPage();
          } else {
            if (res.statusCode == 401) {
              page = const IntroPage();
            } else {
              page = ErrorPage(error: jsonDecode(res.body)['msg']);
            }
          }
        }
      } catch (e) {
        print(e);
        String error =
            "No interner connection\n  or\n  It may be server error\n\n* try again by checking your internet\n* or try after sometime";
        page = ErrorPage(
          error: error,
          fun: () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomeConfig())),
        );
      }
      return 0;
    }

    return FutureBuilder(
      future: config(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return page;
        } else {
          return const LoadingPage();
        }
      },
    );
  }
}
