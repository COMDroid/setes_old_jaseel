import 'package:flutter/material.dart';
import 'package:setes_mobile/module/gb_var.dart';
import 'package:setes_mobile/module/simple.dart';
import 'package:setes_mobile/widget/home_trufs.dart';

class HomeTruf extends StatefulWidget {
  const HomeTruf({Key? key}) : super(key: key);

  @override
  _HomeTrufState createState() => _HomeTrufState();
}

class _HomeTrufState extends State<HomeTruf> {
  int type = 0;

  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);
    print(gbUser);
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
              left: -scr.width * .03,
              top: scr.height * .1,
              height: scr.height * .08,
              child: Opacity(
                opacity: .7,
                child: Image.asset("assets/Path 30.png"),
              ),
            ),
            Positioned(
              // Sky 2
              left: scr.width * .2,
              top: scr.height * .2,
              height: scr.height * .06,
              child: Opacity(
                opacity: .4,
                child: Image.asset("assets/Path 30.png"),
              ),
            ),
            Positioned(
              // Sky 3
              right: scr.width * .06,
              top: scr.height * .13,
              height: scr.height * .1,
              child: Image.asset("assets/Path 30.png"),
            ),
            Positioned(
              // Piller number 3
              left: 0,
              right: scr.height * .21,
              bottom: scr.height * .3,
              height: scr.height * .28,
              child: Image.asset("assets/Group 47.png"),
            ),
            Positioned(
              // Piller number 2
              left: scr.height * .25,
              right: 0,
              bottom: scr.height * .3,
              height: scr.height * .25,
              child: Image.asset("assets/Group 60.png"),
            ),
            Positioned(
              // Piller number 1
              left: 0,
              right: 0,
              bottom: scr.height * .3,
              height: scr.height * .35,
              child: Image.asset("assets/Group 67.png"),
            ),
            HomeTrufplyers(scr.width * .5, scr.height * .67, 1),
            HomeTrufplyers(scr.width * .26, scr.height * .58, .8),
            HomeTrufplyers(scr.width * .8, scr.height * .55, .85),
            Positioned(
              // Header
              left: 0,
              top: 0,
              right: 0,
              child: SafeArea(
                child: Padding(
                    padding: EdgeInsets.all(6),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "My Truf",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  fontSize: 20),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                if (type != 0) setState(() => type = 0);
                              },
                              child: HomeTrufTopButten(
                                  type == 0, gbUser['district'] ?? ''),
                            ),
                            InkWell(
                              onTap: () {
                                if (type != 1) setState(() => type = 1);
                              },
                              child: HomeTrufTopButten(
                                  type == 1, gbUser['zone'] ?? ''),
                            ),
                            InkWell(
                              onTap: () {
                                if (type != 2) setState(() => type = 2);
                              },
                              child: HomeTrufTopButten(
                                  type == 2, gbUser['home'] ?? ''),
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
            ),
            Positioned(
              top: scr.height * .3,
              left: 0,
              right: 0,
              bottom: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
                child: Container(
                  child: ListView(
                    children: [
                      SizedBox(height: scr.height * .25),
                      ClipRRect(
                        borderRadius: BorderRadius.only(
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
                                padding: EdgeInsets.all(25),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      type == 0
                                          ? "My district"
                                          : type == 1
                                              ? "My Zone"
                                              : "Home Truf",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black87,
                                          fontSize: 20),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      "Green Truf",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black54,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                              for (var i = 0; i < 2; i++) EachMember(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
