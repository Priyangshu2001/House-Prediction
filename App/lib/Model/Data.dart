class Data{
  late final int resale;
  late final int bhk;
  late final int sqft;
  late final double lat;
  late final double long;

  Data({
    required this.resale,
    required this.bhk,
    required this.sqft,
    required this.lat,
    required this.long,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      resale: int.parse(json["resale"]),
      bhk: int.parse(json["bhk"]),
      lat: double.parse(json["lat"]),
      long: double.parse(json["long"]),
      sqft: int.parse(json["sqft"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
       "resale": this.resale,
      "bhk": this.bhk,
      "sqft":this.sqft,
      "lat": this.lat,
      "long": this.long,
    };
  }
//

}
class Predicted{
  late final double predicted;

  Predicted({
    required this.predicted,
  });

  factory Predicted.fromJson(Map<String, dynamic> json) {
    print(json["predicted"]);
    return Predicted(
      predicted: json["predicted"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "predicted": this.predicted,
    };
  }
//

}