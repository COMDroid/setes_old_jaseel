import 'package:flutter/material.dart';
import 'package:setes_mobile/module/simple.dart';

class HomeTruf extends StatelessWidget {
  const HomeTruf({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);
    return Scaffold(
      body: Container(
        height: scr.height,
        width: scr.width,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFD10BD), Color(0xFF6B32F5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
      ),
    );
  }
}

//#FD10BD
//#6B32F5