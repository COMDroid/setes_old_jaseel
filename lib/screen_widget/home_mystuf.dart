import 'package:flutter/material.dart';
import 'package:setes_mobile/module/gb_var.dart';
import 'package:setes_mobile/module/simple.dart';

class MyStuf extends StatelessWidget {
  const MyStuf({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);
    return Container(
      color: Color(0xffF1F5F9),
      child: Column(
        children: [
          Container(
            width: scr.width,
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
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  "My Stuff",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(0),
              children: [
                SizedBox(height: 20),
                for (var i = 0; i < 2; i++)
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                    width: scr.width,
                    decoration: BoxDecoration(
                      color: Color(0xffF1F5F9),
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          spreadRadius: 7,
                          color: Color(0x11000000),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          i == 0 ? Icons.wallet_giftcard : Icons.wallet_travel,
                          size: 30,
                        ),
                        SizedBox(width: 20),
                        SizedBox(
                          width: scr.width - 130,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                i == 0 ? "Setes Wallet" : "Setes Credits",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "₹ " +
                                    (i == 0
                                        ? toint(gbUser["wallet"])
                                        : toint(gbUser["credit"])),
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 20,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 7),
                              Text(
                                "You can use the setes credit for some type of payment in setes community",
                                style: TextStyle(
                                  color: Colors.black38,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
