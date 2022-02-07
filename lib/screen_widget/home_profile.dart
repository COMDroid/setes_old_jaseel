import 'package:flutter/material.dart';
import 'package:setes_mobile/module/api_init.dart';
import 'package:setes_mobile/module/gb_var.dart';
import 'package:setes_mobile/module/simple.dart';
import 'package:setes_mobile/screen/login.dart';
import 'package:setes_mobile/screen/toprime.dart';
import 'package:setes_mobile/widget/home_profiles.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({Key? key}) : super(key: key);

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
                  blurRadius: 3,
                  spreadRadius: 4,
                  color: Color(0x11000000),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                "My Profile",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
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
                InkWell(
                  onTap: () {
                    
                  },
                  child: Container(
                    width: 80,
                    height: 80,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                    ),
                    child: gbUser['img'] == null
                        ? Icon(Icons.person, size: 60, color: Colors.white)
                        : Image.network(
                            setImgProfile(gbUser["_id"] + "/" + gbUser["img"]),
                            width: 50,
                            height: 50,
                          ),
                  ),
                ),
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
                  child: gbisPrime ? MyProfilePrime() : MyProfileNonPrime(),
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
      ],
    );
  }
}

class MyProfileNonPrime extends StatelessWidget {
  const MyProfileNonPrime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);
    return Expanded(
      child: Container(
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
            Icon(Icons.person_off,
                size: scr.height * .15, color: Colors.black45),
            TextButton(
              onPressed: () {
                upgradingtoPrime = true;
                if (gbisGuest)
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
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
      ),
    );
  }
}
