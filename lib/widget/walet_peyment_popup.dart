import 'package:flutter/material.dart';

class WaletPaymentPopup extends StatefulWidget {
  final Map userWallet;
  final int price;
  final Function fun;
  const WaletPaymentPopup(this.userWallet, this.price, this.fun, {Key? key})
      : super(key: key);

  @override
  _WaletPaymentPopupState createState() => _WaletPaymentPopupState();
}

class _WaletPaymentPopupState extends State<WaletPaymentPopup> {
  var credit = 0;
  var wallet = 0;

  bool payBank = false;
  bool payCredit = false;
  bool payWallet = false;

  int selected = 2;

  @override
  void initState() {
    widget.fun(2);
    setState(() {
      wallet = widget.userWallet['wallet'] ?? 0;
      credit = widget.userWallet['credit'] ?? 0;
    });

    if (widget.price > wallet && widget.price > credit) {
      setState(() => payBank = true);
    } else {
      if (widget.price <= wallet) {
        setState(() {
          payWallet = true;
          selected = 0;
        });
        widget.fun(0);
      }
      if (widget.price <= credit) {
        setState(() {
          selected = 1;
          payCredit = true;
        });
        widget.fun(1);
      }
    }

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
            payWallet,
            () {
              if (payWallet) {
                setState(() => selected = 0);
                widget.fun(0);
              }
            },
          ),
          WaletPaymentEach(
            "Pay from my Setes Credit",
            Icons.wallet_travel,
            credit,
            selected == 1,
            payCredit,
            () {
              if (payCredit) {
                setState(() => selected = 1);
                widget.fun(1);
              }
            },
          ),
          WaletPaymentEach(
            "Pay from Your Bank",
            Icons.money,
            null,
            selected == 2,
            payBank,
            () {
              if (payBank) {
                setState(() => selected = 2);
                widget.fun(2);
              }
            },
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
  final bool selected;
  final bool active;
  final Function fun;
  const WaletPaymentEach(
      this.title, this.icon, this.price, this.selected, this.active, this.fun,
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
                style: TextStyle(
                  color: active
                      ? const Color(0xEA000000)
                      : const Color(0xEA3B3B3B),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              if (price != null)
                Text(
                  "Balance " + ((price ?? 1) / 100).toString(),
                  style: const TextStyle(
                    color: Color(0xEA808080),
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
          child: Icon(icon, color: const Color(0xD33A3A3A)),
        ),
      ],
    );
  }
}
