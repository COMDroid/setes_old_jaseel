import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:setes_mobile/module/api_init.dart';

getHome(setdata, seterror) async {
  var res = await http.get(setApi("home"));
  if (res.statusCode == 200) {
    setdata(await jsonDecode(res.body));
  } else {
    seterror(await jsonDecode(res.body)['msg']);
  }
  return 1;
}

getSetesTruf() async {
  var res = await http.get(setApi("truf?type=s"));
  if (res.statusCode == 200) {
    return [false, res.body];
  } else {
    return [true, res.body];
  }
}
