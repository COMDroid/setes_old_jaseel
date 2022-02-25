import 'package:flutter/material.dart';
import 'package:setes_mobile/module/api_init.dart';
import 'package:setes_mobile/module/simple.dart';

class ScoreBordLineUp extends StatelessWidget {
  final List teams;
  const ScoreBordLineUp(this.teams, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);
    double xw = scr.width * .9 - 4;
    double xh = scr.width * .9 * 1.3 - 4;
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
          for (var i = 0; i < teams.length; i++)
            if (teams[i]['pos_xy'] != null)
              GetEachPlayer(
                teams[i]['pos_xy']['x'] * xw,
                teams[i]['pos_xy']['y'] * xh,
                teams[i],
              ),
        ],
      ),
    );
  }
}

class GetEachPlayer extends StatelessWidget {
  final Map user;
  final double x, y;
  const GetEachPlayer(this.x, this.y, this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);
    return Positioned(
      top: y - 36,
      left: x - 36,
      width: 64,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(2),
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color.fromARGB(211, 167, 167, 167),
              border: Border.all(
                width: 2,
                color: user["team"] == 'r'
                    ? const Color.fromARGB(255, 182, 18, 6)
                    : Colors.blue,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(22)),
            ),
            alignment: Alignment.center,
            child: user["img"] != null
                ? ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(scr.height * .07),
                    ),
                    child: Image.network(
                      setImgUser(user),
                      fit: BoxFit.cover,
                      width: 36,
                      height: 36,
                    ),
                  )
                : const Icon(Icons.person, size: 28, color: Colors.black38),
          ),
          SizedBox(
            width: 64,
            child: Text(
              user["name"].toString(),
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white, fontSize: 13),
            ),
          )
        ],
      ),
    );
  }
}
