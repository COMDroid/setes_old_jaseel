import 'dart:convert';

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

connectSocket() {
  var channel = IOWebSocketChannel.connect(wsUrl(gbUserId));
  channel.stream.listen(
    (message) {
      List msgs = message.split('|');
      for (var i = 0; i < msgs.length; i++) {
        if (msgs[i] == "alert") {
          List alertMsgs = msgs[msgs.length - 1].split("&&");
          print(alertMsgs[1] ?? '');
          print(alertMsgs[2] ?? '');
        }
      }
    },
    onDone: () => Future.delayed(const Duration(seconds: 10), connectSocket),
    onError: (e) => Future.delayed(const Duration(seconds: 10), connectSocket),
  );
}
