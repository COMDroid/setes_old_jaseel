import 'package:flutter/material.dart';
import 'package:setes_mobile/method/home_truf.dart';
import 'package:setes_mobile/module/gb_var.dart';
import 'package:setes_mobile/module/simple.dart';
import 'package:setes_mobile/screen/profile.dart';
import 'package:setes_mobile/screen/warnings.dart';
import 'package:setes_mobile/widget/home_trufs.dart';

class HomeTruf extends StatefulWidget {
  const HomeTruf({Key? key}) : super(key: key);

  @override
  _HomeTrufState createState() => _HomeTrufState();
}

class _HomeTrufState extends State<HomeTruf> {
  int type = 1;
  bool loading = true;
  String? error;
  List players = [];
  List members = [];

  double dy1 = 0;

  Map players_r = {"_id": "776", "name": '', "img": null};

  @override
  void initState() {
    super.initState();
    getHomeTruf(this);
  }

  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);
    return Scaffold(
      body: Container(
        height: scr.height,
        width: scr.width,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFD10BD), Color(0xFF6B32F5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              // Sky 1
              left: -scr.width * .03 + dy1 * .18,
              top: scr.height * .1,
              height: scr.height * .08,
              child: Opacity(
                opacity: .7,
                child: Image.asset("assets/Path 30.png"),
              ),
            ),
            Positioned(
              // Sky 2
              left: scr.width * .2 + dy1 * .18,
              top: scr.height * .2,
              height: scr.height * .06,
              child: Opacity(
                opacity: .4,
                child: Image.asset("assets/Path 30.png"),
              ),
            ),
            Positioned(
              // Sky 3
              right: scr.width * .06 + dy1 * .18,
              top: scr.height * .13,
              height: scr.height * .1,
              child: Opacity(
                opacity: .7,
                child: Image.asset("assets/Path 30.png"),
              ),
            ),
            Positioned(
              // Sky 3
              right: scr.width * .1 - dy1 * .18,
              top: scr.height * .16 + dy1 * .18,
              height: scr.height * .1,
              child: Opacity(
                opacity: .5,
                child: Image.asset("assets/Path 30.png"),
              ),
            ),
            Positioned(
              // Piller number 3
              left: 0,
              right: scr.height * .21,
              bottom: scr.height * .3 + dy1 * .4,
              height: scr.height * .28,
              child: Image.asset("assets/Group 47.png"),
            ),
            Positioned(
              // Piller number 2
              left: scr.height * .25,
              right: 0,
              bottom: scr.height * .3 + dy1 * .42,
              height: scr.height * .25,
              child: Image.asset("assets/Group 60.png"),
            ),
            Positioned(
              // Piller number 1
              left: 0,
              right: 0,
              bottom: scr.height * .3 + dy1 * .18,
              height: scr.height * .35,
              child: Image.asset("assets/Group 67.png"),
            ),
            HomeTrufplyers(
              loading ? players_r : players[0],
              scr.width * .5,
              scr.height * .67 + dy1 * .16,
              1,
            ),
            HomeTrufplyers(
              loading ? players_r : players[1],
              scr.width * .26,
              scr.height * .58 + dy1 * .4,
              .8,
            ),
            HomeTrufplyers(
              loading ? players_r : players[2],
              scr.width * .8,
              scr.height * .55 + dy1 * .42,
              .85,
            ),
            Positioned(
              // Header
              left: 0,
              top: 0,
              right: 0,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                          ),
                          const Text(
                            "My Truf",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontSize: 20),
                          ),
                        ],
                      ),
                      if (gbisPrime && !gbisGuest)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                if (type != 0) {
                                  setState(() => type = 0);
                                  getHomeTruf(this);
                                }
                              },
                              child: HomeTrufTopButten(
                                  type == 0, gbUser['district'] ?? ''),
                            ),
                            InkWell(
                              onTap: () {
                                if (type != 1) {
                                  setState(() => type = 1);
                                  getHomeTruf(this);
                                }
                              },
                              child: HomeTrufTopButten(
                                  type == 1, gbUser['zone'] ?? ''),
                            ),
                            InkWell(
                              onTap: () {
                                if (type != 2) {
                                  setState(() => type = 2);
                                  getHomeTruf(this);
                                }
                              },
                              child: HomeTrufTopButten(
                                  type == 2, gbUser['home_truf']['name'] ?? ''),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: scr.height * .3,
              left: 0,
              right: 0,
              bottom: 70,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
                child: NotificationListener(
                  onNotification: (Notification t) {
                    if (t is ScrollUpdateNotification) {
                      if (dy1 >= 0 && dy1 <= scr.height * .3) {
                        setState(() => dy1 = dy1 + (t.scrollDelta ?? 0));
                      } else {
                        if (dy1 > scr.height * .3) {
                          setState(() => dy1 = scr.height * .3);
                        }
                        if (dy1 < 0) {
                          setState(() => dy1 = 0);
                        }
                      }
                    }
                    // if (t is OverscrollNotification) {
                    //   OverscrollNotification ov = t;
                    //   // print(ov);
                    // } else {
                    //   if (t is ScrollUpdateNotification) {
                    //     ScrollUpdateNotification sc = t;
                    //     DragUpdateDetails? du = sc.dragDetails;
                    //     // print(du?.delta);
                    //   }
                    // }
                    return true;
                  },
                  child: ListView(
                    children: [
                      SizedBox(height: scr.height * .25),
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35),
                        ),
                        child: Container(
                          color: Colors.white,
                          constraints:
                              BoxConstraints(minHeight: scr.height * .45),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(25),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      type == 0
                                          ? "My district"
                                          : type == 1
                                              ? "My Zone"
                                              : "Home Truf",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black87,
                                          fontSize: 20),
                                    ),
                                    const SizedBox(height: 5),
                                    if (gbisPrime && !gbisGuest)
                                      Text(
                                        type == 0
                                            ? gbUser['district'] ?? ''
                                            : type == 1
                                                ? gbUser['zone'] ?? ''
                                                : gbUser['home_truf']['name'] ??
                                                    '',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black54,
                                          fontSize: 12,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              if (error != null) ErrorBody(error: error ?? ''),
                              if (loading)
                                const Loading()
                              else
                                for (var i = 0; i < members.length; i++)
                                  InkWell(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ProfiePage(members[i]),
                                      ),
                                    ),
                                    child: EachMember(members[i]),
                                  ),
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
              left: 0,
              right: 0,
              bottom: 0,
              height: 70,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(10, 0),
                      color: Colors.black26,
                      spreadRadius: 2,
                      blurRadius: 5,
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "My Ranking",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, size: 15),
                        SizedBox(width: 5),
                        Text(
                          gbUser["p_raiting"] ?? "0",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
