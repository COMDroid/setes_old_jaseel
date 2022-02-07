import 'package:flutter/material.dart';
import 'package:setes_mobile/module/simple.dart';
import 'package:setes_mobile/screen_widget/home_scorebord.dart';
import 'package:setes_mobile/widget/scorebord_lineup.dart';
import 'package:setes_mobile/widget/scorebord_status.dart';

class ScoreBordScreen extends StatelessWidget {
  final Map match;
  const ScoreBordScreen(this.match, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              (match['slot'] == null
                  ? "Unnamed"
                  : match['slot']["truf_name"] ?? ''),
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Perinthalmanna",
              style: TextStyle(
                color: Colors.black38,
                fontSize: 15,
              ),
            ),
          ],
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Today",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                Text(
                  "12:26 Monday",
                  style: TextStyle(color: Colors.black54),
                )
              ],
            ),
          ),
        ],
      ),
      body: ScoreBoardBody(match),
    );
  }
}

class ScoreBoardBody extends StatefulWidget {
  final Map match;
  const ScoreBoardBody(this.match, {Key? key}) : super(key: key);

  @override
  _ScoreBoardBodyState createState() => _ScoreBoardBodyState();
}

class _ScoreBoardBodyState extends State<ScoreBoardBody> {
  int p = 0;

  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(
              horizontal: scr.width * .03,
              vertical: scr.height * .02,
            ),
            child: EachScore(widget.match)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: scr.width * .08),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < 2; i++)
                InkWell(
                  onTap: () => setState(() => p = i),
                  child: Padding(
                    padding: EdgeInsets.only(right: scr.width * .05),
                    child: Column(
                      children: [
                        if (i != p) SizedBox(height: 4),
                        Text(
                          i == 0 ? "LineUp" : "Status",
                          style: i == p
                              ? TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                )
                              : TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: Colors.black45,
                                ),
                        ),
                        if (i == p)
                          Container(
                            height: 6,
                            width: 20,
                            margin: EdgeInsets.only(top: 8),
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.all(
                                Radius.circular(3),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: scr.height * .02,
            left: scr.width * .02,
            right: scr.width * .02,
          ),
          decoration: BoxDecoration(
            color: p == 0 ? Color(0xff109D58) : Colors.white,
            border: Border.all(width: 1, color: Colors.black12),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(scr.width * .12),
              topRight: Radius.circular(scr.width * .12),
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: scr.width * .06,
                  vertical: scr.height * .02,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          p == 0 ? "LineUp" : "Status",
                          style: TextStyle(
                            fontSize: 18,
                            color: p == 0 ? Colors.white : null,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Red vs Blue",
                          style: TextStyle(
                            color: p == 0 ? Colors.white : Colors.black54,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    Icon(Icons.layers, size: 30, color: Colors.redAccent),
                  ],
                ),
              ),
              SizedBox(
                height: scr.height - (312 + scr.height * .1),
                child: SingleChildScrollView(
                  child: p == 0 ? ScoreBordLineUp() : ScoreBordStatus(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
