import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../core/utils.dart';
import '../presentation/screen/name_screen.dart';

export 'package:provider/provider.dart';

class AuthProvider extends ChangeNotifier {
  Timer? _countdownTimer;
  int initialCountdownSeconds = 0;
  int defaultTimeToStart = 10;
  bool reSendCode = false;

  void startCountdown() {
    reSendCode = false;
    initialCountdownSeconds = defaultTimeToStart;
    notifyListeners();

    print('startCountdown');
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (initialCountdownSeconds > 0) {
        initialCountdownSeconds--;
      } else {
        _countdownTimer!.cancel();
        reSendCode = true;
      }
      notifyListeners();
    });
  }

  doneOtp(BuildContext context) {
    Utils.navigateAndRemoveUntilTo(NameScreen(), context);
  }

  String currentOtp = '';
  updateCurrentOtp({required String char}) {
    currentOtp = char;
    notifyListeners();
  }
}
