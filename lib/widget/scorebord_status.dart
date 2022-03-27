import 'package:flutter/material.dart';
import 'package:setes_mobile/module/simple.dart';

class ScoreBordStatus extends StatelessWidget {
  final Map events;
  const ScoreBordStatus(this.events, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);
    print(events['ycs']);
    List status = [
      {
        "r": events['goals']['r'].toString(),
        "b": events['goals']['b'].toString(),
        "title": "GOALS",
      },
      {
        "r": events['possessions']['r'].toString(),
        "b": events['possessions']['b'].toString(),
        "title": "POSSESSION"
      },
      {
        "r": events['shots']['r'].toString(),
        "b": events['shots']['b'].toString(),
        "title": "TOTAL ShOTS"
      },
      {"r": "", "b": "", "title": "SHOTS ON TARGET"},
      {
        "r": events['fouls']['r'].toString(),
        "b": events['fouls']['b'].toString(),
        "title": "FOULS COMMITED"
      },
      {
        "r": events['ycs']['r'].toString(),
        "b": events['ycs']['b'].toString(),
        "title": "YELLOW CARDS"
      },
      {
        "r": events['rcs']['r'].toString(),
        "b": events['rcs']['b'].toString(),
        "title": "RED CARDS"
      },
      {
        "r": events['corners']['r'].toString(),
        "b": events['corners']['b'].toString(),
        "title": "CORNER"
      },
    ];

    return Container(
      margin: EdgeInsets.only(
        left: scr.width * .04,
        right: scr.width * .04,
        bottom: scr.width * .04,
      ),
      height: scr.height - 400,
      width: scr.width * .9,
      child: ListView(
        children: [
          for (var i = 0; i < status.length; i++)
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    status[i]['r'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    status[i]['title'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black38,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    status[i]['b'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
