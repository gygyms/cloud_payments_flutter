import 'dart:async';

import 'package:cloudpaymentsflutter/payment_parameters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Cloudpaymentsflutter {
  static const MethodChannel _channel =
      const MethodChannel('cloudpaymentsflutter');

  static Future<String> getPlatformVersion(PaymentParameters paymentParameters,BuildContext context) async {
    var map = paymentParameters.toMap();
    showBottomSheet(
        context: context,
        builder: (context) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            FlatButton(
                child: Text('Карта'),
              onPressed: () async {
                await _channel.invokeMethod('show_3ds',map);
              },
            ),
            Text('Google pay'),
            Text('Сохраненная 8226')
          ],
        )
    );
    final String version = await _channel.invokeMethod('getPlatformVersion',map);
    return version;
  }
}
