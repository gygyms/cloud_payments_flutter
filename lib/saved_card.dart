
class SavedCard{
  String name;
  String expirationDate;
  String firstDigits;
  String lastDigits;
  String type;
  String id;

  SavedCard(this.name, this.expirationDate, this.firstDigits, this.lastDigits,
      this.type,this.id);

  SavedCard.fromJson(Map<String,String> json){
    this.name = json['name'];
    this.expirationDate = json['exp_date'];
    this.firstDigits = json['first_six'];
    this.lastDigits = json['last_four'];
    this.type = json['type'];
    this.id = json['id'];
  }
}