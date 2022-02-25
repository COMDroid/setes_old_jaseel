import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:setes_mobile/method/truf.dart';
import 'package:setes_mobile/module/api_init.dart';
import 'package:setes_mobile/module/datePicker.dart';
import 'package:setes_mobile/module/simple.dart';
import 'package:setes_mobile/screen/truf_book_setes.dart';
import 'package:setes_mobile/screen/warnings.dart';

class TrufsTeamPage extends StatelessWidget {
  final String date;
  const TrufsTeamPage(this.date, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);

    return Scaffold(
      backgroundColor: Color(0xffC1E4DE),
      body: SizedBox(
        width: scr.width,
        height: scr.height,
        child: Column(
          children: [
            Container(
              height: scr.width,
              width: scr.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/bg_team.png"),
                  fit: BoxFit.contain,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
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
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              size: 28,
                              color: Colors.white70,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              SizedBox(height: 5),
                              Text(
                                "Team Booking",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    fontSize: 20),
                              ),
                              Text(
                                "Corts For You",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white60,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () => setDate(context, "t"),
                        icon: const Icon(
                          Icons.calendar_today,
                          size: 28,
                          color: Colors.black87,
                        ),
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
                    top: -scr.width,
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
                          child: TeamTrufLoader(this),
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

class TeamTrufLoader extends StatelessWidget {
  final dynamic props;
  const TeamTrufLoader(this.props, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);
    return FutureBuilder(
      future: getTrufs("t", props.date),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (jsonDecode(snapshot.data.toString())[0]) {
            return const Expanded(child: ErrorBody());
          } else {
            var datas = jsonDecode(snapshot.data.toString())[1];
            return ListView(
              children: [
                SizedBox(height: scr.width * .5),
                Container(
                  constraints: BoxConstraints(
                      minHeight: scr.height - (scr.width * .5 + 90)),
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
                          vertical: 15,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    Text(
                                      getDateName(props.date) +
                                          " Perinthalmanna",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black54,
                                          fontSize: 12),
                                    ),
                                    const SizedBox(width: 5),
                                    const Icon(
                                      Icons.location_on,
                                      size: 18,
                                      color: Colors.black54,
                                    )
                                  ],
                                ),
                                const Text(
                                  "Setes Vennes",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black87,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                            const Icon(
                              Icons.search_sharp,
                              size: 40,
                              color: Color(0xff0E6E9D),
                            ),
                          ],
                        ),
                      ),
                      for (var i = 0; i < datas.length; i++)
                        EachTeamTruf(datas[i], props),
                    ],
                  ),
                ),
              ],
            );
          }
        } else {
          return const Loading();
        }
      },
    );
  }
}

class EachTeamTruf extends StatelessWidget {
  final Map data;
  final dynamic props;
  const EachTeamTruf(this.data, this.props, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Choose Slot'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    for (var i = 0; i < data["slots"].length; i++)
                      ListTile(
                        onTap: () {
                          if (data["slots"][i]["booked"]) {
                            return;
                          }
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      TrufBookSetesPage(data, i, props.date)));
                        },
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(data["slots"][i]["ground"]),
                            Text(
                              data["slots"][i]["booked"]
                                  ? "Not Available"
                                  : "Available",
                              style: TextStyle(
                                  color: data["slots"][i]["booked"]
                                      ? Colors.red
                                      : Colors.green),
                            ),
                          ],
                        ),
                        subtitle: Text(data["slots"][i]["s_time"] +
                            " - " +
                            data["slots"][i]["e_time"]),
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
        padding: const EdgeInsets.all(6),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(7)),
          color: Color(0xffE2F9FF),
        ),
        height: 100,
        child: Row(
          children: [
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    data["name"],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: const [
                      Icon(Icons.star, color: Color(0xff193B8B), size: 16),
                      Icon(Icons.star, color: Color(0xff193B8B), size: 16),
                      Icon(Icons.star, color: Color(0xff193B8B), size: 16),
                      Icon(Icons.star, color: Color(0xff193B8B), size: 16),
                      Icon(Icons.star_half, color: Color(0xff193B8B), size: 16),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.grass, color: Colors.green, size: 16),
                      const SizedBox(width: 3),
                      Expanded(
                        child: Text(
                          data["slots"][0]["ground"] +
                              (data["slots"].length > 1
                                  ? " and " +
                                      (data["slots"].length - 1).toString() +
                                      " more.."
                                  : ""),
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black54,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.location_on,
                          color: Colors.red, size: 16),
                      const SizedBox(width: 3),
                      Expanded(
                        child: Text(
                          data["location"],
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
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              child: Image.network(setImgTruf(data["_id"], data["img"][0]),
                  width: 100, height: 88, fit: BoxFit.cover),
            ),
          ],
        ),
      ),
    );
  }
}
