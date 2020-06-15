import 'package:cloudpaymentsflutter_example/home_page.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:cloudpaymentsflutter/cloudpaymentsflutter.dart';
import 'package:cloudpaymentsflutter/payment_parameters.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
   String platformVersion;

    // Platform messages may fail, so we use a try/catch PlatformException.
   /* try {
      platformVersion = await Cloudpaymentsflutter.getPlatformVersion(PaymentParameters("5469610012558226","0922","400"),context);
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }*/

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

  //  setState(() {
  //    _platformVersion = platformVersion;
  //  });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) =>
            HomePage(context),
      },
      //onGenerateRoute: (RouteSettings settings) => _getRoute(context, settings),
      initialRoute: "/home",
    );
  }
}
