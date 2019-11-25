import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wondrx_assignment/bloc/BlocBase.dart';
import 'package:wondrx_assignment/bloc/SplashBloc.dart';
import 'package:wondrx_assignment/pref/PrefsSingleton.dart';
import 'package:wondrx_assignment/ui/home_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenSate();
  }
}

class SplashScreenSate extends State<SplashScreen> {
  SplashBloc _splashBloc;

  @override
  void initState() {
    super.initState();

    _splashBloc = BlocProvider.of<SplashBloc>(context);

    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'images/logo.jpg',
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                  ),
                  Text(
                    'Please wait',
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.black54),
                  )
                ],
              ),
            ),
          ],
        )
      ],
    ));
  }

  void loadRemoteDataIntoLocalDB() async {
    var isFirstTime = PrefsSingleton.prefs.getBool("isFirstTime");

    if (isFirstTime != null && isFirstTime) {
      navigateToHomeScreen();
    } else {
      bool isDataAdded = await _splashBloc.addSongLocalDb();
      if (isDataAdded) {
        PrefsSingleton.prefs.setBool("isFirstTime", true);
        navigateToHomeScreen();
      } else {
        showError();
      }
    }
  }

  void navigateToHomeScreen() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return BlocProvider(
        bloc: SplashBloc(),
        child: HomePage(),
      );
    }));
  }

  void showError() {
    Fluttertoast.showToast(
        msg: "Something goes wrong Please try again later",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  startTimer() async {
    var duration = const Duration(seconds: 3);
    return new Timer(duration, loadRemoteDataIntoLocalDB);
  }
}
