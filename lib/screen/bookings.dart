import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:setes_mobile/method/bookings.dart';
import 'package:setes_mobile/screen/warnings.dart';

class MyBookings extends StatelessWidget {
  const MyBookings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff459ADB),
        title: const Text("My Bookingss"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MyBookings(),
                ),
              );
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getBookings(),
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
                      "No Bookings",
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                );
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
  final List bookings;
  const BookingsBody(this.bookings, {Key? key}) : super(key: key);

  setIcon(s) {
    if (s == "Booked") return Icons.book_online;
    if (s == "Started") return Icons.sports_football;
    if (s == "Fulltime") return Icons.sports;
    if (s == "Cancel") return Icons.error;
    return Icons.info;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 5),
        for (var i = 0; i < bookings.length; i++)
          InkWell(
            onTap: () {
              if (bookings[i].containsKey("bid_id")) {
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
                  Icon(
                    setIcon(bookings[i]["booking"]['status']),
                    size: 35,
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bookings[i]["slot"]['truf_name'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color.fromARGB(160, 0, 0, 0),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Booking : (" +
                              bookings[i]["slot"]['ground'] +
                              ") " +
                              bookings[i]["slot"]['s_time'] +
                              " - " +
                              bookings[i]["slot"]['e_time'] +
                              ", " +
                              bookings[i]["booking"]['date'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color.fromARGB(180, 100, 10, 100),
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          "Created On : " +
                              bookings[i]["booking"]['created'].split("T")[0],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color.fromARGB(160, 0, 0, 0),
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
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
