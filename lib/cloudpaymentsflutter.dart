import 'dart:async';

import 'package:cloudpaymentsflutter/3ds_parameters.dart';
import 'package:cloudpaymentsflutter/payment_callback.dart';
import 'package:cloudpaymentsflutter/payment_parameters.dart';
import 'package:cloudpaymentsflutter/saved_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Cloudpaymentsflutter {
  static const MethodChannel _channel =
  const MethodChannel('cloudpaymentsflutter');

  static Future<String> getPlatformVersion(List<SavedCard> savedCards,
      String publicId,
      BuildContext context, GlobalKey<ScaffoldState> scaffoldKey,
      PaymentCallback paymentCallback) async {
    scaffoldKey.currentState.showBottomSheet((context) =>
        PaymentWidget(
            context, scaffoldKey, GlobalKey<NavigatorState>(), publicId,
            savedCards, paymentCallback));
    /*  final String version =
        await _channel.invokeMethod('getPlatformVersion', map);
    */
    return "";
  }

  static Future<String> show3Ds(ThreeDsParameters threeDsParameters) async {
    var map = threeDsParameters.toMap();
    await _channel.invokeMethod('show_3ds', map);
  }
}

class PaymentWidget extends StatefulWidget {
  PaymentCallback paymentCallback;
  BuildContext context;
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<NavigatorState> navigatorKey;
  List<SavedCard> savedCards;
  final String publicId;

  @override
  State createState() => PaymentWidgetState();

  PaymentWidget(this.context, this.scaffoldKey, this.navigatorKey,
      this.publicId, this.savedCards, this.paymentCallback);
}

class PaymentWidgetState extends State<PaymentWidget> {
  Widget showingWidget;

  @override
  void initState() {
    super.initState();
    showingWidget = PaymentMethodsWidget(
        context, navigate, widget.publicId,widget.savedCards, widget.paymentCallback);
  }

  //Navigator navigator;
  @override
  Widget build(BuildContext context) {
    /* navigator = Navigator(
        key: GlobalKey<NavigatorState>(),
        initialRoute: '/',
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
              builder: (context) => _routeBuilders(context);
        });*/
    return showingWidget;
  }

  void navigate(Widget widget) {
    setState(() {
      showingWidget = widget;
    });
  }
}

class PaymentMethodsWidget extends StatelessWidget {
  BuildContext context;
  Function navigate;
  final String publicId;
  PaymentCallback paymentCallback;
  List<SavedCard> savedCards;

  PaymentMethodsWidget(this.context, this.navigate, this.publicId,
      this.savedCards, this.paymentCallback);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        FlatButton(
          child: Text('Google pay'),
          onPressed: () async {
            //await _channel.invokeMethod('show_3ds',map);
          },
        ),
        ListView.builder(
          shrinkWrap: true,
            itemCount: savedCards.length,
            itemBuilder: (context, index) {
              return FlatButton(
                child: Text(savedCards[index].name),
                onPressed: () async {
                  paymentCallback.onRecurrentPaymentCallback(savedCards[index].token,context);
                },
              );
            }),

        FlatButton(
          child: Text('Карта'),
          onPressed: () async {
            navigate(CardPaymentWidget(publicId, paymentCallback));
            //await _channel.invokeMethod('show_3ds',map);
          },
        ),
        // Text('Google pay'),
        //  Text('Сохраненная 8226')
      ],
    );
  }
}

class CardPaymentWidget extends StatefulWidget {
  final String publicId;
  PaymentCallback paymentCallback;


  CardPaymentWidget(this.publicId, this.paymentCallback);

  @override
  State<StatefulWidget> createState() => CardPaymentWidgetState();
}

class CardPaymentWidgetState extends State<CardPaymentWidget> {
  static const MethodChannel _channel =
  const MethodChannel('cloudpaymentsflutter');
  String cardNumber = "";
  String date = "";
  String cvc = "";
  String name = "";


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
                hintText: 'Card number'),
            onChanged: (text) {
              cardNumber = text;
              print("First text field: $text");
            },
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Date',
                  ),
                  onChanged: (text) {
                    date = text;
                    print("First text field: $text");
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 16.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: 'CVC'),
                  onChanged: (text) {
                    cvc = text;
                    print("First text field: $text");
                  },
                ),
              ),
            ),

          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
          child: TextField(
            decoration: const InputDecoration(
                hintText: 'Card holder'),
            onChanged: (text) {
              name = text;
              print("First text field: $text");
            },
          ),
        ),
        FlatButton(
          child: Text('Оплатить'),
          onPressed: () async {
            Navigator.pop(context);
            _channel.invokeMethod('getPlatformVersion',
                PaymentParameters(cardNumber, date, cvc, widget.publicId)
                    .toMap()).catchError((onError) {
              widget.paymentCallback.onCardPaymentError(
                  onError.toString(), context);
            }).then((value) {
              if (value != null)
                widget.paymentCallback.onCardPaymentCallback(value, context);
            }
            );
            //await _channel.invokeMethod('show_3ds',map);
          },
        ),
      ],
    );
  }
}
