import 'package:flutter/material.dart';
import 'package:setes_mobile/module/gb_var.dart';
import 'package:setes_mobile/module/simple.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);
    return Container(
      color: Color(0xffF1F5F9),
      child: Column(
        children: [
          Container(
            width: scr.width,
            height: 80,
            alignment: Alignment.bottomLeft,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 3,
                  spreadRadius: 4,
                  color: Color(0x11000000),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                "My Profile",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            width: scr.width,
            height: scr.height - 80,
            color: Color(0xff564EB1),
            child: Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                  ),
                  child: Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.white,
                  ),
                ),
                Text(
                  gbUser["name"] ?? '',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  (gbisGuest
                      ? gbUser["guest_id"] ?? ""
                      : gbUser["id"] ?? "" + " - Setes"),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                  ),
                  width: scr.width,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
