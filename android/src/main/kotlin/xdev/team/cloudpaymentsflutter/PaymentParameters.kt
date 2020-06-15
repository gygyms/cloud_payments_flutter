package xdev.team.cloudpaymentsflutter

class PaymentParameters {
    var cardNumber:String?
    var cardDate:String?
    var cardCVV:String?

    constructor(map: HashMap<String, String>){
        cardNumber = map["card_number"]
        cardDate = map["card_date"]
        cardCVV = map["card_cvv"]
    }
}