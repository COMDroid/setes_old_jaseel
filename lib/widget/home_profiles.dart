import 'package:flutter/material.dart';
import 'package:setes_mobile/module/simple.dart';

class HomeProfileEach extends StatelessWidget {
  final String title;
  final String? value;
  const HomeProfileEach(this.title, this.value, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: [
          SizedBox(
            width: scr.width * .3,
            child: Text(
              title,
              style:
                  TextStyle(color: Colors.black45, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            width: scr.width * .5,
            child: Text(
              value ?? '',
              style: TextStyle(
                fontSize: 16,
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
