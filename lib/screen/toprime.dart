import 'package:flutter/material.dart';
import 'package:setes_mobile/method/toprime.dart';
import 'package:setes_mobile/module/simple.dart';
import 'package:setes_mobile/widget/buttons.dart';

class ToPrimePage extends StatelessWidget {
  const ToPrimePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffE2F1F4),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: -50,
            height: scr.height * .45,
            child: Padding(
              padding: EdgeInsets.only(
                left: scr.width * .45,
                top: 0,
                bottom: 0,
              ),
              child: Image.asset(
                "assets/loginBg.jpeg",
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: scr.height * .35,
            child: Container(
              padding: EdgeInsets.only(
                left: scr.width * .1,
                bottom: scr.height * .08,
              ),
              color: const Color(0xdd1368A9),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const <Widget>[
                  Text(
                    "Welcome To",
                    style: TextStyle(
                      color: Color(0xFFF7D037),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    " SETES COMMUNITY,",
                    style: TextStyle(
                      color: Color(0xFFF7D037),
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: scr.height * .2,
            left: 12,
            right: 12,
            height: scr.height * .82 - 100,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ToPrimeForm(),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: scr.width * .1,
            right: scr.width * .1,
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: "By clicking the button you are accepting the ",
                    style: TextStyle(
                      color: Colors.black26,
                      fontSize: 12,
                      letterSpacing: .2,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: "Terms & Privacy Policy",
                    style: TextStyle(
                      color: Color(0x991368A9),
                      fontSize: 12,
                      letterSpacing: .2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ToPrimeForm extends StatefulWidget {
  const ToPrimeForm({Key? key}) : super(key: key);

  @override
  _ToPrimeFormState createState() => _ToPrimeFormState();
}

class _ToPrimeFormState extends State<ToPrimeForm> {
  bool loading = true;
  String? error;
  Map primeData = {};

  String? bloodGp;
  Map? district;
  Map? zone;
  List zones = [];
  Map? home;
  List homes = [];
  String? bootsize;
  String? tshitrsize;
  String? favposition;
  String? secfavposition;
  String? strongfoot;

  @override
  void initState() {
    getPrimePrice(this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size scr = getScreen(context);
    return Column(
      children: [
        const SizedBox(height: 5),
        const Text(
          "Upgrade to Setes Community",
          style: TextStyle(
            color: Color(0xFF1368A9),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.only(top: 8),
            children: [
              DroperButton(
                Icons.bloodtype,
                'Blood Group',
                bloodGp,
                loading ? [] : primeData['blood_groups'],
                (v) => setState(() => bloodGp = v),
              ),
              const SizedBox(height: 10),
              DroperButton2(
                Icons.landscape,
                'District',
                district,
                loading ? [] : primeData['locations'][0]['zone'],
                (v) => setState(() {
                  district = v;
                  zones = v['zone'];
                  zone = null;
                }),
              ),
              const SizedBox(height: 10),
              DroperButton2(
                Icons.landscape,
                'Zone',
                zone,
                zones,
                (v) => setState(() => zone = v),
              ),
              const SizedBox(height: 10),
              DroperButton(
                Icons.ice_skating,
                'Boot Size',
                bootsize,
                loading ? [] : primeData['boot_sizes'],
                (v) => setState(() => bootsize = v),
              ),
              const SizedBox(height: 10),
              DroperButton(
                Icons.checkroom,
                'T-Shirt Size',
                tshitrsize,
                loading ? [] : primeData['tshirt_sizes'],
                (v) => setState(() => tshitrsize = v),
              ),
              const SizedBox(height: 10),
              DroperButton(
                Icons.sports_handball,
                'Favorite Position',
                favposition,
                loading ? [] : primeData['positions'],
                (v) => setState(() => favposition = v),
              ),
              const SizedBox(height: 10),
              DroperButton(
                Icons.favorite_border,
                '2nd Favorite Position',
                secfavposition,
                loading ? [] : primeData['positions'],
                (v) => setState(() => secfavposition = v),
              ),
              const SizedBox(height: 10),
              DroperButton(
                Icons.handyman,
                'Strong Foot',
                strongfoot,
                loading ? [] : primeData['strong_foots'],
                (v) => setState(() => strongfoot = v),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        error == null
            ? const Text(
                'For a better communication we collect\n some of your above data',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black26,
                    fontSize: 10.5,
                    letterSpacing: .2,
                    fontWeight: FontWeight.w500),
              )
            : Text(
                error ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 10.5,
                  letterSpacing: .2,
                  fontWeight: FontWeight.w500,
                ),
              ),
        InkWell(
          onTap: () => toprime(this),
          child: Container(
            height: 50,
            width: scr.width,
            margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(7)),
              boxShadow: [
                BoxShadow(
                  offset: Offset(2, 3),
                  spreadRadius: 0,
                  blurRadius: 10,
                  color: Color(0x33000000),
                ),
              ],
              gradient: LinearGradient(
                colors: [Color(0xFF1368A9), Color(0xFFE2F1F4)],
                begin: FractionalOffset(0.0, 1.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
            ),
            child: loading
                ? const Center(
                    child: Text(
                      "Loading..",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 20),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        "NEXT",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      Icon(Icons.next_plan, color: Colors.white),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}
