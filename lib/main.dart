import 'package:flutter/material.dart';
import 'package:setes_mobile/module/api_init.dart';
import 'package:setes_mobile/screen/home.dart';
import 'package:setes_mobile/screen/intro.dart';
import 'package:setes_mobile/screen/login.dart';
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
  HomeConfig({Key? key}) : super(key: key);
  Widget page = const LoadingPage();
  config() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool seen = prefs.getBool('seen') ?? false;
      if (!seen) {
        page = const IntroPage();
        return 0;
      }
      var res = await http.post(setApi("isuptodate"),
          body: {'version': "2", 'key': "123456", 'logged': "0"});
      if (res.statusCode == 200) {
        bool ifUser = prefs.getBool('ifuser') ?? false;
        if (ifUser) {
          page = const HomePage();
        } else {
          page = const LoginPage();
        }
      }
    } catch (e) {
      page = const ErrorPage();
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
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
