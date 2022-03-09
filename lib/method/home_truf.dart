import 'dart:convert';
import 'package:http/http.dart' as http;
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
    var res = await http
        .get(setApi("hometruf?user_id=" + gbUserId + "&type=" + type));
    if (res.statusCode == 200) {
      props.setState(() {
        props.players = jsonDecode(res.body)['players'];
        props.members = jsonDecode(res.body)['members'];
      });
    } else {
      props.setState(() => props.error = jsonDecode(res.body)['msg']);
    }
  } catch (e) {
    props.setState(() => props.error = "Network Error OnLoading");
  }
  props.setState(() => props.loading = false);
}
