
class SavedCard{
  String name;
  String expirationDate;
  String firstDigits;
  String lastDigits;
  String type;
  String id;

  SavedCard(this.name, this.expirationDate, this.firstDigits, this.lastDigits,
      this.type,this.id);

  SavedCard.fromJson(Map<String,dynamic> json){
    this.name = json['name'].toString();
    this.expirationDate = json['exp_date'].toString();
    this.firstDigits = json['first_six'].toString();
    this.lastDigits = json['last_four'].toString();
    this.type = json['type'].toString();
    this.id = json['id'].toString();
  }
}