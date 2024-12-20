import 'dart:async';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:fisaa/features/home/presentation/screens/home_screen.dart';
import 'package:fisaa/features/login/presentation/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/app_color.dart';
import '../../../../core/enums/request_state.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/failures_messages.dart';
import '../../../../core/utils.dart';
import '../../../intro/domain/entities/main_app_required.dart';
import '../../../intro/domain/entities/user_data_model.dart';
import '../../../intro/domain/use_cases/get_stuff_types_use_case.dart';
import '../../../intro/domain/use_cases/get_user_data_use_case.dart';
import '../../domain/entities/user_data_with_otp_model.dart';
import '../../domain/use_cases/add_required_data_use_cases.dart';
import '../../domain/use_cases/check_otp_use_cases.dart';
import '../../domain/use_cases/login_use_cases.dart';
import '../../domain/use_cases/logout_use_cases.dart';
import '../../domain/use_cases/update_profile_use_cases.dart';
import '../screen/complete_sign_up.dart';
import '../screen/name_screen.dart';
import '../screen/otp_screen.dart';

export 'package:provider/provider.dart';

class AuthProvider extends ChangeNotifier {
  Timer? _countdownTimer;
  int initialCountdownSeconds = 0;
  int defaultTimeToStart = 10;
  bool reSendCode = false;
  final GetUserDataUseCases getUserDataUseCases;
  final GetStuffTypesDataUseCases getStuffTypesDataUseCases;
  final AddRequiredDataUseCases addRequiredDataUseCases;
  final CheckOtpUseCases checkOtpUseCases;
  final LoginUseCases loginUseCases;
  final LogOutUseCases logOutUseCases;
  final UpdateUserDataUseCases updateUserDataUseCases;

  AuthProvider(
      {required this.getUserDataUseCases,
      required this.addRequiredDataUseCases,
      required this.logOutUseCases,
      required this.updateUserDataUseCases,
      required this.checkOtpUseCases,
      required this.loginUseCases,
      required this.getStuffTypesDataUseCases}) {
    print('AuthProvider');
    // _getUserData();
    _getStuffTypesData();
  }
  RequestState stateOfHome = RequestState.initial;
  RequestState stateOfLogin = RequestState.initial;
  RequestState stateOfOtp = RequestState.initial;
  RequestState stateOfCompleteProfile = RequestState.initial;
  String? message;
  UserData? userData;
  UserData? tempUserData;
  num? otp;
  MainAppRequiredModel? stuffTypesData;
  logOut() async {
    await logOutUseCases();
  }

  isThereTokenAvailableHere({required BuildContext context}) async {
    try {
      bool isTokenAvailable = (await UserData.getToken) != null;
      print('isTokenAvailable:${isTokenAvailable}');
      if (isTokenAvailable) {
        await getUserData();
      }
      if (userData != null) {
        Utils.navigateAndRemoveUntilTo(HomeScreen(), context);
      } else {
        print('whenUserDataIsNotAvailable');
        Utils.navigateAndRemoveUntilTo(LoginScreen(), context);
      }
    } catch (e) {
      Utils.navigateAndRemoveUntilTo(LoginScreen(), context);
    }
  }

  getUserData() async {
    print('_getHomeData');
    stateOfHome = RequestState.loading;
    notifyListeners();

    final failureOrDoneMessage = await getUserDataUseCases();
    _eitherLoadedOrErrorState(failureOrDoneMessage);
  }

  _getStuffTypesData() async {
    print('_getHomeData');
    stateOfHome = RequestState.loading;
    notifyListeners();

    final failureOrDoneMessage = await getStuffTypesDataUseCases();
    _eitherLoadedOrErrorFRomStuffTypesState(failureOrDoneMessage);
  }

  resentOtp({required BuildContext context}) async {
    stateOfOtp = RequestState.loading;
    notifyListeners();
    await loginRequest(
        phone: tempUserData?.phone ?? '', context: context, noAction: true);
    notifyListeners();
    startCountdown();
    stateOfOtp = RequestState.done;
    notifyListeners();
  }

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

  String? tempName;
  saveTheTempName({required String name}) {
    tempName = name;
    notifyListeners();
  }

  doneOtp(String text, BuildContext context) async {
    stateOfOtp = RequestState.loading;
    notifyListeners();

    final failureOrDoneMessage =
        await checkOtpUseCases(otp: text, phone: tempUserData?.phone ?? '');
    _eitherLoadedOrErrorOtpState(failureOrDoneMessage);
    print('stateOfHome:$stateOfHome');
    if (stateOfOtp == RequestState.error) {
      Fluttertoast.showToast(
          msg: message ?? '',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColor.mainColor,
          textColor: Colors.white,
          fontSize: 16.0.sp);
    } else if (stateOfOtp == RequestState.done) {
      if (tempUserData?.name == null) {
        Utils.navigateAndRemoveUntilTo(NameScreen(), context);
      } else {
        userData = tempUserData;
        Utils.navigateAndRemoveUntilTo(HomeScreen(), context);
      }
    }
  }

  String currentOtp = '';
  updateCurrentOtp({required String char}) {
    currentOtp = char;
    notifyListeners();
  }

