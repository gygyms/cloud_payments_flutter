import 'package:cloudpaymentsflutter/cloudpaymentsflutter.dart';
import 'package:cloudpaymentsflutter/saved_card.dart';
import 'package:cloudpaymentsflutter/payment_callback.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
/*class PaymentCallbackImpl implements PaymentCallback{
  @override
  void onCardPaymentCallback(String cryptogram,BuildContext context) {
    print("sended to server");
  }

  @override
  void onCardPaymentError(String crypt,BuildContext context) {
    print("showing error");
  }

}*/

class HomePage extends StatelessWidget {
  BuildContext context;

  HomePage(this.context);
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();



  @override
  Widget build(BuildContext context) {
    var callback = PaymentCallback((cryptogram,context){
      print("sended to server");
    },(error,context){
      print("showing error");
    },(token,context){
      print(token);
    });
    return Scaffold(
      key:scaffoldKey,
      appBar: AppBar(title: Text("AppBar",)),
      body:Builder(
        builder:(context)=>Container(
        child: FlatButton(
          child: Text("open"),
          onPressed: () async {
            String platformVersion;
            // Platform messages may fail, so we use a try/catch PlatformException.
            try {
              platformVersion = await Cloudpaymentsflutter.getPlatformVersion(List<SavedCard>()..add(SavedCard("saved_card1",'09/22','833344','4444','Mastercard','1'))..add(SavedCard("saved_card2",'09/22','822244','1111','Mastercard','2')),"pt_000000",context,scaffoldKey,
                  callback);
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
