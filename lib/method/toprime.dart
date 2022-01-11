import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';
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

  var body = {
    "amount": props.price,
  };

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    try {
      var res = await http.post(setApi("toprime?user_id=" + gbUserId),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body));
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
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("Error");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("Wallet");
  }

  Razorpay _razorpay = Razorpay();
  _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
  _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
  _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

  var options = {
    'key': 'rzp_test_Y7JuSZ90XUqdEG',
    'amount': props.price,
    'name': "Prime Membership",
    'description': "Name: " + gbUser['name'] + ", id: " + gbUser['id'],
    'prefill': {'contact': gbUser['phone'], 'email': gbUser['email']}
  };

  _razorpay.open(options);
  _razorpay.clear();

  props.setState(() => props.loading = false);
}

getPrimePrice(props) async {
  try {
    var res = await http.get(setApi("primedetails?user_id=" + gbUserId));
    if (res.statusCode == 200) {
      props.setState(() {
        props.price = jsonDecode(res.body)["price_pm"];
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
