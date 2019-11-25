import 'package:flutter/material.dart';
import 'package:wondrx_assignment/bloc/BlocBase.dart';
import 'package:wondrx_assignment/bloc/SplashBloc.dart';
import 'package:wondrx_assignment/model/Song.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {

  ScrollController _scrollController;

  List<Container> mjSongs = new List();

  SplashBloc _splashBloc;
  List<Song> mjSongList;

  _buildSongList(List<Song> songList) {
    for (Song song in songList) {
      mjSongs.add(Container(
        child: Card(
          color: Colors.amber,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                      child: Container(
                        width: 80.0,
                        height: 80.0,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            image: new DecorationImage(
                                image: NetworkImage(song.artworkUrl30),
                                fit: BoxFit.fill),
                            borderRadius: BorderRadius.all(Radius.circular(75.0)),
                            boxShadow: [
                              BoxShadow(blurRadius: 7.0, color: Colors.black)
                            ]),
                      ),

                  ),

               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Chip(
                        label:Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.play_circle_filled,
                              color: Colors.red,
                            ),
                            Flexible(
                              child: Text(song.trackName,overflow: TextOverflow.ellipsis,maxLines: 1,
                                softWrap: false,),
                            )
                          ],),
                        shadowColor: Colors.blue,
                        backgroundColor: Colors.white,
                        elevation: 10,
                        autofocus: true,
                      ),
               ),

              ],
            ),

        ),
      ));
    }

    return mjSongs;
  }

  @override
  void initState() {
    super.initState();
    _splashBloc = BlocProvider.of<SplashBloc>(context);
    _splashBloc.getLocalDBSong();
    mjSongList = new List();

    _scrollController = ScrollController()
      ..addListener(() => setState(() {}));

  }

  bool get _showTitle {
    return _scrollController.hasClients
        && _scrollController.offset > 200 - kToolbarHeight;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(

        controller: _scrollController,

        headerSliverBuilder: (BuildContext context,bool innerBoxIsScrolled){

          return <Widget>[

            SliverAppBar(
              backgroundColor: Colors.red,
              expandedHeight: 200.0,
              floating: false,
              pinned: true,

              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: _showTitle ? Text('Michael Jackson Songs',style: TextStyle(color: Colors.white,fontSize: 16.0,)) : null,
                background: Image.asset('images/banner.jpg', fit: BoxFit.fill,),
              ),
            ),
          ];

        },

        body: Container(
          color: Colors.black,
          child: StreamBuilder<List<Song>>(
              stream: _splashBloc.songListstream,
              builder: (context, snapshot) {

                mjSongList = snapshot.data;

                if (!snapshot.hasData) {
                  return Center(child: Container(child: CircularProgressIndicator()));
                }

                return GridView.count(
                  padding: EdgeInsets.only(top: 0),
                  crossAxisCount: 2,
                  scrollDirection: Axis.vertical,
                  children: _buildSongList(mjSongList),
                );
              }),
        ),
      ),
    );
  }
}
