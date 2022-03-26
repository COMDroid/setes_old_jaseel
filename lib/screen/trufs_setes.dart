import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:setes_mobile/method/truf.dart';
import 'package:setes_mobile/module/date_picker.dart';
import 'package:setes_mobile/module/simple.dart';
import 'package:setes_mobile/screen/truf_book_setes.dart';
import 'package:setes_mobile/screen/warnings.dart';
import 'package:url_launcher/url_launcher.dart';

class TrufsSetesPage extends StatelessWidget {
  final String date;
  const TrufsSetesPage(this.date, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F9FE),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SafeArea(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(Icons.arrow_back_ios,
                                  size: 28, color: Colors.black54),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                SizedBox(height: 5),
                                Text(
                                  "Setes Booking",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black87,
                                      fontSize: 20),
                                ),
                                Text(
                                  "Book Your Match",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black54,
                                      fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Image.asset("assets/bg_a.png")
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 82,
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
              child: SetesTrufLoader(this),
            ),
          ),
        ],
      ),
    );
  }
}

class SetesTrufLoader extends StatelessWidget {
  final dynamic props;
  const SetesTrufLoader(this.props, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);
    return FutureBuilder(
      future: getTrufs(props.date, context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.hasError) {
            return const Expanded(child: ErrorBody());
          }
          if (jsonDecode(snapshot.data.toString())[0]) {
            return const Expanded(child: ErrorBody());
          }
          var datas = jsonDecode(snapshot.data.toString())[1];
          return ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              SizedBox(height: scr.width * .7),
              Container(
                constraints: BoxConstraints(
                  minHeight: scr.height - (scr.width * .5 + 90),
                ),
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: scr.width * .05,
                        vertical: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Setes Vennes",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                              fontSize: 20,
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 5),
                              InkWell(
                                onTap: () => setDate(context),
                                child: Row(
                                  children: [
                                    Text(
                                      getDateName(props.date),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black38,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    const Icon(
                                      Icons.calendar_today,
                                      size: 23,
                                      color: Colors.blue,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    for (var i = 0; i < datas.length; i++)
                      EachSetesTruf(datas[i], props),
                  ],
                ),
              ),
            ],
          );
        } else {
          return const Loading();
        }
      },
    );
  }
}

class EachSetesTruf extends StatelessWidget {
  final Map data;
  final dynamic props;
  const EachSetesTruf(this.data, this.props, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);

    return Container(
      margin: const EdgeInsets.all(13),
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(7)),
        color: Color(0xffE2F9FF),
      ),
      height: 100,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data["name"],
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                            data["raiting"] > 0
                                ? Icons.star
                                : Icons.star_border,
                            color: const Color(0xff193B8B),
                            size: 16),
                        Icon(
                            data["raiting"] > 10
                                ? Icons.star
                                : Icons.star_border,
                            color: const Color(0xff193B8B),
                            size: 16),
                        Icon(
                            data["raiting"] > 20
                                ? Icons.star
                                : Icons.star_border,
                            color: const Color(0xff193B8B),
                            size: 16),
                        Icon(
                            data["raiting"] > 30
                                ? Icons.star
                                : Icons.star_border,
                            color: const Color(0xff193B8B),
                            size: 16),
                        Icon(
                            data["raiting"] > 40
                                ? Icons.star
                                : Icons.star_border,
                            color: const Color(0xff193B8B),
                            size: 16),
                      ],
                    ),
                    Row(
                      children: [
                        Text(data["distance"] ?? "-"),
                        InkWell(
                          onTap: () async {
                            var _url =
                                "https://maps.google.com/?q=${data['lat']},${data['lon']}";
                            if (!await launch(_url)) {
                              throw 'Could not launch $_url';
                            }
                          },
                          child: const Icon(
                            Icons.directions,
                            color: Color.fromARGB(188, 25, 59, 139),
                          ),
                        ),
                        SizedBox(width: scr.width * .02),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.location_on,
                        color: Colors.black54, size: 16),
                    const SizedBox(width: 3),
                    Expanded(
                      child: Text(
                        data["location"],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black54,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (var i = 0; (i < 2 && i < data['slots'].length); i++)
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            TrufBookSetesPage(data, i, props.date),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 3, vertical: 2.5),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        border: Border.all(width: 1, color: Colors.black54)),
                    child: Text(
                      slot24to12(data['slots'][i]),
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }
}
