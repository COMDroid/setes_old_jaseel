import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:setes_mobile/module/api_init.dart';
import 'package:setes_mobile/module/gb_var.dart';
import 'package:setes_mobile/screen/home.dart';
import 'package:setes_mobile/screen/intro.dart';
import 'package:setes_mobile/screen/warnings.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Setes',
      theme: ThemeData(primarySwatch: Colors.green),
      home: HomeConfig(),
    );
  }
}

class HomeConfig extends StatelessWidget {
  const HomeConfig({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget page = const LoadingPage();
    config() async {
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
        var res = await http.post(
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
          gbidPrime = body['prime'] ?? false;
          gbUser = body;
          page = const HomePage();
        } else {
          if (res.statusCode == 410) {
            page = const ExpiredPage();
          } else {
            if (res.statusCode == 401)
              page = const IntroPage();
            else
              page = const ErrorPage();
          }
        }
      } catch (e) {
        page = const ErrorPage();
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
