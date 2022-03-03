import 'package:flutter/material.dart';
import 'package:setes_mobile/module/simple.dart';
import 'package:setes_mobile/screen/events.dart';
import 'package:setes_mobile/screen/home_truf.dart';
import 'package:setes_mobile/screen/trufs_setes.dart';
import 'package:setes_mobile/widget/home_banner.dart';
import 'package:setes_mobile/widget/home_player.dart';

class HomeHome extends StatelessWidget {
  final Map data;
  const HomeHome(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView(
            children: [
              InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const EventsPage()),
                ),
                child: HomeBanner(data["events"]),
              ),
              HomePlayer(data["players"]),
              Container(
                padding: const EdgeInsets.only(top: 14),
                child: const HomeHomeBody(),
              ),
              const SizedBox(height: 100)
            ],
          ),
        ),
      ],
    );
  }
}

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
                child: const EachButton(0),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: scr.width * .04),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeTruf()),
                  );
                },
                child: const EachButton(1),
              ),
            ),
          ],
        ),
        SizedBox(height: scr.width * .04),
        Row(
          children: [
            Padding(
                padding: EdgeInsets.only(left: scr.width * .08),
                child: InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const EventsPage()),
                  ),
                  child: const EachButton(2),
                )),
            Padding(
              padding: EdgeInsets.only(left: scr.width * .04),
              child: const EachButton(3),
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
            ? const Color(0xFFB58AFF)
            : i == 1
                ? const Color(0xffFD7A9C)
                : i == 2
                    ? const Color(0xff6AD9C8)
                    : const Color(0xffFFDD7C),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(i == 0 ? scr.width * .4 : 20),
          topRight: Radius.circular(i == 1 ? scr.width * .4 : 20),
          bottomLeft: Radius.circular(i == 2 ? scr.width * .4 : 20),
          bottomRight: Radius.circular(i == 3 ? scr.width * .4 : 20),
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(5.0, 5.0),
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
              color: const Color(0xeeffffff),
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
