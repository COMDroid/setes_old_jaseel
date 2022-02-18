import 'package:flutter/material.dart';
import 'package:setes_mobile/method/profile.dart';
import 'package:setes_mobile/module/api_init.dart';
import 'package:setes_mobile/module/simple.dart';
import 'package:setes_mobile/screen/warnings.dart';
import 'package:setes_mobile/widget/home_profile.dart';
import 'package:setes_mobile/widget/myprofile_text.dart';

class ProfiePage extends StatelessWidget {
  final Map profile;
  const ProfiePage(this.profile, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(profile["name"]),
          backgroundColor: Color(0xff564EB1),
          elevation: 0,
        ),
        body: PrfilePagebody(profile)
        // FutureBuilder(
        //   future: getProfile(this),
        //   builder: (context, snapshot) {
        //     if (snapshot.hasData) {
        //       return PrfilePagebody(profile);
        //     } else {
        //       return Loading();
        //     }
        //   },
        // ),
        );
  }
}

class PrfilePagebody extends StatelessWidget {
  final Map profile;
  const PrfilePagebody(this.profile, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);
    return Container(
      height: scr.height - 80,
      width: scr.width,
      decoration: BoxDecoration(
        color: Color(0xff564EB1),
        image: DecorationImage(
            image: new AssetImage("assets/pro_bg.png"),
            fit: BoxFit.contain,
            alignment: Alignment.bottomCenter),
      ),
      padding: EdgeInsets.symmetric(horizontal: scr.width * .22, vertical: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.all(Radius.circular(40)),
              ),
              child: profile['img'] == null
                  ? Icon(Icons.person, size: 60, color: Colors.white)
                  : ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      child: Image.network(
                        setImgProfile(profile["_id"] + "/" + profile["img"]),
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                      ),
                    ),
            ),
            SizedBox(height: 15),
            Text(
              profile["name"] ?? '',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            MyProfileText1("Goals", profile['my_goal'] ?? '0'),
            MyProfileText1("Assistant", profile['my_assistant'] ?? '0'),
            MyProfileText1("Free Kick", profile['my_free_kick'] ?? '0'),
            MyProfileText1("Penalty Goal", profile['my_penalty_goal'] ?? '0'),
            MyProfileText1("Interception", profile['my_interception'] ?? '0'),
            MyProfileText1("Save", profile['my_save'] ?? '0'),
            MyProfileText1("Clean Sheet", profile['my_clean_sheet'] ?? '0'),
            MyProfileText1("Penalty Save", profile['my_penalty_save'] ?? '0'),
          ],
        ),
      ),
    );
  }
}
