import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:setes_mobile/module/api_init.dart';
import 'package:setes_mobile/module/gb_var.dart';

getProfile(profile, setProfile) async {
  var res = await http.get(
    setApi("publicprofile?user_id=${profile['_id']}"),
    headers: gbHeader,
  );
  if (res.statusCode == 200) {
    var p = await jsonDecode(res.body);
    profile.addAll(p);
    setProfile(profile);
  }
  return 0;
}
