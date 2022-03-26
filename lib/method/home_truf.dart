import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:setes_mobile/method/login.dart';
import 'package:setes_mobile/module/api_init.dart';
import 'package:setes_mobile/module/gb_var.dart';

getHomeTruf(props) async {
  props.setState(() {
    props.loading = true;
    props.error = null;
  });

  var type = props.type == 0
      ? "district"
      : props.type == 1
          ? "zone"
          : "home";
  try {
    var res = await http.get(
      setApi("hometruf?user_id=" + gbUserId + "&type=" + type),
      headers: gbHeader,
    );
    if (res.statusCode == 200) {
      props.setState(() {
        props.players = jsonDecode(res.body)['players'];
        props.members = jsonDecode(res.body)['members'];
      });
    } else {
      if (res.statusCode == 401) logout(props.context);
      props.setState(() => props.error = jsonDecode(res.body)['msg']);
    }
  } catch (e) {
    if (e.runtimeType == SocketException) {
      props.setState(() => props.error = "Network Error OnLoading");
    }
  }
  props.setState(() => props.loading = false);
}
