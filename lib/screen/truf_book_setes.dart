import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:setes_mobile/method/bookings.dart';
import 'package:setes_mobile/method/truf.dart';
import 'package:setes_mobile/module/api_init.dart';
import 'package:setes_mobile/module/gb_var.dart';
import 'package:setes_mobile/module/simple.dart';
import 'package:setes_mobile/screen/profile.dart';
import 'package:setes_mobile/screen/warnings.dart';
import 'package:setes_mobile/widget/walet_peyment_popup.dart';

class TrufBookSetesPage extends StatelessWidget {
  final Map truf;
  final int i;
  final String date;

  const TrufBookSetesPage(this.truf, this.i, this.date, {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    String slotId = truf['slots'][i]["_id"].toString();
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        iconTheme: const IconThemeData(color: Colors.black87),
        shadowColor: Colors.blue[50],
        backgroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Text(
              truf["name"],
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                  fontSize: 20),
            ),
            Text(
              truf["location"],
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black45,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: getSlot(slotId, date),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (jsonDecode(snapshot.data.toString())[0]) {
              return const Expanded(child: ErrorBody());
            } else {
              var slot = jsonDecode(snapshot.data.toString())[1];
              var status = 'BOOK NOW';
              var count = int.parse(slot['ground'].split('x')[0]);
              var bookedCount = slot['authers'].length;
              for (var i = 0; i < bookedCount; i++) {
                if (slot['authers'][i]['_id'] == gbUserId) {
                  status = 'BOOKED';
                  break;
                }
              }
              if (status == 'BOOK NOW') {
                if (bookedCount == count) status = 'SLOT FULL';
              }
              return TrufBookBody(this, slot, date, status);
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
  final dynamic props, slot, date, status;
  const TrufBookBody(this.props, this.slot, this.date, this.status, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);
    List imgs = props.truf["img"];

    return Column(
      children: [
        SizedBox(
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
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            spreadRadius: 5,
                            blurRadius: 10,
                            color: Colors.black12)
                      ],
                      color: Colors.black12,
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
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
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(width: 1.5, color: Colors.black12)),
                  child: ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Text(
                                    getDateName(date) +
                                        "  " +
                                        slot["s_time"] +
                                        " - " +
                                        slot["e_time"],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  const Icon(
                                    Icons.timelapse,
                                    size: 18,
                                    color: Colors.black54,
                                  ),
                                ],
                              ),
                              const Text(
                                "Play List",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.layers_rounded,
                            size: 40,
                            color: Color(0xffCF595A),
                          )
                        ],
                      ),
                      if (slot["authers"] != null)
                        for (var i = 0; i < slot["authers"].length; i++)
                          InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfiePage(
                                  slot["authers"][i],
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      slot["authers"][i]["name"],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                        fontSize: 14.5,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      slot["authers"][i]["id"] ?? '',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black38,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: slot["authers"][i]["img"] == null
                                      ? const Icon(Icons.person,
                                          size: 35, color: Colors.black54)
                                      : ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(18),
                                          ),
                                          child: Image.network(
                                            setImgUser(slot["authers"][i]),
                                            height: 36,
                                            width: 36,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ),
                      if (slot["authers"] != null)
                        if (slot["authers"].length == 0)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              SizedBox(height: 80),
                              Text(
                                "No Players",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                    ],
                  ),
                )
              : const SizedBox(),
        ),
        Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 22),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      props.truf["name"],
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontSize: 16),
                    ),
                    Text(
                      toint(slot["price"]) + "/-",
                      style: const TextStyle(
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
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black45,
                          fontSize: 13),
                    ),
                    Text(
                      "Time : " + slot["s_time"] + " - " + slot["e_time"],
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.black45,
                          fontSize: 13),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: scr.width - 100,
                      child: Text(
                        props.truf["location"],
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.black45,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const Text(
                      "1 hour",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.black45,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            )),
        InkWell(
          onTap: () async {
            showDialog<void>(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context1) {
                return const AlertDialog(title: Text("Loading.."));
              },
            );
            List verRes = await verifyBookingTruf(this);
            Navigator.pop(context);
            if (!verRes[0]) {
              showDialog<void>(
                context: context,
                builder: (BuildContext context1) {
                  return AlertDialog(title: Text(verRes[1]));
                },
              );
              return;
            }
            var accountType = 0;
            showDialog<void>(
              context: context,
              builder: (BuildContext context1) {
                return AlertDialog(
                  title: const Text('Pay from'),
                  content: WaletPaymentPopup(
                    verRes[1],
                    slot['price'],
                    (v) => accountType = v,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        if (accountType == 2) {
                          makeBookingpyment(this, slot, context);
                        } else {
                          bookFromWallet(
                            this,
                            context,
                            accountType == 0 ? "wallet" : "credit",
                          );
                        }
                      },
                      child: const Text('Confirm '),
                    )
                  ],
                );
              },
            );
          },
          child: Container(
            height: 50,
            width: scr.width,
            margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(7)),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(2, 3),
                  spreadRadius: 0,
                  blurRadius: 10,
                  color: Color(0x33000000),
                ),
              ],
              gradient: LinearGradient(
                colors: status == "BOOK NOW"
                    ? const [Color(0xffCE5859), Color(0xffEF8464)]
                    : const [
                        Color.fromARGB(255, 173, 173, 173),
                        Color.fromARGB(255, 226, 226, 226)
                      ],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  status,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                Text(
                  toint(slot["price"]) + "/-",
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
