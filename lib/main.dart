
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wondrx_assignment/pref/PrefsSingleton.dart';
import 'package:wondrx_assignment/ui/splash_page.dart';

import 'bloc/BlocBase.dart';
import 'bloc/SplashBloc.dart';

Future main() async {

  PrefsSingleton.prefs = await SharedPreferences.getInstance();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(new MaterialApp(
      title: "Michael Jackson",
      home: BlocProvider(
        child: SplashScreen(),
        bloc: SplashBloc(),
      ),
    ));
  });

}