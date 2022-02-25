import 'package:flutter/material.dart';
import 'package:setes_mobile/module/simple.dart';

class ScoreBordStatus extends StatelessWidget {
  final List events;
  const ScoreBordStatus(this.events, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);
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
          for (var i = 0; i < events.length; i++)
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        events[i]['title'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        events[i]['time'] + '\'',
                        style: const TextStyle(
                          color: Colors.black38,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        events[i]['who']['name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.black45,
                        ),
                      ),
                      Text(
                        events[i]['who']['team'] == 'r' ? "Red" : "Blue",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: events[i]['who']['team'] == 'r'
                              ? const Color.fromARGB(255, 216, 11, 11)
                              : const Color.fromARGB(255, 3, 91, 131),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
