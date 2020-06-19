
import 'package:flutter/cupertino.dart';

abstract class PaymentCallback{
  void onCardPaymentCallback(String cryptogram,BuildContext context);
  void onCardPaymentError(String error, BuildContext context);
}