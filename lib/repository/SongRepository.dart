import 'package:flutter/cupertino.dart';
import 'package:wondrx_assignment/dao/MJDao.dart';
import 'package:wondrx_assignment/model/MJSong.dart';
import 'package:wondrx_assignment/model/Song.dart';
import 'package:wondrx_assignment/network/SongProvider.dart';

class SongRepository {

  final mjDao = new MJDao();
  final songProvider = new SongProvider();

  Future<List<Song>> getLocalMJSongList() async => await mjDao.getLocalMJSongLis();

  Future<List<Song>> getRemoteMJSongList() async {
    List<Song> songList = new List();

    try {
      MJSong mjSong = await songProvider.getMJSongList();
      songList = mjSong.songList;
    } catch (e) {
      debugPrint(e.toString());
    }

    return songList;
  }
}
