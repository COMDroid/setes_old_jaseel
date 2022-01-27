import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:setes_mobile/module/simple.dart';
import 'package:setes_mobile/screen/trufs_setes.dart';
import 'package:setes_mobile/screen/trufs_team.dart';

setDate(context, type) {
  showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Select Your Date of Booking'),
        content: DateTimeFormField(
          decoration: const InputDecoration(
            hintStyle: TextStyle(color: Colors.black45),
            errorStyle: TextStyle(color: Colors.redAccent),
            border: OutlineInputBorder(),
            suffixIcon: Icon(Icons.event_note),
            labelText: 'Select Date',
          ),
          mode: DateTimeFieldPickerMode.date,
          autovalidateMode: AutovalidateMode.always,
          validator: (e) =>
              (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
          onDateSelected: (DateTime d) {
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
        ),
      );
    },
  );
}
