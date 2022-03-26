import 'package:flutter/material.dart';
import 'package:setes_mobile/method/login.dart';
import 'package:setes_mobile/method/truf.dart';
import 'package:setes_mobile/module/api_init.dart';
import 'package:setes_mobile/module/gb_var.dart';
import 'package:setes_mobile/screen/trufs_setes.dart';
import 'package:setes_mobile/screen/warnings.dart';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';

getBookings(context) async {
  var prams = "bookings?user_id=" + gbUserId;
  var res = await http.get(setApi(prams), headers: gbHeader);
  if (res.statusCode == 200) {
    return [false, res.body];
  } else {
    if (res.statusCode == 401) {
      logout(context);
    } else {
      return [true, res.body];
    }
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

makeBookingpyment(props, slot, context, paymentApi) {
  Navigator.pop(context);
  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Loading...'),
          content: SizedBox(
            height: 100,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Loading(viewStatus: false),
                SizedBox(width: 5),
                Expanded(
                  child: Text("You Booking is Complate in few seconds"),
                ),
              ],
            ),
          ),
        );
      },
    );
    var res = await bookTruf(props, "bank", context, response.toString());
    Navigator.pop(context);
    if (res[0]) {
      bookingError(context, res[1]);
    } else {
      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TrufsSetesPage(props.date)),
      );
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
    'key': paymentApi,
    'amount': slot["price"],
    'name': slot["truf_name"],
    'description':
        slot["ground"] + " slot, on" + slot["s_time"] + " to " + slot["e_time"],
    'prefill': {'contact': gbUser['phone'], 'email': gbUser['email']}
  };

  _razorpay.open(options);
}

bookFromWallet(dynamic props, BuildContext context, String type) async {
  Navigator.pop(context);
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context1) {
      return const AlertDialog(title: Text("Loading.."));
    },
  );
  var res = await bookTruf(props, type, context, '');
  Navigator.pop(context);
  if (res[0]) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context1) {
        return AlertDialog(title: Text(res[1]));
      },
    );
  } else {
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => TrufsSetesPage(props.date)),
    );
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
              },
              child: const Text('Back'),
            ),
          ],
        );
      },
    );
  }
}
