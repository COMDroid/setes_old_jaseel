import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:setes_mobile/method/truf.dart';
import 'package:setes_mobile/module/datePicker.dart';
import 'package:setes_mobile/module/simple.dart';
import 'package:setes_mobile/screen/truf_book_setes.dart';
import 'package:setes_mobile/screen/warnings.dart';

class TrufsSetesPage extends StatelessWidget {
  final String date;
  const TrufsSetesPage(this.date, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);
    return Scaffold(
      backgroundColor: const Color(0xFFE0F9FE),
      body: SizedBox(
        width: scr.width,
        height: scr.height,
        child: Column(
          children: [
            Container(
              height: scr.width,
              width: scr.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/bg_a.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SafeArea(
                  child: Row(
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
                ),
              ),
            ),
            Expanded(
              child: Stack(
                overflow: Overflow.visible,
                children: [
                  Positioned(
                    top: -scr.width + 70,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: SafeArea(
                      child: Container(
                        margin: const EdgeInsets.only(top: 65),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(35),
                            topRight: Radius.circular(35),
                          ),
                          child: SetesTrufLoader(this),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
      future: getTrufs("s", props.date, context),
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
            children: [
              SizedBox(height: scr.width * .5),
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
                                fontSize: 20),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 5),
                              InkWell(
                                onTap: () => setDate(context, "s"),
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
    return InkWell(
      onTap: () {
        var st = data["slots"];
        showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Choose Slot'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    for (var i = 0; i < st.length; i++)
                      ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TrufBookSetesPage(data, i, props.date),
                            ),
                          );
                        },
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(st[i]["ground"]),
                            Text(
                              st[i]["booked"] ? "Not Available" : "Available",
                              style: TextStyle(
                                  color: st[i]["booked"]
                                      ? Colors.red
                                      : Colors.green),
                            ),
                          ],
                        ),
                        subtitle: Text(
                          st[i]["s_time"] + " - " + st[i]["e_time"],
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Container(
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
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Icon(data["raiting"] > 0 ? Icons.star : Icons.star_border,
                          color: const Color(0xff193B8B), size: 16),
                      Icon(
                          data["raiting"] > 10 ? Icons.star : Icons.star_border,
                          color: const Color(0xff193B8B),
                          size: 16),
                      Icon(
                          data["raiting"] > 20 ? Icons.star : Icons.star_border,
                          color: const Color(0xff193B8B),
                          size: 16),
                      Icon(
                          data["raiting"] > 30 ? Icons.star : Icons.star_border,
                          color: const Color(0xff193B8B),
                          size: 16),
                      Icon(
                          data["raiting"] > 40 ? Icons.star : Icons.star_border,
                          color: const Color(0xff193B8B),
                          size: 16),
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
              children: [
                for (var i = 0; (i < 3 && i < data['slots'].length); i++)
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 3, vertical: 2.5),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 7, vertical: 1),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        border: Border.all(width: 1, color: Colors.black54)),
                    child: Text(
                      data['slots'][i]['s_time'] +
                          " - " +
                          data['slots'][i]['e_time'] +
                          "  " +
                          data['slots'][i]["ground"],
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
