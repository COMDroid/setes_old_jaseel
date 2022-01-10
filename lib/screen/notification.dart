import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:setes_mobile/method/notifications.dart';
import 'package:setes_mobile/screen/warnings.dart';

class MyNotification extends StatelessWidget {
  const MyNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff459ADB),
        title: const Text("My Notifications"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MyNotification(),
                ),
              );
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getNotification(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (jsonDecode(snapshot.data.toString())[0]) {
              return ErrorBody();
            } else {
              var datas = jsonDecode(snapshot.data.toString())[1];
              if (datas.length == 0)
                return Center(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "No Notifications",
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                );
              return NotificationBody(datas);
            }
          } else {
            return Loading();
          }
        },
      ),
    );
  }
}

class NotificationBody extends StatelessWidget {
  final List noti;
  const NotificationBody(this.noti, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 5),
        for (var i = 0; i < noti.length; i++)
          InkWell(
            onTap: () {
              // if (noti[i].containsKey("bid_id")) {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => Bid(noti[i]['bid_id'], uLang),
              //   ),
              // );
              // }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(width: 1, color: const Color(0x11000000)),
              ),
              child: Row(
                children: [
                  // if (noti[i]['type'] == "rn")
                  //   Image.asset("asset/comments.png", width: 35)
                  // else if (noti[i]['type'] == "an")
                  //   Image.asset("asset/chat.png", width: 35)
                  // else if (noti[i]['type'] == "b")
                  //   Image.asset("asset/text.png", width: 35)
                  // else
                  const Icon(
                    Icons.notifications_active_outlined,
                    size: 35,
                    color: Colors.yellow,
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              noti[i]['title'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Color.fromARGB(160, 0, 0, 0),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              noti[i]['type'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color.fromARGB(160, 0, 0, 0),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          noti[i]['created'].split("T")[0],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color.fromARGB(180, 100, 10, 100),
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          noti[i]['sub_title'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color.fromARGB(160, 0, 0, 0),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
