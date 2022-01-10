import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:setes_mobile/module/simple.dart';
import 'package:setes_mobile/screen/trufs_setes.dart';
import 'package:setes_mobile/screen/trufs_team.dart';
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
              HomeBanner(data["events"]),
              HomePlayer(data["players"]),
              Padding(
                padding: EdgeInsets.only(
                  left: scr.width * .03,
                  right: scr.width * .03,
                  top: 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5),
                        Text(
                          "Book your slots",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                              fontSize: 20),
                        ),
                        Text(
                          "Book and Play with your own freedom",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                              fontSize: 12),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.sports_baseball,
                      size: 40,
                      color: Color(0xff0E6E9D),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 14),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TrufsSetesPage(
                            dateTomyFormat(DateTime.now()),
                          ),
                        ),
                      ),
                      child: Container(
                        // width: scr.width,
                        margin: EdgeInsets.only(
                          right: scr.width * .01,
                          left: scr.width * .03,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          image: DecorationImage(
                            image: AssetImage("assets/scoreBordBg.png"),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Container(
                          width: scr.width * .46,
                          height: scr.width * .4,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xdd000000),
                                  Color(0x77000000),
                                  Color(0xdd000000)
                                ],
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  "Setes Booking",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  "Join Setes Community to start your profesional football career",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              TrufsTeamPage(dateTomyFormat(DateTime.now())),
                        ),
                      ),
                      child: Container(
                        margin: EdgeInsets.only(
                            left: scr.width * .01, right: scr.width * .03),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/bg_a.png")),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: Container(
                          width: scr.width * .46,
                          height: scr.width * .4,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xdd000000),
                                  Color(0x77000000),
                                  Color(0xdd000000)
                                ],
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  "Team Booking",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  "Do you have your team with you? Book hear",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 100)
              // const HomeBookingBotton(),
            ],
          ),
        ),
      ],
    );
  }
}
