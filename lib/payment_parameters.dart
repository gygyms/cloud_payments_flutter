
class PaymentParameters{
  String cardNumber;
  String cardDate; //формат MMYY
  String cardCVV;


  PaymentParameters(this.cardNumber, this.cardDate, this.cardCVV);

  Map<String,String> toMap(){
    var map = Map<String,String>();
    map['card_number'] = cardNumber;
    map['card_date'] = cardDate;
    map['card_cvv'] = cardCVV;
    return map;
  }
}