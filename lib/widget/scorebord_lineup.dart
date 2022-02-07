
import 'package:flutter/material.dart';
import 'package:setes_mobile/module/api_init.dart';
import 'package:setes_mobile/module/simple.dart';

class ScoreBordLineUp extends StatelessWidget {
  const ScoreBordLineUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);
    double xw = scr.width * .9;
    double xh = scr.width * .9 * 1.3;
    double xwX = xw - scr.width * .02;
    return Container(
      margin: EdgeInsets.only(
        left: scr.width * .04,
        right: scr.width * .04,
        bottom: scr.width * .04,
      ),
      height: xh,
      width: xw,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white70, width: 2),
      ),
      child: Stack(
        children: [
          Positioned(
            top: xh * .5 - 1,
            left: 0,
            right: 0,
            child: Container(color: Colors.white70, height: 2),
          ),
          for (var i = 0; i < 2; i++)
            Positioned(
              top: i == 0 ? -2 : null,
              bottom: i == 1 ? -2 : null,
              left: xw * .3,
              right: xw * .3,
              height: xh * .15,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white70, width: 2),
                ),
              ),
            ),
          for (var i = 0; i < 2; i++)
            Positioned(
              top: i == 0 ? -2 : null,
              bottom: i == 1 ? -2 : null,
              left: xw * .4,
              right: xw * .4,
              height: xh * .08,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white70, width: 2),
                ),
              ),
            ),
          GetEachPlayer(xwX * .5, xh * .1),
          GetEachPlayer(xwX * .25, xh * .25),
          GetEachPlayer(xwX * .5, xh * .25),
          GetEachPlayer(xwX * .75, xh * .25),
          GetEachPlayer(xwX * .25, xh * .4),
          GetEachPlayer(xwX * .5, xh * .4),
          GetEachPlayer(xwX * .75, xh * .4),
          GetEachPlayer(xwX * .5, xh * .9),
          GetEachPlayer(xwX * .25, xh * .75),
          GetEachPlayer(xwX * .5, xh * .75),
          GetEachPlayer(xwX * .75, xh * .75),
          GetEachPlayer(xwX * .25, xh * .6),
          GetEachPlayer(xwX * .5, xh * .6),
          GetEachPlayer(xwX * .75, xh * .6),
        ],
      ),
    );
  }
}

class GetEachPlayer extends StatelessWidget {
  final double x, y;
  const GetEachPlayer(this.x, this.y, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);
    return Positioned(
      top: y - 32,
      left: x - 32,
      width: 64,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(2),
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: Color(0xd44000000),
              border: Border.all(width: 2, color: Colors.white70),
              borderRadius: BorderRadius.all(Radius.circular(22)),
            ),
            alignment: Alignment.center,
            child: null != null
                ? ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(scr.height * .07),
                    ),
                    child: Image.network(
                      setImgProfile(""),
                      fit: BoxFit.cover,
                      width: 36,
                      height: 36,
                    ),
                  )
                : Icon(Icons.person, size: 28, color: Colors.black38),
          ),
          SizedBox(
            width: 64,
            child: Text(
              "Guest",
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
          )
        ],
      ),
    );
  }
}


