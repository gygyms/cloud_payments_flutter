
class PaymentParameters{
  String cardNumber;
  String cardDate; //формат MMYY
  String cardCVV;
  String publicId;


  PaymentParameters(this.cardNumber, this.cardDate, this.cardCVV,this.publicId);

  Map<String,String> toMap(){
    var map = Map<String,String>();
    map['card_number'] = cardNumber;
    map['card_date'] = cardDate;
    map['card_cvv'] = cardCVV;
    map['public_id'] = publicId;
    return map;
  }
}