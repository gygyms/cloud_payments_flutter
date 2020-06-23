
import 'package:flutter/cupertino.dart';
typedef void CryptogramSuccessCallbackFunction(String cryptogram,BuildContext context);
typedef void CryptogramErrorCallbackFunction(String error, BuildContext context);
typedef void RecurringCallbackFunction(String token, BuildContext context);


class PaymentCallback{
  CryptogramSuccessCallbackFunction onCardPaymentCallback;//(String cryptogram,BuildContext context);
  CryptogramErrorCallbackFunction onCardPaymentError;

  RecurringCallbackFunction onRecurrentPaymentCallback;

  PaymentCallback(this.onCardPaymentCallback,
      this.onCardPaymentError,this.onRecurrentPaymentCallback); //(String error, BuildContext context);

}