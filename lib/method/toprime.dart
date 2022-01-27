import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';
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
    });
    return 0;
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
      props.error = "Chose your name";
    });
    return 0;
  }

  if (props.emailC.text == "") {
    props.setState(() {
      props.error = "Chose your email";
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
    "name": props.nameC.text,
    "email": props.emailC.text,
  };

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    try {
      var res = await http.post(setApi("toprime?user_id=" + gbUserId),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body));
      if (res.statusCode == 200) {
        gbisPrime = true;
        Navigator.pop(props.context);
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
    print("Wallet456");
    props.setState(() {
      props.error =
          "Something went wrong, any money didection will be refunded with in 48 hours";
    });
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
    'amount': props.widget.props.primeData['price_pm'],
    'name': "Prime Membership",
    'description': "Name: " + gbUser['name'] + ", id: " + gbUser['id'],
    'prefill': {
      'contact': gbUser['phone'],
      'email': "jaseelmanamulli@gmail.com"
    }
  };

  _razorpay.open(options);
  // _razorpay.clear();

  props.setState(() => props.loading = false);
}

getPrimePrice(props) async {
  try {
    var res = await http.get(setApi("primedetails?user_id=" + gbUserId));
    if (res.statusCode == 200) {
      props.setState(() {
        props.primeData = jsonDecode(res.body);
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

getPrimeTrufs(props) async {
  print(props.widget.props.zone);
  try {
    var res = await http
        .get(setApi("primetrufs?zone=" + props.widget.props.zone['title']));
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
  } catch (e) {
    props.setState(() => props.error = "Network Error");
  }
}