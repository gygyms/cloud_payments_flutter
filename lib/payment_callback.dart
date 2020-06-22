
import 'package:flutter/cupertino.dart';
typedef void CryptogramSuccessCallbackFunction(String cryptogram,BuildContext context);
typedef void CryptogramErrorCallbackFunction(String error, BuildContext context);

class PaymentCallback{
  CryptogramSuccessCallbackFunction onCardPaymentCallback;//(String cryptogram,BuildContext context);
  CryptogramErrorCallbackFunction onCardPaymentError;

  PaymentCallback(this.onCardPaymentCallback,
      this.onCardPaymentError); //(String error, BuildContext context);

}