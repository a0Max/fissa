import 'package:flutter/cupertino.dart';

import '../../features/trip_history/presentation/widgets/cancel_widget.dart';
import '../../features/trip_history/presentation/widgets/default_widget.dart';
import '../../features/trip_history/presentation/widgets/done_widget.dart';

enum StateOfRide { searching, way, arrived, completed, cancel }

extension TypeExtensionOfStateOfRide on StateOfRide {
  static Map _mapOfSelectedHelp() {
    return {
      StateOfRide.searching.text(): StateOfRide.searching,
      StateOfRide.way.text(): StateOfRide.way,
      StateOfRide.arrived.text(): StateOfRide.arrived,
      StateOfRide.completed.text(): StateOfRide.completed,
      StateOfRide.cancel.text(): StateOfRide.cancel
    };
  }

  String text() {
    switch (this) {
      case StateOfRide.searching:
        return 'searching';
      case StateOfRide.way:
        return 'way';
      case StateOfRide.arrived:
        return 'arrived';
      case StateOfRide.completed:
        return 'completed';
      case StateOfRide.cancel:
        return 'cancel';
    }
  }

  static Map _mapOfStepSelectedHelp() {
    return {
      StateOfRide.searching: 1,
      StateOfRide.way: 2,
      StateOfRide.arrived: 3,
      StateOfRide.completed: 4,
      StateOfRide.cancel: 5
    };
  }

  static StateOfRide getState({required String textDataBase}) {
    return _mapOfSelectedHelp()[textDataBase];
  }

  static int getStepOfState({required String textDataBase}) {
    return _mapOfStepSelectedHelp()[_mapOfSelectedHelp()[textDataBase]];
  }

  static Widget widgetUi({required String type}) {
    if (type == StateOfRide.searching.text()) {
      return DefaultWidget(
        state: StateOfRide.searching.text(),
      );
    } else if (type == StateOfRide.way.text()) {
      return DefaultWidget(
        state: StateOfRide.way.text(),
      );
    } else if (type == StateOfRide.arrived.text()) {
      return DefaultWidget(
        state: StateOfRide.arrived.text(),
      );
    } else if (type == StateOfRide.completed.text()) {
      return DoneWidget();
    } else if (type == StateOfRide.cancel.text()) {
      return CancelWidget();
    }
    return DefaultWidget(
      state: type,
    );
  }
}
