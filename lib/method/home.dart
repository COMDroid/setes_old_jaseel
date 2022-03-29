import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:setes_mobile/method/login.dart';
import 'package:setes_mobile/module/api_init.dart';
import 'package:setes_mobile/module/gb_var.dart';
import 'package:web_socket_channel/io.dart';

getHome(setdata, seterror, context) async {
  var res = await http.get(
    setApi("home"),
    headers: gbHeader,
  );
  if (res.statusCode == 200) {
    setdata(await jsonDecode(res.body));
  } else {
    if (res.statusCode == 401) {
      logout(context);
    } else {
      seterror(await jsonDecode(res.body)['msg']);
    }
  }
  return 1;
}

getSetesTruf(context) async {
  var res = await http.get(
    setApi("truf?type=s"),
    headers: gbHeader,
  );

  if (res.statusCode == 200) {
    return [false, res.body];
  } else {
    if (res.statusCode == 401) {
      logout(context);
    } else {
      return [true, res.body];
    }
  }
}

void onClickNoti(String? s) async {}
void onNotiRecived(int i, String? s, String? s2, String? s3) async {}

connectSocket() async {
  var locelNotiPlug = FlutterLocalNotificationsPlugin();
  const initNotiAndroid = AndroidInitializationSettings('ic_launcher');
  const initNotiIos =
      IOSInitializationSettings(onDidReceiveLocalNotification: onNotiRecived);
  const initNotiMacOs = MacOSInitializationSettings();
  const initNoti = InitializationSettings(
      android: initNotiAndroid, iOS: initNotiIos, macOS: initNotiMacOs);
  await locelNotiPlug.initialize(initNoti, onSelectNotification: onClickNoti);
  var channel = IOWebSocketChannel.connect(wsUrl(gbUserId));

  channel.stream.listen(
    (message) async {
      List msgs = message.split('|');
      for (var i = 0; i < msgs.length; i++) {
        if (msgs[i] == "alert") {
          List alertMsgs = msgs[msgs.length - 1].split("&&");
          const notiAndroid = AndroidNotificationDetails(
            '0',
            'Alert',
            channelDescription: 'Alert message',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker',
          );
          const platformChannelSpecifics =
              NotificationDetails(android: notiAndroid);
          await locelNotiPlug.show(
            0,
            alertMsgs[1] ?? '',
            alertMsgs[2] ?? '',
            platformChannelSpecifics,
            payload: 'Alert Msg',
          );
        }
      }
    },
    onDone: () => Future.delayed(const Duration(seconds: 10), connectSocket),
    onError: (e) => Future.delayed(const Duration(seconds: 10), connectSocket),
  );
}
