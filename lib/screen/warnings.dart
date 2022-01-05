import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Loading());
  }
}

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const <Widget>[
          SizedBox(child: CircularProgressIndicator(), width: 40, height: 40),
          Padding(padding: EdgeInsets.only(top: 16), child: Text('Loading...'))
        ],
      ),
    );
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: ErrorBody());
  }
}

class ErrorBody extends StatelessWidget {
  const ErrorBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Error"));
  }
}
