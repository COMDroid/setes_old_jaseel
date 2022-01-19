import 'dart:convert';
import 'package:setes_mobile/module/api_init.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

getTrufs(type, date) async {
  var link = "trufs" + "?type=" + type + "&date=" + date;
  var res = await http.get(setApi(link));
  if (res.statusCode == 200) {
    return [false, res.body];
  } else {
    return [true, res.body];
  }
}

getSlot(id, date) async {
  var prams = "slot?slot_id=" + id + "&date=" + date;
  var res = await http.get(setApi(prams));
  if (res.statusCode == 200) {
    return [false, res.body];
  } else {
    return [true, res.body];
  }
}

bookTruf(props) async {
  var slot = props.slot;
  var date = props.date;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String id = prefs.getString('userid').toString();
  var body = {
    "slot_id": slot['_id'],
    "date": date,
    "type": slot['type'],
    "user_id": id
  };
  var res = await http.post(setApi("booktruf"), body: body);
  if (res.statusCode == 200) {
    return [false, jsonDecode(res.body)];
  } else {
    return [true, jsonDecode(res.body)];
  }
}
