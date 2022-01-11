import 'package:setes_mobile/module/api_init.dart';
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

makeBookingpyment(slot, context) {
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("Succes");
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
    'amount': slot["price"],
    'name': slot["truf_name"],
    'description':
        slot["ground"] + " slot, on" + slot["s_time"] + " to " + slot["e_time"],
    'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'}
  };

  _razorpay.open(options);
}
