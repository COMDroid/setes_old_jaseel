import 'package:flutter/material.dart';
import 'package:setes_mobile/module/gb_var.dart';
import 'package:setes_mobile/module/simple.dart';
import 'package:setes_mobile/widget/home_banner.dart';
import 'package:setes_mobile/widget/home_homebody.dart';
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
              // Padding(
              //   padding: EdgeInsets.only(
              //     left: scr.width * .03,
              //     right: scr.width * .03,
              //     top: 15,
              //   ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           SizedBox(height: 5),
              //           Text(
              //             "Book your slots",
              //             style: TextStyle(
              //                 fontWeight: FontWeight.w700,
              //                 color: Colors.black87,
              //                 fontSize: 20),
              //           ),
              //           Text(
              //             "Book and Play with your own freedom",
              //             style: TextStyle(
              //                 fontWeight: FontWeight.w500,
              //                 color: Colors.black54,
              //                 fontSize: 12),
              //           ),
              //         ],
              //       ),
              //       // Icon(
              //       //   Icons.sports_baseball,
              //       //   size: 40,
              //       //   color: Color(0xff0E6E9D),
              //       // )
              //     ],
              //   ),
              // ),
              Container(
                padding: EdgeInsets.only(top: 14),
                child: HomeHomeBody(),
                // child: gbisPrime ? HomeHomeBodyPrime() : HomeHomeBodyNotPrime(),
              ),
              const SizedBox(height: 100)
            ],
          ),
        ),
      ],
    );
  }
}
