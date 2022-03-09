import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:setes_mobile/module/simple.dart';
import 'package:setes_mobile/screen/trufs_setes.dart';
import 'package:setes_mobile/screen/trufs_team.dart';

setDate(context, type) {
  DatePicker.showDatePicker(
    context,
    showTitleActions: true,
    minTime: DateTime.now(),
    onConfirm: (d) {
      String date = dateTomyFormat(d);
      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              type == "s" ? TrufsSetesPage(date) : TrufsTeamPage(date),
        ),
      );
    },
    currentTime: DateTime.now(),
  );
}
