import 'package:http/http.dart' as http;
import 'package:setes_mobile/module/api_init.dart';
import 'package:shared_preferences/shared_preferences.dart';

getHome() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String id = prefs.getString('userid').toString();
  var res = await http.get(setApi("home?user_id=" + id));
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
