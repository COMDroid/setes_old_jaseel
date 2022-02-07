import 'package:flutter/cupertino.dart';
import 'package:setes_mobile/module/api_init.dart';
import 'package:setes_mobile/screen/warnings.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  bool loading = true;

  @override
  Widget build(BuildContext context) {
    // if (loading) return LoadingPage();
    return WebView(
      initialUrl: eventsWeb,
      javascriptMode: JavascriptMode.unrestricted,
      // onPageStarted: (s) => setState(() => loading = true),
      // onPageFinished: (f) => setState(() => loading = false),
    );
  }
}
