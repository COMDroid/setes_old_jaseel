import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Loading());
  }
}

class Loading extends StatelessWidget {
  final bool viewStatus;
  const Loading({Key? key, this.viewStatus = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
              child: CircularProgressIndicator(), width: 40, height: 40),
          if (viewStatus)
            const Padding(
                padding: EdgeInsets.only(top: 16), child: Text('Loading...'))
        ],
      ),
    );
  }
}

class ErrorPage extends StatelessWidget {
  final String error;
  final Function? fun;
  const ErrorPage({Key? key, this.error = "Error", this.fun}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ErrorBody(error: error, fun: fun));
  }
}

class ErrorBody extends StatelessWidget {
  final String error;
  final Function? fun;
  const ErrorBody({Key? key, this.error = "Error", this.fun}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Error:",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black45,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            error,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black45,
            ),
          ),
          const SizedBox(height: 5),
          if (fun != null)
            TextButton(
              onPressed: () => fun!(),
              child: const Text(
                "Click to reload",
                style: TextStyle(
                  color: Color.fromARGB(115, 82, 145, 204),
                  fontSize: 15,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class ExpiredPage extends StatelessWidget {
  const ExpiredPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("App Expired, update your app")),
    );
  }
}
