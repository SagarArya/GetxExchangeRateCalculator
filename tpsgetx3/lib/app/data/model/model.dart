class Model {
  int? id;
  String? text;

  Model({this.id, this.text});

  Model.fromJson(Map<String, dynamic> json) {
    this.id = json['_id'];
    this.text = json['text'];
  }
}

class Rate {
  String? info;
  String? description;
  String? timeStampString;
  get timeStamp => int.parse(timeStampString ?? "0");

  Map<String, dynamic> rates = {};

  Rate.fromJson(Map<String, dynamic> json) {
    this.info = json['info'];
    this.description = json['description'];
    this.timeStampString = json['timestamp'];
    this.rates = json['rates'];
  }
}
