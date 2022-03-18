import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:setes_mobile/module/simple.dart';
import 'package:setes_mobile/screen/trufs_setes.dart';

setDate(context) {
  DatePicker.showDatePicker(
    context,
    showTitleActions: true,
    minTime: DateTime.now(),
    onConfirm: (d) {
      String date = dateTomyFormat(d);
      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TrufsSetesPage(date)),
      );
    },
    currentTime: DateTime.now(),
  );
}
