import 'package:cloudpaymentsflutter/cloudpaymentsflutter.dart';
import 'package:cloudpaymentsflutter/payment_parameters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatelessWidget {
  BuildContext context;

  HomePage(this.context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("AppBar",)),
      body:Builder(
        builder:(context)=>Container(
        child: FlatButton(
          child: Text("open"),
          onPressed: () async {
            String platformVersion;
            // Platform messages may fail, so we use a try/catch PlatformException.
            try {
              platformVersion = await Cloudpaymentsflutter.getPlatformVersion(PaymentParameters("","",""),context);
            } on PlatformException {
              platformVersion = 'Failed to get platform version.';
            }
          },
        ),
      ),
    )
    );
  }
}
