import 'package:flutter/material.dart';
import 'package:setes_mobile/module/simple.dart';
import 'package:setes_mobile/screen/scorebord.dart';
import 'package:setes_mobile/widget/scorebord_timer.dart';

class HomeScorebord extends StatelessWidget {
  final List bookings;
  const HomeScorebord(this.bookings, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xffFE8260), Color(0xff7249FB)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SafeArea(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            SizedBox(height: 5),
                            Text(
                              "Score Board",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              "Setes Match Scoar Board",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Image.asset("assets/scoreBordBg.png")
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 80,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.only(top: 65),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    SizedBox(height: scr.width * .55),
                    Container(
                      constraints: BoxConstraints(
                          minHeight: scr.height - (scr.width * .5 + 90)),
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35),
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: scr.width * .05,
                              vertical: 15,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 5),
                                    Row(
                                      children: const [
                                        Text(
                                          "My Location",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black54,
                                            fontSize: 12,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Icon(
                                          Icons.location_on,
                                          size: 18,
                                          color: Colors.black54,
                                        )
                                      ],
                                    ),
                                    const Text(
                                      "Today",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black87,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          for (var i = 0; i < bookings.length; i++)
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ScoreBordScreen(bookings[i]),
                                  ),
                                );
                              },
                              child: EachScore(bookings[i], false),
                            ),
                          if (bookings.isEmpty)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "No Match",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EachScore extends StatelessWidget {
  final Map booking;
  final bool showGoals;
  const EachScore(this.booking, this.showGoals, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List goals = [];
    for (var i = 0; i < booking['events'].length; i++) {
      if (booking['events'][i]['item'] == "goals") {
        goals.add(booking['events'][i]);
      }
    }
    return SizedBox(
      height: 130 + (showGoals ? goals.length / 2 * 24 : 0),
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Positioned(
            top: 0,
            left: 30,
            right: 30,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Colors.red,
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF9C9E), Color(0xFFFFB9A3)],
                ),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(2, 3),
                    blurRadius: 6,
                    color: Colors.black12,
                  ),
                ],
              ),
              height: 110 + (showGoals ? goals.length / 2 * 24 : 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    booking['slot'] == null
                        ? "Unnamed"
                        : booking['slot']["truf_name"] ?? '',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    booking['goals']['r'].toString() +
                        " : " +
                        booking['goals']['b'].toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    booking['date'] ?? '',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ScoreBoradTimer(booking),
                  Text(
                    findWInner(booking),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (showGoals)
                    Column(
                      children: [
                        for (var i = 0; i < goals.length; i += 2)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${goals[i]['who']['name']} ${goals[i]['time']}\'',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  height: 1.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (i + 1 < goals.length)
                                Text(
                                  '${goals[i]['who']['name']} ${goals[i]['time']}\'',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    height: 1.5,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                            ],
                          )
                      ],
                    )
                ],
              ),
            ),
          ),
          Positioned(
            top: 25,
            left: 0,
            width: 60,
            height: 60,
            child: Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                gradient: LinearGradient(
                  colors: [Color(0xFFCE2B2B), Color(0xFFE22B0B)],
                ),
              ),
              child: const Text(
                "RED\nTEAM",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
          Positioned(
            top: 25,
            right: 0,
            width: 60,
            height: 60,
            child: Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                gradient: LinearGradient(
                  colors: [Color(0xff3B4EFC), Color(0xffB409F8)],
                ),
              ),
              child: const Text(
                "BLUE\nTEAM",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
