
import 'package:flutter/cupertino.dart';
typedef void CryptogramSuccessCallbackFunction(String cryptogram,BuildContext context);
typedef void CryptogramErrorCallbackFunction(String error, BuildContext context);
typedef void RecurringCallbackFunction(String token, BuildContext context);
typedef void GooglePaySuccessCallbackFunction(String cryptogram,BuildContext context);
typedef void ErrorCallbackFunction(String error,BuildContext context);




class PaymentCallback{
  CryptogramSuccessCallbackFunction onCardPaymentCallback;//(String cryptogram,BuildContext context);
  CryptogramErrorCallbackFunction onCardPaymentError;

  RecurringCallbackFunction onRecurrentPaymentCallback;
  GooglePaySuccessCallbackFunction onGooglePaySuccessCallback;
  ErrorCallbackFunction onError;

  PaymentCallback(this.onCardPaymentCallback, this.onCardPaymentError,
      this.onRecurrentPaymentCallback, this.onGooglePaySuccessCallback,
      this.onError);


}