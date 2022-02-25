import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:setes_mobile/module/api_init.dart';
import 'package:setes_mobile/module/simple.dart';

class HomeBanner extends StatelessWidget {
  final List data;
  const HomeBanner(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screen = getScreen(context);
    return CarouselSlider(
      options: CarouselOptions(),
      items: data.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              decoration: BoxDecoration(
                  border: Border.all(width: .5, color: Colors.black26),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                        blurRadius: 3, spreadRadius: 2, color: Colors.black12)
                  ]),
              height: screen.width * .5,
              margin: EdgeInsets.symmetric(
                horizontal: screen.width * .02,
                vertical: 20,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(
                  setImgEvent(i["img"]),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
