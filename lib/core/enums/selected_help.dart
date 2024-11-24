enum SelectedHelp { transportOfGoods, vehicleTowing }

extension TypeExtension on SelectedHelp {
  static Map mapOfSelectedHelp() {
    return {1: SelectedHelp.vehicleTowing, 2: SelectedHelp.transportOfGoods};
  }
}
