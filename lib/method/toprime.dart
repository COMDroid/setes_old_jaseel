import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:setes_mobile/module/api_init.dart';
import 'package:setes_mobile/module/gb_var.dart';
import 'package:setes_mobile/screen/home.dart';

toprime(props) async {
  if (props.loading) {
    return;
  }
  props.setState(() {
    props.loading = true;
    props.error = null;
  });

  try {
    var res = await http.post(setApi("toprime?user_id=" + gbUserId),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"amount": 200 * 100}));
    if (res.statusCode == 200) {
      gbisPrime = true;
      Navigator.pop(props.context);
      Navigator.pushReplacement(props.context,
          MaterialPageRoute(builder: (context) => const HomePage()));
    } else {
      props.setState(() => props.error = jsonDecode(res.body)["msg"]);
    }
  } catch (e) {
    props.setState(() => props.error = "Network Error");
  }
  props.setState(() => props.loading = false);
}

getPrimePrice(props) async {
  try {
    var res = await http.get(setApi("primedetails?user_id=" + gbUserId));
    if (res.statusCode == 200) {
      props.setState(() {
        props.price = jsonDecode(res.body)["price_pm"] / 100;
        props.loading = false;
      });
    } else {
      props.setState(
        () => props.error = jsonDecode(res.body)["msg"],
      );
    }
  } catch (e) {
    props.setState(() => props.error = "Network Error");
  }
}
