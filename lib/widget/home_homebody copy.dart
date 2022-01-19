import 'package:flutter/material.dart';
import 'package:setes_mobile/module/simple.dart';
import 'package:setes_mobile/screen/trufs_setes.dart';

class HomeHomeBody extends StatelessWidget {
  const HomeHomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);
    return Column(
      children: [
        Row(
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
                          Color(0x99000000),
                          Color(0x00000000),
                          Color(0x99000000)
                        ],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
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
              onTap: () {},
              child: Container(
                margin: EdgeInsets.only(
                    left: scr.width * .01, right: scr.width * .03),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/leader_board.png"),
                    fit: BoxFit.cover,
                  ),
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
                          Color(0x99000000),
                          Color(0x00000000),
                          Color(0x99000000)
                        ],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Leader Board",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "Be a champ!! show case yourself",
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
        SizedBox(height: 10),
        Row(
          children: [
            InkWell(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.only(
                  right: scr.width * .01,
                  left: scr.width * .03,
                ),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  image: DecorationImage(
                    image: AssetImage("assets/events_img1.png"),
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
                          Color(0x99000000),
                          Color(0x00000000),
                          Color(0x99000000)
                        ],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Events",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "Find out what's more you can earn",
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
              onTap: () {},
              child: Container(
                margin: EdgeInsets.only(
                    left: scr.width * .01, right: scr.width * .03),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/social_media_img.jpg"),
                    fit: BoxFit.cover,
                  ),
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
                          Color(0x99000000),
                          Color(0x00000000),
                          Color(0x99000000)
                        ],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Social Meadia",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "Be a champ!! show case yourself",
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
        )
      ],
    );
  }
}

// class HomeHomeBodyNotPrime extends StatelessWidget {
//   const HomeHomeBodyNotPrime({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Size scr = getScreen(context);
//     return Row(
//       children: [
//         InkWell(
//           onTap: () => Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => TrufsSetesPage(
//                 dateTomyFormat(DateTime.now()),
//               ),
//             ),
//           ),
//           child: Container(
//             margin: EdgeInsets.only(
//               right: scr.width * .01,
//               left: scr.width * .03,
//             ),
//             decoration: BoxDecoration(
//               color: Colors.redAccent,
//               image: DecorationImage(
//                 image: AssetImage("assets/scoreBordBg.png"),
//                 fit: BoxFit.cover,
//               ),
//               borderRadius: BorderRadius.all(Radius.circular(5)),
//             ),
//             child: Container(
//               width: scr.width * .46,
//               height: scr.width * .4,
//               padding: const EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     colors: [
//                       Color(0x99000000),
//                       Color(0x00000000),
//                       Color(0x99000000)
//                     ],
//                   ),
//                   borderRadius: BorderRadius.all(Radius.circular(5))),
//               child: Container(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: const [
//                     Text(
//                       "Setes Booking",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 20,
//                       ),
//                     ),
//                     Text(
//                       "Join Setes Community to start your profesional football career",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 12,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//         InkWell(
//           onTap: () {
//             if (gbisGuest) {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const LoginPage(),
//                 ),
//               );
//             } else {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const ToPrimePage(),
//                 ),
//               );
//             }
//           },
//           child: Container(
//             margin:
//                 EdgeInsets.only(left: scr.width * .01, right: scr.width * .03),
//             decoration: BoxDecoration(
//               image: DecorationImage(image: AssetImage("assets/bg_a.png")),
//               borderRadius: BorderRadius.all(
//                 Radius.circular(5),
//               ),
//             ),
//             child: Container(
//               width: scr.width * .46,
//               height: scr.width * .4,
//               padding: const EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     colors: [
//                       Color(0x99000000),
//                       Color(0x00000000),
//                       Color(0x99000000)
//                     ],
//                   ),
//                   borderRadius: BorderRadius.all(Radius.circular(8))),
//               child: Container(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: const [
//                     Text(
//                       "Upgrade To Community",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 20,
//                       ),
//                     ),
//                     Text(
//                       "Get more benifits on Setes community",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 12,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//         // InkWell(
//         //   onTap: () => Navigator.push(
//         //     context,
//         //     MaterialPageRoute(
//         //       builder: (context) =>
//         //           TrufsTeamPage(dateTomyFormat(DateTime.now())),
//         //     ),
//         //   ),
//         //   child: Container(
//         //     margin:
//         //         EdgeInsets.only(left: scr.width * .01, right: scr.width * .03),
//         //     decoration: BoxDecoration(
//         //       image: DecorationImage(image: AssetImage("assets/bg_a.png")),
//         //       borderRadius: BorderRadius.all(
//         //         Radius.circular(5),
//         //       ),
//         //     ),
//         //     child: Container(
//         //       width: scr.width * .46,
//         //       height: scr.width * .4,
//         //       padding: const EdgeInsets.all(10),
//         //       decoration: BoxDecoration(
//         //           gradient: LinearGradient(
//         //             begin: Alignment.topCenter,
//         //             end: Alignment.bottomCenter,
//         //             colors: [
//         // Color(0x99000000),
//         //                         Color(0x00000000),
//         //                         Color(0x99000000)
//         //             ],
//         //           ),
//         //           borderRadius: BorderRadius.all(Radius.circular(8))),
//         //       child: Container(
//         //         child: Column(
//         //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         //           children: const [
//         //             Text(
//         //               "Team Booking",
//         //               textAlign: TextAlign.center,
//         //               style: TextStyle(
//         //                 color: Colors.white,
//         //                 fontWeight: FontWeight.bold,
//         //                 fontSize: 20,
//         //               ),
//         //             ),
//         //             Text(
//         //               "Do you have your team with you? Book hear",
//         //               textAlign: TextAlign.center,
//         //               style: TextStyle(
//         //                 color: Colors.white,
//         //                 fontWeight: FontWeight.bold,
//         //                 fontSize: 12,
//         //               ),
//         //             ),
//         //           ],
//         //         ),
//         //       ),
//         //     ),
//         //   ),
//         // ),
//       ],
//     );
//   }
// }
