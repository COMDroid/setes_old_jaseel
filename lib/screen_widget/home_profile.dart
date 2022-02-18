import 'package:flutter/material.dart';
import 'package:setes_mobile/module/gb_var.dart';
import 'package:setes_mobile/module/simple.dart';
import 'package:setes_mobile/screen/editprofile.dart';
import 'package:setes_mobile/screen/login.dart';
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
  double skillTop = 0;

  @override
  void initState() {
    Size scr = MediaQueryData.fromWindow(WidgetsBinding.instance!.window).size;
    skillTop = scr.height - 360;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);
    return Container(
      color: Color(0xffF1F5F9),
      child: Column(
        children: [
          Container(
            width: scr.width,
            height: 80,
            alignment: Alignment.bottomLeft,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    blurRadius: 3, spreadRadius: 4, color: Color(0x11000000)),
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: scr.width * .05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        "My Profile",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    if (gbisPrime)
                      IconButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfileScreen()),
                        ),
                        icon: Icon(Icons.edit, color: Colors.black54),
                      ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: scr.width,
            height: scr.height - 80,
            color: Color(0xff564EB1),
            child: Column(
              children: [
                SizedBox(height: 20),
                HomeProfilePicture(),
                Text(
                  gbUser["name"] ?? '',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  (gbisGuest
                      ? gbUser["guest_id"] ?? ""
                      : gbUser["id"] ?? "" + " - Setes"),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                  ),
                  width: scr.width,
                ),
                SizedBox(height: 20),
                Container(
                  width: scr.width,
                  height: scr.height - 280,
                  decoration: BoxDecoration(
                    color: gbisPrime ? Colors.white : Colors.white10,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child:
                            gbisPrime ? MyProfilePrime() : MyProfileNonPrime(),
                      ),
                      Positioned(
                        top: skillTop,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: MyprofileSkills(this),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
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
        Text(
          "Bio",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8),
        HomeProfileEach("Email", gbUser['email']),
        HomeProfileEach("Phone", gbUser['phone']),
        HomeProfileEach("Gender", gbUser['sex']),
        HomeProfileEach("Date of birth", gbUser['dob']),
        HomeProfileEach("Blood Group", gbUser['blood_group']),
        HomeProfileEach("District", gbUser['district']),
        HomeProfileEach("Zone", gbUser['zone']),
        HomeProfileEach("Home Ground", gbUser['home_truf']["name"]),
        HomeProfileEach("Favourite Position", gbUser['fav_position']),
        HomeProfileEach("Sec Favourite Position", gbUser['sec_fav_position']),
        HomeProfileEach("Strong Foot", gbUser['strong_foot']),
        HomeProfileEach("Boot Size", gbUser['foot_size']),
        HomeProfileEach("T-shirt Size", gbUser['t_shirt_size']),
        SizedBox(height: 100),
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
      decoration: BoxDecoration(
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
          Icon(Icons.person_off, size: scr.height * .15, color: Colors.black45),
          TextButton(
            onPressed: () {
              upgradingtoPrime = true;
              if (gbisGuest)
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              else
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ToPrimePage()));
            },
            child: Text(
              "Upgrade to Prime",
              style: TextStyle(
                color: Colors.white,
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
  final props;
  const MyprofileSkills(this.props, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
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
          InkWell(
            onTap: () {
              if (props.skillTop == scr.height - 360.0)
                props.setState(() => props.skillTop = 50.0);
              else
                props.setState(() => props.skillTop = scr.height - 360.0);
            },
            child: Container(
              margin: EdgeInsets.all(8),
              height: 4,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.all(Radius.circular(2)),
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
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
                MyProfileText1("Goals", gbUser['my_goal'] ?? '0'),
                MyProfileText1("Assistant", gbUser['my_assistant'] ?? '0'),
                MyProfileText1("Free Kick", gbUser['my_free_kick'] ?? '0'),
                MyProfileText1(
                    "Penalty Goal", gbUser['my_penalty_goal'] ?? '0'),
                MyProfileText1(
                    "Interception", gbUser['my_interception'] ?? '0'),
                MyProfileText1("Save", gbUser['my_save'] ?? '0'),
                MyProfileText1("Clean Sheet", gbUser['my_clean_sheet'] ?? '0'),
                MyProfileText1(
                    "Penalty Save", gbUser['my_penalty_save'] ?? '0'),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
