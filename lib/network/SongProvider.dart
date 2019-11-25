import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:wondrx_assignment/model/MJSong.dart';

import 'BaseApi.dart';

class SongProvider extends BaseApi{

  Future<MJSong> getMJSongList() async {
    MJSong mjSong;
    try{
      var response = await getHttp("https://itunes.apple.com/search?term=Michael+jackson");
      mjSong = MJSong.fromJson(response);

    }catch(e){
      debugPrint(e.toString());
    }
    return mjSong;
  }

}