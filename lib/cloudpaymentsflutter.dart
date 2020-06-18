import 'dart:async';

import 'package:cloudpaymentsflutter/3ds_parameters.dart';
import 'package:cloudpaymentsflutter/payment_parameters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Cloudpaymentsflutter {
  static const MethodChannel _channel =
  const MethodChannel('cloudpaymentsflutter');

  static Future<String> getPlatformVersion(PaymentParameters paymentParameters,BuildContext context,GlobalKey<ScaffoldState> scaffoldKey) async {
    var map = paymentParameters.toMap();
    scaffoldKey.currentState.showBottomSheet(
            (context) => PaymentWidget(context,scaffoldKey)
    );
    final String version = await _channel.invokeMethod('getPlatformVersion',map);
    return version;
  }

  static Future<String> show3Ds(ThreeDsParameters threeDsParameters) async {
    var map = threeDsParameters.toMap();
    await _channel.invokeMethod('show_3ds',map);

  }
}

class PaymentWidget extends StatefulWidget{
  BuildContext context;
  GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State createState() => PaymentWidgetState();

  PaymentWidget(this.context, this.scaffoldKey);

}

class PaymentWidgetState extends State<PaymentWidget>{

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        FlatButton(
          child: Text('Карта'),
          onPressed: () async {
            //await _channel.invokeMethod('show_3ds',map);
          },
        ),
        // Text('Google pay'),
        //  Text('Сохраненная 8226')
      ],
    );
  }
}