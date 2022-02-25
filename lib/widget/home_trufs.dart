import 'package:flutter/material.dart';
import 'package:setes_mobile/module/api_init.dart';
import 'package:setes_mobile/module/simple.dart';

class HomeTrufplyers extends StatelessWidget {
  final Map data;
  final double x, y, s;
  const HomeTrufplyers(this.data, this.x, this.y, this.s, {Key? key})
      : super(key: key);

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
            child: data['img'] != null
                ? ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(scr.height * .07 * s),
                    ),
                    child: Image.network(
                      setImgProfile(data["_id"] + "/" + data["img"]),
                      fit: BoxFit.cover,
                      width: scr.height * .14 * s,
                      height: scr.height * .14 * s,
                    ),
                  )
                : Icon(
                    Icons.person,
                    size: scr.height * .1 * s,
                    color: Colors.black38,
                  ),
          ),
          SizedBox(height: 6 * s),
          Text(
            data['name'],
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
  final Map member;
  const EachMember(this.member, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: scr.width * .08, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(25)),
                child: member["img"] == null
                    ? Container(
                        color: Colors.black12,
                        width: 50,
                        height: 50,
                        child: const Icon(Icons.person),
                      )
                    : Image.network(
                        setImgProfile(member["_id"] + "/" + member["img"]),
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    member["name"],
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      fontSize: 14.5,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    member["id"],
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.black38,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.star, size: 15),
              const SizedBox(width: 5),
              Text(
                member["p_raiting"] ?? "0",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          )
        ],
      ),
    );
  }
}
