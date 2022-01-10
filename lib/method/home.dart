import 'package:http/http.dart' as http;
import 'package:setes_mobile/module/api_init.dart';
import 'package:setes_mobile/module/gb_var.dart';

getHome() async {
  var res = await http.get(setApi("home?user_id=" + gbUserId));
  if (res.statusCode == 200) {
    return [false, res.body];
  } else {
    return [true, res.body];
  }
}

getSetesTruf() async {
  var res = await http.get(setApi("truf?type=s"));
  if (res.statusCode == 200) {
    return [false, res.body];
  } else {
    return [true, res.body];
  }
}
