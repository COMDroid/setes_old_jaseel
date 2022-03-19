import 'package:flutter/material.dart';
import 'package:setes_mobile/module/simple.dart';

class MyProfileText1 extends StatelessWidget {
  final String? title;
  final dynamic data;
  const MyProfileText1(this.title, this.data, {Key? key}) : super(key: key);

  setValue(v) {
    if (v == null) return '0';
    return v.toString();
  }

  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Row(
        children: [
          SizedBox(
            width: scr.width * .4,
            child: Text(
              title ?? '',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ),
          Text(
            setValue(data),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }
}
