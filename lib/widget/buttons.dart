import 'package:flutter/material.dart';

class TextfileldButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function fun;

  const TextfileldButton(this.icon, this.text, this.fun, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        fun();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          border: Border.all(
            color: Color.fromARGB(10, 0, 0, 0),
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Icon(Icons.grass, color: Colors.black45, size: 22),
            SizedBox(width: 15),
            Text(text)
          ],
        ),
      ),
    );
  }
}
