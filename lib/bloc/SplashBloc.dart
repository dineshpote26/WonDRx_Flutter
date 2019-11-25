import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:wondrx_assignment/dao/MJDao.dart';
import 'package:wondrx_assignment/model/Song.dart';
import 'package:wondrx_assignment/repository/SongRepository.dart';

import 'BlocBase.dart';

class SplashBloc extends BlocBase {
  final _songRepo = SongRepository();
  final _mjDao = MJDao();

  final _successDBAddController = StreamController<bool>.broadcast();
  get successStream => _successDBAddController.stream;

  final _songListController = StreamController<List<Song>>.broadcast();
  get songListstream => _songListController.stream;

  Future<bool> addSongLocalDb() async {
    try {
      List<Song> mjSongList = await _songRepo.getRemoteMJSongList();

      if (mjSongList != null && mjSongList.length > 0) {
        for (Song song in mjSongList) {
          _mjDao.createMJSongList(song);
          debugPrint(song.trackName + "added");
        }
        _successDBAddController.sink.add(true);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint("Error" + e.toString());
      _successDBAddController.sink.add(false);
      return false;
    }
  }

  Future<List<Song>> getLocalDBSong() async {
    List<Song> songList = await _songRepo.getLocalMJSongList();

    if (songList == null) {
      songList = new List();
    }

    _songListController.sink.add(songList);
    return songList;
  }

  @override
  void dispose() {
    _successDBAddController.close();
    _songListController.close();
  }
}
