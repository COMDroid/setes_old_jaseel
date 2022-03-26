import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:setes_mobile/method/login.dart';
import 'package:setes_mobile/module/api_init.dart';
import 'package:setes_mobile/module/gb_var.dart';
import 'package:setes_mobile/screen/home.dart';
import 'package:setes_mobile/screen/toprime2.dart';

toprime(props) {
  if (props.loading) {
    return 0;
  }
  if (props.bloodGp == null) {
    props.setState(() {
      props.error = "Chose your blood group";
    });
    return 0;
  }
  if (props.district == null) {
    props.setState(() {
      props.error = "Chose your district";
    });
    return 0;
  }
  if (props.zone == null) {
    props.setState(() {
      props.error = "Chose your zone";
    });
    return 0;
  }

  if (props.bootsize == null) {
    props.error = "Chose your bootsize";
    return 0;
  }
  if (props.tshitrsize == null) {
    props.setState(() {
      props.error = "Chose your T - shitrsize";
    });
    return 0;
  }
  if (props.favposition == null) {
    props.setState(() {
      props.error = "Chose your favorite position";
    });
    return 0;
  }
  if (props.secfavposition == null) {
    props.setState(() {
      props.error = "Chose your second favorite position";
      return 0;
    });
  }
  if (props.strongfoot == null) {
    props.setState(() {
      props.error = "Chose your Strong foot";
    });
    return 0;
  }
  Navigator.push(
    props.context,
    MaterialPageRoute(
      builder: (context) => ToPrimePage2(props),
    ),
  );
}

toprime2(props) async {
  if (props.loading) {
    return 0;
  }

  if (props.home == null) {
    props.setState(() {
      props.error = "Chose your home truf";
    });
    return 0;
  }

  if (props.sex == null) {
    props.setState(() {
      props.error = "Chose your home truf";
    });
    return 0;
  }

  if (props.nameC.text == "") {
    props.setState(() {
      props.error = "Enter your name";
    });
    return 0;
  }

  if (props.emailC.text == "") {
    props.setState(() {
      props.error = "Enter your email";
    });
    return 0;
  }

  if (props.dob == "") {
    props.setState(() {
      props.error = "Chose Your Birth date";
    });
    return 0;
  }

  props.setState(() {
    props.loading = true;
    props.error = null;
  });

  var body = {
    "amount": props.widget.props.primeData['price_pm'],
    "blood_group": props.widget.props.bloodGp,
    "district": props.widget.props.district['title'],
    "zone": props.widget.props.zone['title'],
    "bootsize": props.widget.props.bootsize,
    "t_shirt_size": props.widget.props.tshitrsize,
    "fav_position": props.widget.props.favposition,
    "sec_fav_position": props.widget.props.secfavposition,
    "strong_foot": props.widget.props.strongfoot,
    "home_truf": props.home,
    "sex": props.sex,
    "dob": props.dob,
    "name": props.nameC.text,
    "email": props.emailC.text,
  };

  gbUser['email'] = props.emailC.text;

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    try {
      var res = await http.post(setApi("toprime?user_id=" + gbUserId),
          headers: gbHeader, body: jsonEncode(body));
      if (res.statusCode == 200) {
        gbisPrime = true;
        body['prime'] = true;
        gbUser = {...gbUser, ...body};
        Navigator.pop(props.context);
        Navigator.pop(props.context);
        Navigator.pushReplacement(props.context,
            MaterialPageRoute(builder: (context) => const HomePage()));
      } else {
        if (res.statusCode == 401) {
          logout(props.context);
        } else {
          props.setState(() => props.error = jsonDecode(res.body)["msg"]);
        }
      }
    } on SocketException catch (_) {
      props.setState(() => props.error = "Network Error");
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    props.setState(() {
      props.error =
          "Something went wrong, any money didection will be refunded with in 48 hours";
    });
  }

  void _handleExternalWallet(ExternalWalletResponse response) {}

  Razorpay _razorpay = Razorpay();
  _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
  _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
  _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

  var options = {
    'key': 'rzp_test_Y7JuSZ90XUqdEG',
    'amount': props.widget.props.primeData['price_pm'],
    'name': "Prime Membership",
    'description': "Name: " + gbUser['name'] + ", id: " + gbUser['id'],
    'prefill': {'contact': gbUser['phone'], 'email': gbUser['email']}
  };

  _razorpay.open(options);
  // _razorpay.clear();

  props.setState(() => props.loading = false);
}

getPrimePrice(props) async {
  try {
    var res = await http.get(
      setApi("primedetails?user_id=" + gbUserId),
      headers: gbHeader,
    );
    if (res.statusCode == 200) {
      props.setState(() {
        props.primeData = jsonDecode(res.body);
        props.loading = false;
      });
    } else {
      if (res.statusCode == 401) {
        logout(props.context);
      } else {
        props.setState(
          () => props.error = jsonDecode(res.body)["msg"],
        );
      }
    }
  } catch (e) {
    if (e.runtimeType == SocketException) {
      props.setState(() => props.error = "Network Error");
    }
  }
}

getPrimeTrufs(props) async {
  try {
    var res = await http.get(
      setApi("primetrufs?zone=" + props.widget.props.zone['title']),
      headers: gbHeader,
    );
    if (res.statusCode == 200) {
      props.setState(() {
        props.homes = jsonDecode(res.body);
        props.loading = false;
      });
    } else {
      props.setState(
        () => props.error = jsonDecode(res.body)["msg"],
      );
    }
  } on SocketException catch (_) {
    props.setState(() => props.error = "Network Error");
  }
}