  loginRequest(
      {required String phone,
      required BuildContext context,
      bool? noAction}) async {
    print('loginRequest');
    stateOfLogin = RequestState.loading;
    notifyListeners();

    final failureOrDoneMessage = await loginUseCases(phone: phone);
    _eitherLoadedOrErrorLoginState(failureOrDoneMessage);
    print('stateOfHome:$stateOfHome');
    if (noAction == true) return;
    if (stateOfLogin == RequestState.error) {
      Fluttertoast.showToast(
          msg: message ?? '',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColor.mainColor,
          textColor: Colors.white,
          fontSize: 16.0.sp);
    } else if (stateOfLogin == RequestState.done) {
      Utils.navigateAndRemoveUntilTo(OtpScreen(), context);
      startCountdown();
    }
  }

  _eitherLoadedOrErrorLoginState(
    Either<Failure, UserDataWithOtpModel> failureOrTrivia,
  ) {
    failureOrTrivia.fold(
      (failure) {
        message = _mapFailureToMessage(failure);
        print('messageL:$message');
        stateOfLogin = RequestState.error;
      },
      (data) {
        tempUserData = data.usr;
        otp = data.otp;
        stateOfLogin = RequestState.done;
      },
    );
    notifyListeners();
  }

  updateUserData({
    required String email,
    required BuildContext context,
  }) async {
    print('loginRequest');
    stateOfCompleteProfile = RequestState.loading;
    notifyListeners();

    final failureOrDoneMessage =
        await addRequiredDataUseCases(email: email, name: tempName ?? '');
    _eitherLoadedOrErrorCompleteState(failureOrDoneMessage);
    print('stateOfHome:$stateOfHome');
    if (stateOfCompleteProfile == RequestState.error) {
      Fluttertoast.showToast(
          msg: message ?? '',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColor.mainColor,
          textColor: Colors.white,
          fontSize: 16.0.sp);
    } else if (stateOfCompleteProfile == RequestState.done) {
      Utils.navigateAndRemoveUntilTo(CompleteSignUp(), context);
    }
  }

  _eitherLoadedOrErrorCompleteState(
    Either<Failure, UserDataWithOtpModel> failureOrTrivia,
  ) {
    failureOrTrivia.fold(
      (failure) {
        message = _mapFailureToMessage(failure);
        print('messageL:$message');
        stateOfCompleteProfile = RequestState.error;
      },
      (data) {
        userData = data.usr;
        stateOfCompleteProfile = RequestState.done;
      },
    );
    notifyListeners();
  }

  _eitherLoadedOrErrorOtpState(
    Either<Failure, UserDataWithOtpModel> failureOrTrivia,
  ) {
    failureOrTrivia.fold(
      (failure) {
        message = _mapFailureToMessage(failure);
        print('messageL:$message');
        stateOfOtp = RequestState.error;
      },
      (data) {
        stateOfOtp = RequestState.done;
      },
    );
    notifyListeners();
  }

  _eitherLoadedOrErrorFRomStuffTypesState(
    Either<Failure, MainAppRequiredModel> failureOrTrivia,
  ) {
    failureOrTrivia.fold(
      (failure) {
        message = _mapFailureToMessage(failure);
      },
      (data) {
        print('?.types:${data.types?.length}');
        stuffTypesData = data;
      },
    );
    notifyListeners();
  }

  _eitherLoadedOrErrorState(
    Either<Failure, UserData> failureOrTrivia,
  ) {
    failureOrTrivia.fold(
      (failure) {
        message = _mapFailureToMessage(failure);
      },
      (data) {
        userData = data;
      },
    );
    notifyListeners();
  }

  bool activeNotification = false;
  updateNotificationActive() {
    print('updateNotificationActive:$activeNotification');
    activeNotification = !activeNotification;
    print('updateNotificationActive:$activeNotification');
    notifyListeners();
  }

  File? selectedImage;
  void setImage(XFile image) {
    selectedImage = File(image.path);
    notifyListeners();
  }

  void clearImage() {
    selectedImage = null;
    notifyListeners();
  }

  RequestState stateOfUpdateProfile = RequestState.initial;

  _eitherLoadedOrErrorUpdateState(
    Either<Failure, UserData> failureOrTrivia,
  ) {
    failureOrTrivia.fold(
      (failure) {
        message = _mapFailureToMessage(failure);
        print('messageL:$message');
        stateOfUpdateProfile = RequestState.error;
      },
      (data) {
        userData = data;
        stateOfUpdateProfile = RequestState.done;
      },
    );
    notifyListeners();
  }

  updateUserFromProfileData({
    required String email,
    required String name,
    required BuildContext context,
  }) async {
    print('loginRequest');
    stateOfUpdateProfile = RequestState.loading;
    notifyListeners();

    final failureOrDoneMessage = await updateUserDataUseCases(
        email: email, name: name, image: selectedImage);
    _eitherLoadedOrErrorUpdateState(failureOrDoneMessage);
    print('stateOfHome:$stateOfHome');
    if (stateOfUpdateProfile == RequestState.error) {
      Fluttertoast.showToast(
          msg: message ?? '',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColor.mainColor,
          textColor: Colors.white,
          fontSize: 16.0.sp);
    } else if (stateOfUpdateProfile == RequestState.done) {
      Navigator.of(context).pop();
    }
  }
}

String _mapFailureToMessage(Failure failure) {
  switch (failure) {
    case ServerFailure _:
      return failure.message;
    case LoginFailure:
      return Login_FAILURE_MESSAGE;
    case CacheFailure:
      return CACHE_FAILURE_MESSAGE;
    case ReLoginFailure:
      return RELOGIN_FAILURE_MESSAGE;
    default:
      return 'Unexpected error';
  }
}
