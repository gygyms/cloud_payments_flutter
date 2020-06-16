
class ThreeDsParameters{
  String url;
  String paReq;
  String transactionId;

  ThreeDsParameters(this.url, this.paReq, this.transactionId);

  Map<String,String> toMap(){
    var map = Map<String,String>();
    map['url'] = url;
    map['paReq'] = paReq;
    map['transactionId'] = transactionId;
    return map;
  }
}