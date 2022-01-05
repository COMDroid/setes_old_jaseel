import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:setes_mobile/method/truf.dart';
import 'package:setes_mobile/module/api_init.dart';
import 'package:setes_mobile/module/simple.dart';
import 'package:setes_mobile/screen/trufs_setes.dart';
import 'package:setes_mobile/screen/trufs_team.dart';
import 'package:setes_mobile/screen/warnings.dart';

class TrufBookSetesPage extends StatelessWidget {
  final Map truf;
  final int i;
  final String date;
  TrufBookSetesPage(this.truf, this.i, this.date, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String slot_id = truf['slots'][i]["_id"].toString();
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        iconTheme: IconThemeData(color: Colors.black87),
        shadowColor: Colors.blue[50],
        backgroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5),
            Text(
              truf["name"],
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                  fontSize: 20),
            ),
            Text(
              truf["location"],
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black45,
                  fontSize: 12),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: getSlot(slot_id, date),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (jsonDecode(snapshot.data.toString())[0]) {
              return Expanded(child: ErrorBody());
            } else {
              var slot = jsonDecode(snapshot.data.toString())[1];
              return TrufBookBody(this, slot, date);
            }
          } else {
            return const LoadingPage();
          }
        },
      ),
    );
  }
}

class TrufBookBody extends StatelessWidget {
  final props, slot, date;
  const TrufBookBody(this.props, this.slot, this.date, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);
    List imgs = props.truf["img"];
    return Column(
      children: [
        Container(
          width: scr.width,
          height: scr.width * .5,
          child: CarouselSlider(
            options: CarouselOptions(
              height: scr.width * .4,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 0.4,
              aspectRatio: 2.0,
              initialPage: 2,
            ),
            items: imgs.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 5,
                            blurRadius: 10,
                            color: Colors.black12)
                      ],
                      color: Colors.black12,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      image: DecorationImage(
                        image: NetworkImage(setImgTruf(props.truf["_id"], i)),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
        Expanded(
          child: slot['type'] == "s"
              ? Container(
                  margin: EdgeInsets.symmetric(
                    vertical: scr.height * .02,
                    horizontal: scr.width * .05,
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: scr.height * .02,
                    horizontal: scr.width * .05,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(width: 1.5, color: Colors.black12)),
                  child: ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Text(
                                    getDateName(date) +
                                        "  " +
                                        slot["s_time"] +
                                        " - " +
                                        slot["e_time"],
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black54,
                                        fontSize: 12),
                                  ),
                                  SizedBox(width: 5),
                                  Icon(
                                    Icons.timelapse,
                                    size: 18,
                                    color: Colors.black54,
                                  )
                                ],
                              ),
                              Text(
                                "Play List",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black87,
                                    fontSize: 20),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.layers_rounded,
                            size: 40,
                            color: Color(0xffCF595A),
                          )
                        ],
                      ),
                      if (slot["authers"] != null)
                        for (var i = 0; i < slot["authers"].length; i++)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    slot["authers"][i]["name"],
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                        fontSize: 14.5),
                                  ),
                                  SizedBox(height: 3),
                                  Text(
                                    slot["authers"][i]["id"],
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black38,
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: slot["authers"][i]["img"] == null
                                    ? Icon(Icons.person,
                                        size: 35, color: Colors.black54)
                                    : ClipRRect(),
                              ),
                            ],
                          ),
                      if (slot["authers"] != null)
                        if (slot["authers"].length == 0)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 80),
                              Text(
                                "No Players",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                    ],
                  ),
                )
              : SizedBox(),
        ),
        Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 22),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      props.truf["name"],
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontSize: 16),
                    ),
                    Text(
                      slot["price"] + "/-",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontSize: 15),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Ground: " + slot["ground"],
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black45,
                          fontSize: 13),
                    ),
                    Text(
                      "Time : " + slot["s_time"] + " - " + slot["e_time"],
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.black45,
                          fontSize: 13),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      props.truf["location"],
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.black45,
                          fontSize: 13),
                    ),
                    Text(
                      "1 hour",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.black45,
                          fontSize: 13),
                    ),
                  ],
                ),
              ],
            )),
        InkWell(
          onTap: () {
            showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Confirm Book'),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[Text('Payment Gate way')],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        var res = await bookTruf(this);
                        if (res[0]) {
                          Navigator.pop(context);
                          showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Error Booking'),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: <Widget>[Text(res[1]["msg"])],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('Back'))
                                ],
                              );
                            },
                          );
                        } else {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                          showDialog<void>(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Succesfully Booked'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              slot["type"] == "s"
                                                  ? TrufsSetesPage(date)
                                                  : TrufsTeamPage(date),
                                        ),
                                      );
                                    },
                                    child: Text('Back'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: Text('Confirm '),
                    )
                  ],
                );
              },
            );
          },
          child: Container(
            height: 50,
            width: scr.width,
            margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(7)),
              boxShadow: [
                BoxShadow(
                  offset: Offset(2, 3),
                  spreadRadius: 0,
                  blurRadius: 10,
                  color: Color(0x33000000),
                ),
              ],
              gradient: LinearGradient(
                  colors: [Color(0xffCE5859), Color(0xffEF8464)]),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "BOOK NOW",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 20),
                ),
                Text(
                  slot["price"] + "/-",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 20),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
