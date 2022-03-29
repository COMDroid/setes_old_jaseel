import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:screenshot/screenshot.dart';
import 'package:setes_mobile/method/profile.dart';
import 'package:setes_mobile/module/api_init.dart';
import 'package:setes_mobile/module/simple.dart';
import 'package:setes_mobile/screen/warnings.dart';
import 'package:setes_mobile/widget/myprofile_text.dart';

import 'package:path_provider/path_provider.dart';

class ProfiePage extends StatelessWidget {
  final Map data;
  const ProfiePage(this.data, {Key? key}) : super(key: key);

  showCapturedWidget(context, capturedImage) async {
    if (capturedImage != null) {
      try {
        final dir = await getExternalStorageDirectory();
        final file = await File('${dir!.path}/image.jpg').create();
        file.writeAsBytesSync(capturedImage);
        await FlutterShare.shareFile(
          title: 'Example share',
          filePath: '${dir.path}/image.jpg',
        );
      } catch (e) {
        debugPrint('Share error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Map profile = data;
    ScreenshotController screenshotController = ScreenshotController();
    setProfile(v) => profile = v;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(profile["name"]),
        backgroundColor: const Color(0xff564EB1),
        elevation: 0,
      ),
      body: FutureBuilder(
        future: getProfile(data, setProfile),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: [
                Screenshot(
                  controller: screenshotController,
                  child: PrfilePagebody(profile),
                ),
                Positioned(
                  right: 15,
                  child: InkWell(
                    onTap: (() {
                      screenshotController
                          .capture(delay: const Duration(milliseconds: 10))
                          .then((capturedImage) async {
                        showCapturedWidget(context, capturedImage);
                      }).catchError((onError) {
                        print(onError);
                      });
                    }),
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(35)),
                        color: Colors.white10,
                      ),
                      child: const Icon(Icons.share),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Loading();
          }
        },
      ),
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
      decoration: const BoxDecoration(
        color: Color(0xff564EB1),
        image: DecorationImage(
          image: AssetImage("assets/pro_bg.png"),
          fit: BoxFit.contain,
          alignment: Alignment.bottomCenter,
        ),
      ),
      padding: const EdgeInsets.only(top: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.all(Radius.circular(40)),
              ),
              child: profile['img'] == null
                  ? const Icon(Icons.person, size: 60, color: Colors.white)
                  : ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(40)),
                      child: Image.network(
                        setImgProfile(profile["_id"] + "/" + profile["img"]),
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                      ),
                    ),
            ),
            const SizedBox(height: 15),
            Text(
              profile["name"] ?? '',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              profile['home_truf']['name'] ?? '',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            Image.asset("assets/setes.png", width: scr.width * .35),
            const SizedBox(height: 20),
            MyProfileText1("Goals", profile['goals']),
            MyProfileText1("Assistant", profile['assistants']),
            MyProfileText1("Free Kick", profile['free_kicks']),
            MyProfileText1("Penalty Goal", profile['penalty_goals']),
            MyProfileText1("Interception", profile['interceptions']),
            MyProfileText1("Save", profile['saves']),
            MyProfileText1("Clean Sheet", profile['clean_sheets']),
            MyProfileText1("Penalty Save", profile['penalty_saves']),
          ],
        ),
      ),
    );
  }
}
