import 'package:flutter/material.dart';

class WaletPaymentPopup extends StatefulWidget {
  final Map userWallet;
  const WaletPaymentPopup(this.userWallet, {Key? key}) : super(key: key);

  @override
  _WaletPaymentPopupState createState() => _WaletPaymentPopupState();
}

class _WaletPaymentPopupState extends State<WaletPaymentPopup> {
  var credit = 0;
  var wallet = 0;

  int selected = 2;

  @override
  void initState() {
    setState(() {
      wallet = widget.userWallet['wallet'] ?? 0;
      credit = widget.userWallet['credit'] ?? 0;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListBody(
        children: <Widget>[
          WaletPaymentEach(
            "Pay from my Setes Wallet",
            Icons.wallet_giftcard,
            wallet,
            selected == 0,
            () {},
          ),
          WaletPaymentEach(
            "Pay from my Setes Credit",
            Icons.wallet_travel,
            credit,
            selected == 1,
            () {},
          ),
          WaletPaymentEach(
            "Pay from Your Bank",
            Icons.money,
            null,
            selected == 2,
            () {},
          ),
        ],
      ),
    );
  }
}

class WaletPaymentEach extends StatelessWidget {
  final String title;
  final IconData icon;
  final int? price;
  final selected;
  final Function fun;
  const WaletPaymentEach(
      this.title, this.icon, this.price, this.selected, this.fun,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 16,
          height: 16,
          margin: const EdgeInsets.only(right: 10, top: 3),
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: selected ? Colors.blue : Colors.black38,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          alignment: Alignment.center,
          child: Container(
            width: 9,
            height: 9,
            decoration: BoxDecoration(
              color: selected ? Colors.blue : Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color.fromARGB(234, 0, 0, 0),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              if (price != null)
                Text(
                  "Balance " + ((price ?? 1) / 100).toString(),
                  style: const TextStyle(
                    color: Color.fromARGB(234, 59, 59, 59),
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
              const SizedBox(height: 13),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Icon(
            icon,
            color: const Color.fromARGB(212, 58, 58, 58),
          ),
        ),
      ],
    );
  }
}
