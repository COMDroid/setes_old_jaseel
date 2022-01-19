import 'package:flutter/material.dart';
import 'package:setes_mobile/module/simple.dart';

class DroperButton extends StatelessWidget {
  final IconData icon;
  final String hint;
  final String? text;
  final List data;
  final Function fun;

  const DroperButton(this.icon, this.hint, this.text, this.data, this.fun,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);

    return InkWell(
      onTap: () {
        showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Chose your ' + hint),
              content: Container(
                constraints: BoxConstraints(maxHeight: scr.height * .6),
                child: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      for (var i = 0; i < data.length; i++)
                        Container(
                          child: TextButton(
                            onPressed: () {
                              fun(data[i]);
                              Navigator.pop(context);
                            },
                            child: Text(data[i]),
                          ),
                        )
                    ],
                  ),
                ),
              ),
            );
          },
        );
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
            Icon(
              icon,
              color: Colors.black45,
              size: 22,
            ),
            SizedBox(width: 15),
            Text(
              text == null ? hint : text ?? '',
              style: TextStyle(
                color: text == null ? Colors.black12 : Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DroperButton2 extends StatelessWidget {
  final IconData icon;
  final String hint;
  final dynamic text;
  final List data;
  final Function fun;

  const DroperButton2(this.icon, this.hint, this.text, this.data, this.fun,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);

    return InkWell(
      onTap: () {
        showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Chose your ' + hint),
              content: Container(
                constraints: BoxConstraints(maxHeight: scr.height * .6),
                child: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      for (var i = 0; i < data.length; i++)
                        Container(
                          child: TextButton(
                            onPressed: () {
                              fun(data[i]);
                              Navigator.pop(context);
                            },
                            child: Text(data[i]['title']),
                          ),
                        )
                    ],
                  ),
                ),
              ),
              actions: [],
            );
          },
        );
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
            Icon(
              icon,
              color: Colors.black45,
              size: 22,
            ),
            SizedBox(width: 15),
            Text(
              text == null ? hint : (text['title'] ?? ""),
              style: TextStyle(
                color: text == null ? Colors.black12 : Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DroperButton3 extends StatelessWidget {
  final IconData icon;
  final String hint;
  final dynamic text;
  final List data;
  final Function fun;

  const DroperButton3(this.icon, this.hint, this.text, this.data, this.fun,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);

    return InkWell(
      onTap: () {
        showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Chose your ' + hint),
              content: Container(
                constraints: BoxConstraints(maxHeight: scr.height * .6),
                child: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      for (var i = 0; i < data.length; i++)
                        Container(
                          child: TextButton(
                            onPressed: () {
                              fun(data[i]);
                              Navigator.pop(context);
                            },
                            child: Text(data[i]['name']),
                          ),
                        )
                    ],
                  ),
                ),
              ),
              actions: [],
            );
          },
        );
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
            Icon(
              icon,
              color: Colors.black45,
              size: 22,
            ),
            SizedBox(width: 15),
            Text(
              text == null ? hint : (text['name'] ?? ""),
              style: TextStyle(
                color: text == null ? Colors.black12 : Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}
