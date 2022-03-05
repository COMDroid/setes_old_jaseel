import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:setes_mobile/method/home.dart';
import 'package:setes_mobile/module/api_init.dart';
import 'package:setes_mobile/module/gb_var.dart';
import 'package:setes_mobile/screen/intro_loading.dart';
import 'package:setes_mobile/screen/notification.dart';
import 'package:setes_mobile/screen/warnings.dart';
import 'package:setes_mobile/screen_widget/home_drower.dart';
import 'package:setes_mobile/screen_widget/home_home.dart';
import 'package:setes_mobile/screen_widget/home_mystuf.dart';
import 'package:setes_mobile/screen_widget/home_profile.dart';
import 'package:setes_mobile/screen_widget/home_scorebord.dart';
import 'package:setes_mobile/widget/home_bottombar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getHome(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const ErrorPage();
        } else if (snapshot.hasData) {
          if (jsonDecode(snapshot.data.toString())[0]) {
            return const ErrorPage();
          } else {
            return Body(jsonDecode(snapshot.data.toString())[1]);
          }
        } else {
          return const IntroLoadingScreen();
        }
      },
    );
  }
}

class Body extends StatefulWidget {
  final Map data;
  const Body(this.data, {Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Map state = {"page": 0};
  setstate(v, u) => setState(() => state[v] = u);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const HomeDrower(),
      appBar: state["page"] != 0
          ? null
          : AppBar(
              iconTheme: const IconThemeData(color: Colors.black),
              backgroundColor: Colors.white,
              shadowColor: Colors.black26,
              elevation: 3,
              leading: Builder(builder: (context) {
                return InkWell(
                  child: const Icon(Icons.menu_rounded),
                  onTap: () => Scaffold.of(context).openDrawer(),
                );
              }),
              title: Transform.translate(
                offset: const Offset(-20.0, 0.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child: Image.asset("assets/setes.jpeg", height: 36),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyNotification())),
                      icon: const Icon(Icons.notifications, color: Colors.blue),
                    ),
                    InkWell(
                      onTap: () {
                        var stateT = state;
                        stateT["page"] = 3;
                        setState(() => state = stateT);
                      },
                      child: const HomeAppbarProfilePic(),
                    ),
                  ],
                ),
              ),
            ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: state["page"] == 0
                ? HomeHome(widget.data)
                : state["page"] == 1
                    ? HomeScorebord(widget.data['bookings'])
                    : state["page"] == 2
                        ? const MyStuf()
                        : const MyProfile(),
          ),
          Positioned(
            height: 80,
            bottom: 0,
            left: 0,
            right: 0,
            child: HomeBottombar(setstate),
          )
        ],
      ),
    );
  }
}

class HomeAppbarProfilePic extends StatelessWidget {
  const HomeAppbarProfilePic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (gbUser["img"] == null) {
      return Container(
        width: 30,
        height: 30,
        margin: const EdgeInsets.all(5),
        decoration: const BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: const Icon(Icons.person, size: 20, color: Colors.white),
      );
    }
    String picLink = setImgProfile(gbUser["_id"] + '/' + gbUser["img"]);
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(picLink, width: 40, height: 40, fit: BoxFit.cover),
    );
  }
}
