import 'package:flutter/material.dart';
import 'package:setes_mobile/module/gb_var.dart';
import 'package:setes_mobile/module/simple.dart';
import 'package:setes_mobile/screen/editprofile.dart';
import 'package:setes_mobile/screen/login.dart';
import 'package:setes_mobile/screen/profile.dart';
import 'package:setes_mobile/screen/toprime.dart';
import 'package:setes_mobile/widget/home_profile.dart';
import 'package:setes_mobile/widget/home_profiles.dart';
import 'package:setes_mobile/widget/myprofile_text.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  var bottemScrHeight = 120.0;
  var bottemScrIsscroll = false;

  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);
    return GestureDetector(
      onHorizontalDragStart: (details) {
        if (bottemScrHeight == 120) {
          if (scr.height - details.globalPosition.dy < 120) {
            setState(() => bottemScrIsscroll = true);
          }
        }
        if (bottemScrHeight == scr.height - 290) {
          if (details.globalPosition.dy > 290) {
            setState(() => bottemScrIsscroll = true);
          }
        }
      },
      onHorizontalDragUpdate: (details) {
        if (bottemScrIsscroll) {
          setState(
              () => bottemScrHeight = scr.height - details.globalPosition.dy);
        }
      },
      onHorizontalDragEnd: (details) {
        if (bottemScrIsscroll) {
          setState(() {
            bottemScrIsscroll = false;
            if (bottemScrHeight < 200) {
              bottemScrHeight = 120;
            } else {
              bottemScrHeight = scr.height - 290;
            }
          });
        }
      },
      child: Container(
        color: const Color(0xffF1F5F9),
        child: Column(
          children: [
            Container(
              width: scr.width,
              height: 90,
              alignment: Alignment.bottomLeft,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 3,
                    spreadRadius: 4,
                    color: Color(0x11000000),
                  ),
                ],
              ),
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: scr.width * .05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          "My Profile",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: [
                          if (gbisPrime)
                            IconButton(
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const EditProfileScreen(),
                                ),
                              ),
                              icon:
                                  const Icon(Icons.edit, color: Colors.black54),
                            ),
                          if (gbisPrime)
                            IconButton(
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfiePage(gbUser),
                                ),
                              ),
                              icon: const Icon(Icons.share,
                                  color: Colors.black54),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: scr.width,
              height: scr.height - 90,
              color: const Color(0xff564EB1),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const HomeProfilePicture(),
                  Text(
                    gbUser["name"] ?? '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    (gbisGuest
                        ? gbUser["guest_id"] ?? ""
                        : (gbUser["id"] ?? "") + " - Setes"),
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                    ),
                    width: scr.width,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: scr.width,
                    height: scr.height - 290,
                    decoration: BoxDecoration(
                      color: gbisPrime ? Colors.white : Colors.white10,
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                    ),
                    child: Stack(
                      children: [
                        const Positioned(
                          top: 0,
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: MyProfilePrime(),
                        ),
                        if (!gbisPrime)
                          const Positioned(
                            top: 0,
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: MyProfileNonPrime(),
                          ),
                        Positioned(
                          height: bottemScrHeight,
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: MyprofileSkills(this),
                        ),
                        if (!gbisPrime)
                          Positioned(
                            height: bottemScrHeight,
                            bottom: -((scr.height - 290) - bottemScrHeight),
                            left: 0,
                            right: 0,
                            child: const MyProfileNonPrime(),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyProfilePrime extends StatelessWidget {
  const MyProfilePrime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);
    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: scr.width * .1,
        vertical: scr.height * .05,
      ),
      children: [
        const Text(
          "Bio",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        HomeProfileEach("Email", gbUser['email']),
        HomeProfileEach("Phone", gbUser['phone']),
        // HomeProfileEach("Gender", gbUser['sex']),
        HomeProfileEach("Date of birth", gbUser['dob']),
        HomeProfileEach("Blood Group", gbUser['blood_group']),
        HomeProfileEach("District", gbUser['district']),
        HomeProfileEach("Zone", gbUser['zone']),
        HomeProfileEach("Home Ground",
            gbUser['home_truf'] == null ? '' : gbUser['home_truf']["name"]),
        HomeProfileEach("Favourite Position", gbUser['fav_position']),
        HomeProfileEach("Sec Favourite Position", gbUser['sec_fav_position']),
        HomeProfileEach("Strong Foot", gbUser['strong_foot']),
        HomeProfileEach("Boot Size", gbUser['footsize']),
        HomeProfileEach("T-shirt Size", gbUser['t_shirt_size']),
        const SizedBox(height: 100),
      ],
    );
  }
}

class MyProfileNonPrime extends StatelessWidget {
  const MyProfileNonPrime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        color: Color(0x9E665EC1),
        image: DecorationImage(
          image: AssetImage("assets/pro_bg.png"),
          alignment: Alignment.bottomCenter,
          opacity: .5,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/icon/user_lock.png",
            width: scr.height * .15,
            color: const Color(0xFFDBB5FF),
          ),
          TextButton(
            onPressed: () {
              upgradingtoPrime = true;
              if (gbisGuest) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ToPrimePage()));
              }
            },
            child: const Text(
              "Join Community to view carrer dettails",
              style: TextStyle(
                color: Color(0xFFBCAF74),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyprofileSkills extends StatelessWidget {
  final dynamic props;
  const MyprofileSkills(this.props, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        color: Color(0xff665Ec1),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
        boxShadow: [
          BoxShadow(
            spreadRadius: 2,
            blurRadius: 5,
            color: Colors.white38,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(8),
            height: 4,
            width: 50,
            decoration: const BoxDecoration(
              color: Colors.white54,
              borderRadius: BorderRadius.all(Radius.circular(2)),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "CAREER",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                top: 10,
                left: scr.width * .22,
                bottom: 100,
              ),
              child: ListView(
                children: [
                  MyProfileText1("Goals", gbUser['goals']),
                  MyProfileText1("Assistant", gbUser['assistants']),
                  MyProfileText1("Free Kick", gbUser['free_kicks']),
                  MyProfileText1("Penalty Goal", gbUser['penalty_goals']),
                  MyProfileText1("Interception", gbUser['interceptions']),
                  MyProfileText1("Save", gbUser['saves']),
                  MyProfileText1("Clean Sheet", gbUser['clean_sheets']),
                  MyProfileText1("Penalty Save", gbUser['penalty_saves']),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
