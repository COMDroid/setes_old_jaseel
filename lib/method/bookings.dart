import 'package:flutter/material.dart';
import 'package:setes_mobile/method/truf.dart';
import 'package:setes_mobile/module/api_init.dart';
import 'package:setes_mobile/module/gb_var.dart';
import 'package:setes_mobile/screen/trufs_setes.dart';
import 'package:setes_mobile/screen/trufs_team.dart';
import 'package:setes_mobile/screen/warnings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';

getBookings() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String id = prefs.getString('userid').toString();
  var prams = "bookings?user_id=" + id;
  var res = await http.get(setApi(prams));
  if (res.statusCode == 200) {
    return [false, res.body];
  } else {
    return [true, res.body];
  }
}

bookingError(context, msg) {
  showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Error Booking'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[Text(msg)],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Back'),
          )
        ],
      );
    },
  );
}

makeBookingpyment(props, slot, context) {
  Navigator.pop(context);
  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Loading...'),
          content: Row(
            children: const [
              Loading(),
              Text("You Booking is omplate in few seconds")
            ],
          ),
        );
      },
    );
    var res = await bookTruf(props);
    Navigator.pop(context);
    if (res[0]) {
      bookingError(context, res[1]["msg"]);
    } else {
      Navigator.pop(context);
      Navigator.pop(context);
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Succesfully Booked'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => slot["type"] == "s"
                          ? TrufsSetesPage(props.date)
                          : TrufsTeamPage(props.date),
                    ),
                  );
                },
                child: const Text('Back'),
              ),
            ],
          );
        },
      );
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    bookingError(context, "Error On booking");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    bookingError(context, "Error On booking");
  }

  Razorpay _razorpay = Razorpay();
  _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
  _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
  _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

  var options = {
    'key': 'rzp_test_Y7JuSZ90XUqdEG',
    'amount': slot["price"],
    'name': slot["truf_name"],
    'description':
        slot["ground"] + " slot, on" + slot["s_time"] + " to " + slot["e_time"],
    'prefill': {'contact': gbUser['phone'], 'email': gbUser['email']}
  };

  _razorpay.open(options);
}
