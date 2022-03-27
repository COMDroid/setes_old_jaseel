import 'dart:async';

import 'package:flutter/material.dart';

class ScoreBoradTimer extends StatefulWidget {
  final Map booking;
  const ScoreBoradTimer(this.booking, {Key? key}) : super(key: key);

  @override
  _ScoreBoradTimerState createState() => _ScoreBoradTimerState();
}

class _ScoreBoradTimerState extends State<ScoreBoradTimer> {
  String matchtimer = "";
  Timer? _timer;

  @override
  void initState() {
    var status = widget.booking['status'];

    if (status == "Started") {
      var start = widget.booking["starting_time"];
      var tes = DateTime.parse(start);
      var d = DateTime.now().difference(tes);
      var hd = d.inHours;
      var md = d.inMinutes % 60;
      var sd = d.inSeconds % 60;

      if (hd < 3) {
        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          sd++;
          if (sd == 61) {
            sd = 1;
            md++;
          }
          if (md == 61) {
            md = 1;
            hd++;
          }
          setState(() => matchtimer = '$hd:$md:$sd');
        });
      }
    }
    if (status == "Fulltime") {
      var start = widget.booking["starting_time"];
      var end = widget.booking["ending_time"];
      var d = DateTime.parse(end).difference(DateTime.parse(start));
      var hd = d.inHours;
      var md = d.inMinutes % 60;
      var sd = d.inSeconds % 60;
      setState(() => matchtimer = '$hd:$md:$sd');
    }

    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      "Time : " + matchtimer,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
        height: 1.5
      ),
    );
  }
}
