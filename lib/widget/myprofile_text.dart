import 'package:flutter/material.dart';
import 'package:setes_mobile/module/simple.dart';

class MyProfileText1 extends StatelessWidget {
  final String? title, data;
  const MyProfileText1(this.title, this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);
    return Padding(
      padding: EdgeInsets.all(6),
      child: Row(
        children: [
          SizedBox(
            width: scr.width * .4,
            child: Text(
              title ?? '',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ),
          Text(
            data ?? '',
            style: TextStyle(
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
