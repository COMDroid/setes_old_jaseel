import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:setes_mobile/module/gb_var.dart';
import 'package:setes_mobile/module/simple.dart';

class MyStuf extends StatelessWidget {
  const MyStuf({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);
    String inviteLink = "https://www.setes.in/invite/" + gbUserId;
    return Container(
      color: const Color(0xffF1F5F9),
      child: Column(
        children: [
          Container(
            width: scr.width,
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
            child: const SafeArea(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  "My Stuff",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(0),
              children: [
                const SizedBox(height: 20),
                for (var i = 0; i < 2; i++)
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 20),
                    width: scr.width,
                    decoration: const BoxDecoration(
                      color: Color(0xffF1F5F9),
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          spreadRadius: 7,
                          color: Color(0x11000000),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          i == 0 ? Icons.wallet_giftcard : Icons.wallet_travel,
                          size: 30,
                        ),
                        const SizedBox(width: 20),
                        SizedBox(
                          width: scr.width - 130,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                i == 0 ? "Setes Wallet" : "Setes Credits",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "₹ " +
                                    (i == 0
                                        ? toint(gbUser["wallet"])
                                        : toint(gbUser["credit"])),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 20,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 7),
                              const Text(
                                "You can use the setes credit for some type of payment in setes community",
                                style: TextStyle(
                                  color: Colors.black38,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                  width: scr.width,
                  decoration: const BoxDecoration(
                    color: Color(0xffF1F5F9),
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        spreadRadius: 7,
                        color: Color(0x11000000),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.group_add, size: 30),
                      const SizedBox(width: 20),
                      SizedBox(
                        width: scr.width - 130,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Invite and Earn",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "₹ 25",
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 20,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 7),
                            const Text(
                              "Invite your friends, you can earn minimum of 25 setes credits, share this link with your friends",
                              style: TextStyle(
                                color: Colors.black38,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 7),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Colors.black12,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      inviteLink,
                                      style: const TextStyle(
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      FlutterClipboard.copy(inviteLink)
                                          .then((value) {});
                                    },
                                    child: const Icon(
                                      Icons.copy,
                                      size: 20,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  InkWell(
                                    onTap: () async {
                                      await FlutterShare.share(
                                        title: 'Setes',
                                        text: 'Join Setes, Exptore football world',
                                        linkUrl: inviteLink,
                                        chooserTitle: 'Example Chooser Title',
                                      );
                                    },
                                    child: const Icon(
                                      Icons.share,
                                      size: 20,
                                      color: Colors.black54,
                                    ),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
