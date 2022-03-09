import 'package:setes_mobile/module/api_init.dart';
import 'package:setes_mobile/module/gb_var.dart';
import 'package:http/http.dart' as http;

getNotification() async {
  var prams = "mynoti?user_id=" + gbUserId;
  var res = await http.get(setApi(prams), headers: gbHeader);
  if (res.statusCode == 200) {
    return [false, res.body];
  } else {
    return [true, res.body];
  }
}
