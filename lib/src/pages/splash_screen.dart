import 'package:flutter/material.dart';
import 'package:markets/src/helpers/colors.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../controllers/splash_screen_controller.dart';
import 'package:percent_indicator/percent_indicator.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends StateMVC<SplashScreen> {
  SplashScreenController _con;
  SplashScreenState() : super(SplashScreenController()) {
    _con = controller;
  }
  double loading_progress = 0.0;
  bool _isCompleted = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {
    _con.progress.addListener(() {
      double progress = 0;

      _con.progress.value.values.forEach((_progress) {
        print("${_progress} values");
        progress += _progress;
        loading_progress = loading_progress + 0.15;
        print("${loading_progress}");
      });
      if (progress == 100 && !_isCompleted) {
        print('progress is 100.');
        try {
          Navigator.of(context).pushReplacementNamed('/Pages', arguments: 0);
          _isCompleted = true;
        } catch (e) {}
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(3, 30, 38, 1.0),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/img/amelia_rose.png',
              ),
              // SizedBox(height: 50),
              Text(
                "Загружаем товары...",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .merge(TextStyle(color: primary_50, height: 1.2)),
              ),
              SizedBox(height: 16),
              CircularPercentIndicator(
                  radius: 50.0,
                  lineWidth: 5.0,
                  animation: true,
                  animateFromLastPercent: true,
                  addAutomaticKeepAlive: true,
                  // animationDuration: 1200,
                  percent: 1.0,
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: secondary_300,
                  backgroundColor: Color.fromRGBO(14, 47, 57, 1.0)),
              // CircularProgressIndicator(
              //   valueColor:
              //       AlwaysStoppedAnimation<Color>(secondary_300),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
