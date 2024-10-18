enum StateOfRide { searching, way, arrived, completed, cancel }

extension TypeExtensionOfStateOfRide on StateOfRide {
  static Map _mapOfSelectedHelp() {
    return {
      'searching': StateOfRide.searching,
      'way': StateOfRide.way,
      'arrived': StateOfRide.arrived,
      'completed': StateOfRide.completed,
      'cancel': StateOfRide.cancel
    };
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
}
