import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:setes_mobile/module/api_init.dart';
import 'package:setes_mobile/module/gb_var.dart';
import 'package:setes_mobile/screen/home.dart';
import 'package:http/http.dart' as http;

editProfile(props) async {
  if (props.loading) return 0;
  props.setState(() {
    props.loading = true;
    props.error = null;
  });

  var body = {
    "blood_group": props.bloodGp,
    "bootsize": props.bootsize,
    "t_shirt_size": props.tshitrsize,
    "fav_position": props.favposition,
    "sec_fav_position": props.secfavposition,
    "strong_foot": props.strongfoot,
    "sex": props.sex,
    "dob": "01-01-2000",
    "name": props.nameC.text,
    "email": props.emailC.text,
  };

  try {
    var res = await http.put(
      setApi("myprofile?user_id=" + gbUserId),
      headers: gbHeader,
      body: jsonEncode(body),
    );
    if (res.statusCode == 200) {
      gbUser["blood_group"] = props.bloodGp;
      gbUser["bootsize"] = props.bootsize;
      gbUser["t_shirt_size"] = props.tshitrsize;
      gbUser["fav_position"] = props.favposition;
      gbUser["sec_fav_position"] = props.secfavposition;
      gbUser["strong_foot"] = props.strongfoot;
      gbUser["sex"] = props.sex;
      gbUser["dob"] = "01-01-2000";
      gbUser["name"] = props.nameC.text;
      gbUser["email"] = props.emailC.text;
      props.setState(() => props.loading = false);
      Navigator.pop(props.context);
      Navigator.pushReplacement(props.context,
          MaterialPageRoute(builder: (context) => const HomePage()));
    } else {
      props.setState(() {
        props.loading = false;
        props.error = jsonDecode(res.body)['msg'];
      });
    }
  } catch (e) {
    props.setState(() {
      props.loading = false;
      props.error = "Check Your Network";
    });
  }
}
