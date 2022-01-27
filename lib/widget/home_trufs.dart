import 'package:flutter/material.dart';
import 'package:setes_mobile/module/simple.dart';

class HomeTrufplyers extends StatelessWidget {
  final double x, y, s;
  const HomeTrufplyers(this.x, this.y, this.s, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);
    return Positioned(
      left: x - scr.height * .07,
      bottom: y,
      child: Column(
        children: [
          Container(
            width: scr.height * .14 * s,
            height: scr.height * .14 * s,
            decoration: BoxDecoration(
              color: Color(0xdfffffff),
              border: Border.all(
                width: scr.height * .01 * s,
                color: Color(0x99FD10BD),
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(scr.height * .07 * s),
              ),
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.person,
              size: scr.height * .1 * s,
              color: Colors.black38,
            ),
          ),
          SizedBox(height: 6 * s),
          Text(
            "Jaseel123",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}

class HomeTrufTopButten extends StatelessWidget {
  final bool selected;
  final String title;
  const HomeTrufTopButten(this.selected, this.title, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: scr.width * .02,
        vertical: scr.width * .04,
      ),
      padding: EdgeInsets.symmetric(horizontal: scr.width * .03),
      height: selected ? 30 : 25,
      width: selected ? scr.width * .28 : scr.width * .25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(35)),
        border: Border.all(width: 2, color: Colors.white),
      ),
      alignment: Alignment.center,
      child: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: selected ? 15 : 12),
      ),
    );
  }
}

class EachMember extends StatelessWidget {
  const EachMember({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: scr.width * .08, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Test Name",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    fontSize: 14.5),
              ),
              SizedBox(height: 3),
              Text(
                "!@#%^&",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.black38,
                    fontSize: 12),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: false
                ? Icon(Icons.person, size: 35, color: Colors.black54)
                : ClipRRect(),
          ),
        ],
      ),
    );
  }
}
