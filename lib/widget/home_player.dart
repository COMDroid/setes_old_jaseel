import 'package:flutter/material.dart';
import 'package:setes_mobile/module/api_init.dart';
import 'package:setes_mobile/module/simple.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:setes_mobile/screen/home_truf.dart';

class HomePlayer extends StatelessWidget {
  final List data;
  const HomePlayer(this.data, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: scr.width * .03,
            right: scr.width * .03,
            top: 10,
          ),
          child: const Text(
            "Players of the week",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.black87,
              fontSize: 18,
            ),
          ),
        ),
        InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const HomeTruf(),
            ),
          ),
          child: Container(
            width: scr.width,
            height: scr.width * .6,
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/playerBg.png")),
            ),
            child: CarouselSlider(
              options: CarouselOptions(
                height: scr.width * .54,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.4,
                aspectRatio: 2.0,
                initialPage: 2,
              ),
              items: data.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Body(i);
                  },
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class Body extends StatelessWidget {
  final Map i;
  const Body(this.i, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screen = getScreen(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          Text(
            i["title"].toString(),
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          Expanded(
            child: Container(
              width: screen.width * .42,
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      width: screen.width * .42,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 5,
                            spreadRadius: 4,
                            offset: Offset(0, 5),
                            color: Colors.black12,
                          )
                        ],
                        image: i["img"] == null
                            ? null
                            : DecorationImage(
                                image: NetworkImage(
                                    setImgProfile(i["_id"] + "/" + i["img"])),
                                fit: BoxFit.cover,
                              ),
                      ),
                      child: i["img"] != null
                          ? null
                          : Icon(
                              Icons.person,
                              size: screen.width * .32,
                              color: Colors.white,
                            ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    i["name"].toString(),
                    style: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
