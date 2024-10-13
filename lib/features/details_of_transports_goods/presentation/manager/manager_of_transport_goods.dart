import 'package:fisaa/core/assets_images.dart';
import 'package:flutter/material.dart';
import 'package:quiver/strings.dart';

import '../../domain/entities/type_of_good_model.dart';
import '../pages/first_step_details.dart';
import '../pages/second_step_details.dart';
import '../pages/third_step_details.dart';

class ManagerOfTransportGoods extends ChangeNotifier {
  final String endPointAddress;
  int indexOfStep = 0;
  List<Widget> widgetsOfSteps = [
    FirstStepDetails(),
    SecondStepDetails(),
    ThirdStepDetails(),
    SizedBox()
  ];
  bool stateOfNextButton = false;

  ManagerOfTransportGoods({required this.endPointAddress});
  void updateIndexOfStep() {
    indexOfStep++;
    stateOfNextButton = false;
    notifyListeners();
  }

  void updateIndexOfStepToDownGrade() {
    indexOfStep--;
    stateOfNextButton = true;
    notifyListeners();
  }

  checkStateOfNextButton() {
    if (indexOfStep == 0) {
      if (selectTypeOfGood != 0 && selectWeightOfGood != 0) {
        stateOfNextButton = true;
        notifyListeners();
        return;
      }
    } else if (indexOfStep == 1) {
      if (payWhenReceive == true &&
          isBlank(textFieldNameOfReceiver) == false &&
          isBlank(textFieldPhoneOfReceiver) == false) {
        stateOfNextButton = true;
        notifyListeners();
        return;
      }
    } else if (indexOfStep == 2) {
      if (needWorkers != null) {
        stateOfNextButton = true;
        notifyListeners();
        return;
      }
    }

    stateOfNextButton = false;
    notifyListeners();
  }

  int selectTypeOfGood = 0;
  int selectWeightOfGood = 0;
  updateSelectTypeOfGood({required int typeOfGood}) {
    selectTypeOfGood = typeOfGood;
    notifyListeners();
    checkStateOfNextButton();
  }

  updateSelectWeightOfGood({required int typeOfGood}) {
    selectWeightOfGood = typeOfGood;
    notifyListeners();
    checkStateOfNextButton();
  }

  List<TypeOfGoodModel> listOfTypesOfGoods = [
    TypeOfGoodModel(goodKey: 1, title: 'مواد بناء', image: AppImages.good1),
    TypeOfGoodModel(goodKey: 2, title: 'أثاث / فرش', image: AppImages.good2),
    TypeOfGoodModel(goodKey: 3, title: 'طعام', image: AppImages.good3),
    TypeOfGoodModel(goodKey: 4, title: 'مواد كهربائية', image: AppImages.good4),
    TypeOfGoodModel(goodKey: 5, title: 'اخرى'),
  ];
  List<TypeOfGoodModel> listOfWeightOfGoods = [
    TypeOfGoodModel(
      goodKey: 1,
      title: '+100 ك.ج',
    ),
    TypeOfGoodModel(goodKey: 2, title: '+200 ك.ج'),
    TypeOfGoodModel(goodKey: 3, title: '+300 ك.ج'),
    TypeOfGoodModel(goodKey: 4, title: '+400 ك.ج'),
    TypeOfGoodModel(goodKey: 5, title: '+500 ك.ج'),
    TypeOfGoodModel(goodKey: 6, title: '+600 ك.ج'),
    TypeOfGoodModel(goodKey: 7, title: '+700 ك.ج'),
  ];

  String? textFieldNameOfReceiver;
  String? textFieldPhoneOfReceiver;
  bool payWhenReceive = false;

  updateNameOfReceiver({required String? newText}) {
    textFieldNameOfReceiver = newText;
    notifyListeners();
    checkStateOfNextButton();
  }

  updatePhoneOfReceiver({required String? newText}) {
    textFieldPhoneOfReceiver = newText;
    notifyListeners();
    checkStateOfNextButton();
  }

  updatePayWhenReceive() {
    payWhenReceive = !payWhenReceive;
    notifyListeners();
    checkStateOfNextButton();
  }

  int? needWorkers;
  updateNeedWorkers({required int newData}) {
    needWorkers = newData;
    notifyListeners();
    checkStateOfNextButton();
  }
}
