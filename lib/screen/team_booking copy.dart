import 'package:flutter/material.dart';
import 'package:setes_mobile/module/simple.dart';

class TeamBookingPage extends StatelessWidget {
  const TeamBookingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);
    return Scaffold(
      backgroundColor: Color(0xfff50D9FF),
      // backgroundColor: Colors.green,
      body: SizedBox(
        width: scr.width,
        height: scr.height,
        child: Column(
          children: [
            Container(
              height: scr.width,
              width: scr.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/bg_a.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: SafeArea(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.arrow_back_ios,
                          size: 28,
                          color: Colors.black54,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5),
                          Text(
                            "Setes Booking",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.black87,
                                fontSize: 20),
                          ),
                          Text(
                            "Book Your Match",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.black54,
                                fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Stack(
                overflow: Overflow.visible,
                children: [
                  Positioned(
                    top: -scr.width,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: SafeArea(
                      child: Container(
                        margin: EdgeInsets.only(top: 65),
                        child: ClipRRect(
                          // clipBehavior: Clip.,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(35),
                            topRight: Radius.circular(35),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(height: scr.width * .5),
                                Container(
                                  height: scr.width / 100 > 10
                                      ? scr.height - scr.width + 65
                                      : null,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(35),
                                      topRight: Radius.circular(35),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: scr.width * .05,
                                          vertical: 15,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height: 5),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Book Your Match",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.black54,
                                                          fontSize: 12),
                                                    ),
                                                    SizedBox(width: 5),
                                                    Icon(
                                                      Icons.location_on,
                                                      size: 18,
                                                      color: Colors.black54,
                                                    )
                                                  ],
                                                ),
                                                Text(
                                                  "Setes Vennes",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.black87,
                                                      fontSize: 20),
                                                ),
                                              ],
                                            ),
                                            Icon(
                                              Icons.search_sharp,
                                              size: 40,
                                              color: Color(0xff0E6E9D),
                                            )
                                          ],
                                        ),
                                      ),
                                      for (var i = 0; i < 10; i++) EachTruf()
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EachTruf extends StatelessWidget {
  const EachTruf({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(7)),
        color: Color(0xffE2F9FF),
      ),
      height: 100,
    );
  }
}
