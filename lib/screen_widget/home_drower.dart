import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:setes_mobile/method/login.dart';
import 'package:setes_mobile/module/simple.dart';
import 'package:setes_mobile/screen/bookings.dart';
import 'package:setes_mobile/screen/notification.dart';

class HomeDrower extends StatelessWidget {
  const HomeDrower({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screen = getScreen(context);
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: screen.width * .05),
        color: Colors.white,
        width: screen.width * .8,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                const Icon(Icons.home, size: 25),
                SizedBox(
                  width: screen.width * .7 - 25,
                  child: ListTile(
                    onTap: () => Navigator.pop(context),
                    title: Text("Home"),
                    subtitle: Text("Setes Sports"),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                const Icon(Icons.notifications, size: 25),
                SizedBox(
                  width: screen.width * .7 - 25,
                  child: ListTile(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyNotification(),
                      ),
                    ),
                    title: Text("Notifications"),
                    subtitle: Text("All Notifications"),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                const Icon(Icons.bakery_dining_sharp, size: 25),
                SizedBox(
                  width: screen.width * .7 - 25,
                  child: ListTile(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyBookings(),
                      ),
                    ),
                    title: Text("My Bookings"),
                    subtitle: Text("Booking History and Bookings"),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                const Icon(Icons.logout, size: 25),
                SizedBox(
                  width: screen.width * .7 - 25,
                  child: ListTile(
                    onTap: () {
                      showDialog<void>(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                                'You can login at any time, we will keep all your data safe. thankYou'),
                            actions: [
                              TextButton(
                                onPressed: () => logout(context),
                                child: Text('Confirm Logout'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    title: Text("Logout"),
                    subtitle: Text("You can Loggin at any time"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
