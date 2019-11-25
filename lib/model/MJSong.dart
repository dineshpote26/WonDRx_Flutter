import 'Song.dart';

class MJSong{

  int resultCount;
  List<Song> songList;

  MJSong({
    this.resultCount,
    this.songList,
  });


  factory MJSong.fromJson(Map<String, dynamic> json) => MJSong(
    resultCount: json["resultCount"],
    songList: List<Song>.from(json["results"].map((x) => Song.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "resultCount": resultCount,
    "results": List<dynamic>.from(songList.map((x) => x.toJson())),
  };

}