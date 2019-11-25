class Song {
  String trackName;
  String artworkUrl30;
  String releaseDate;
  String trackTimeMillis;
  String trackPrice;

  Song(
      {this.trackName,
      this.artworkUrl30,
      this.releaseDate,
      this.trackTimeMillis,
      this.trackPrice});

  factory Song.fromJson(Map<String, dynamic> json) => Song(
      trackName: json["trackName"],
      artworkUrl30: json["artworkUrl30"],
      releaseDate: DateTime.parse(json["releaseDate"]).toString(),
      trackTimeMillis: json["trackTimeMillis"].toString(),
      trackPrice: json["trackPrice"].toString()
  );

  Map<String, dynamic> toJson() => {
        "trackName": trackName,
        "artworkUrl30": artworkUrl30,
        "releaseDate": releaseDate.toString(),
        "trackTimeMillis": trackTimeMillis,
        "trackPrice": trackPrice
      };
}
