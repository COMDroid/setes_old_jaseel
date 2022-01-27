import 'package:flutter/material.dart';
import 'package:setes_mobile/module/gb_var.dart';
import 'package:setes_mobile/module/simple.dart';
import 'package:setes_mobile/screen/home_truf.dart';
import 'package:setes_mobile/screen/login.dart';
import 'package:setes_mobile/screen/toprime.dart';
import 'package:setes_mobile/screen/trufs_setes.dart';

class HomeHomeBody extends StatelessWidget {
  const HomeHomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);
    return Column(
      children: [
        SizedBox(height: scr.width * .07),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: scr.width * .08),
              child: InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TrufsSetesPage(
                      dateTomyFormat(DateTime.now()),
                    ),
                  ),
                ),
                child: EachButton(0),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: scr.width * .04),
              child: InkWell(
                onTap: () {
                  if (gbisPrime) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeTruf()),
                    );
                  } else {
                    showDialog<void>(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Upgrade to SETES Community'),
                          content: const Text(
                            'Upgrade to SETES Community to use more feature with setes football club',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                upgradingtoPrime = true;
                                if (gbisGuest)
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginPage(),
                                    ),
                                  );
                                else
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const ToPrimePage(),
                                    ),
                                  );
                              },
                              child: Text('Upgrade Now'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: EachButton(1),
              ),
            ),
          ],
        ),
        SizedBox(height: scr.width * .04),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: scr.width * .08),
              child: EachButton(2),
            ),
            Padding(
              padding: EdgeInsets.only(left: scr.width * .04),
              child: EachButton(3),
            ),
          ],
        ),
      ],
    );
  }
}

class EachButton extends StatelessWidget {
  final int i;
  const EachButton(this.i, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);
    return Container(
      width: scr.width * .4,
      height: scr.width * .52,
      padding: EdgeInsets.all(scr.width * .02),
      decoration: BoxDecoration(
        color: i == 0
            ? Color(0xff9C65FC)
            : i == 1
                ? Color(0xffFD7A9C)
                : i == 2
                    ? Color(0xff6AD9C8)
                    : Color(0xffFFDD7C),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(i == 0 ? scr.width * .4 : 20),
          topRight: Radius.circular(i == 1 ? scr.width * .4 : 20),
          bottomLeft: Radius.circular(i == 2 ? scr.width * .4 : 20),
          bottomRight: Radius.circular(i == 3 ? scr.width * .4 : 20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: const Offset(5.0, 5.0),
            blurRadius: 10.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (i == 0)
            Image.asset(
              "assets/setes_booking.png",
              height: scr.width * .3,
              fit: BoxFit.fitWidth,
            ),
          if (i == 1)
            Image.asset(
              "assets/leader_bord.png",
              height: scr.width * .3,
              fit: BoxFit.fitWidth,
            ),
          Text(
            i == 0
                ? "SETES BOOKING"
                : i == 1
                    ? "LEADER BOARD"
                    : i == 2
                        ? "EVENTS"
                        : "SOCIAL MEDIA",
            style: TextStyle(
              color: Color(0xeeffffff),
              fontSize: scr.width * .042,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (i == 2)
            Image.asset(
              "assets/events.png",
              height: scr.width * .3,
              fit: BoxFit.fitWidth,
            ),
          if (i == 3)
            Image.asset(
              "assets/social.png",
              height: scr.width * .3,
              fit: BoxFit.fitWidth,
            ),
        ],
      ),
    );
  }
}
