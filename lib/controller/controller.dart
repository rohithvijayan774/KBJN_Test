import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kjbn_test/view/home_screen.dart';
import 'package:kjbn_test/view/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Controller with ChangeNotifier {
  int seconds = 5;
  Timer? timer;
  int totalSeconds = 0;
  int randomNumber = 0;
  bool isTimeRunning = false;
  bool isStarted = false;
  int totalAttempts = 0;
  int success = 0;
  int failure = 0;

  ///////////FOR START COUNTING
  void startCount() {
    isStarted = true;
    isTimeRunning = true;
    seconds = 5;
    totalAttempts++;
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (seconds > 0) {
        seconds--;
        totalSeconds++;

        if (totalSeconds == randomNumber) {
          success++;
          stopCount();
        }
        notifyListeners();
      } else {
        stopCount();
        failure++;

        seconds = 5;

        notifyListeners();
      }
      saveData();
    });
  }

  ///////////TO STOP COUNTING
  void stopCount() {
    isTimeRunning = false;
    timer?.cancel();
    notifyListeners();
  }

  ///////////TO GENERATE RANDOM NUMBER
  void generateRandomNumber() {
    final random = Random();
    randomNumber = random.nextInt(59);
    notifyListeners();
  }

  ///////////STORE DATA TO LOCAL STORAGE
  Future<void> saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setInt('seconds', seconds);
    await prefs.setInt('randomNumber', randomNumber);
    await prefs.setInt('totalSeconds', totalSeconds);
    await prefs.setInt('totalAttempts', totalAttempts);
    await prefs.setInt('success', success);
    await prefs.setInt('failure', failure);
    notifyListeners();
  }

  ///////////RETRIEVE DATA FROM LOCAL STORAGE
  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    seconds = prefs.getInt('seconds') ?? 5;
    randomNumber = prefs.getInt('randomNumber') ?? 0;
    totalSeconds = prefs.getInt('totalSeconds') ?? 0;
    totalAttempts = prefs.getInt('totalAttempts') ?? 0;
    success = prefs.getInt('success') ?? 0;
    failure = prefs.getInt('failure') ?? 0;
  }

  
  ///////////GOTO HOMESCREEN FROM SPLASHSCREEN
  Future<void> gotoNext(context) async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const HomeScreen(),
    ));
  }


  ///////////RESET ALL DATA
  Future<void> resetAll(context) async {
    seconds = 5;
    randomNumber = 0;
    totalSeconds = 0;
    totalAttempts = 0;
    success = 0;
    failure = 0;
    saveData();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const SplashScreen(),
    ));
    notifyListeners();
  }
}
