import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:setes_mobile/method/bookings.dart';
import 'package:setes_mobile/screen/warnings.dart';

class MyBookings extends StatelessWidget {
  const MyBookings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Bookingss")),
      body: FutureBuilder(
        future: getBookings(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (jsonDecode(snapshot.data.toString())[0]) {
              return ErrorBody();
            } else {
              var datas = jsonDecode(snapshot.data.toString())[1];
              print(datas.length);
              return BookingsBody(datas);
            }
          } else {
            return Loading();
          }
        },
      ),
    );
  }
}

class BookingsBody extends StatelessWidget {
  final List noti;
  const BookingsBody(this.noti, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 5),
        for (var i = 0; i < noti.length; i++)
          InkWell(
            onTap: () {
              if (noti[i].containsKey("bid_id")) {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => Bid(noti[i]['bid_id'], uLang),
                //   ),
                // );
              }
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
                  //   const Icon(
                  //     Icons.notifications_active_outlined,
                  //     size: 35,
                  //     color: Colors.yellow,
                  //   ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Notification",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color.fromARGB(160, 0, 0, 0),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "klk",
                          // noti[i]["booking"]['created'].split("G")[0],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color.fromARGB(180, 100, 10, 100),
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "sub",
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
