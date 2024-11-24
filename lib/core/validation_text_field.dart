abstract class ValidationTextField {
  static emailInput(String? value) {
    if (value == null || value.isEmpty) {
      return;
    } else if (RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(value))
      return null;
    else
      return 'Not Valid Email';
  }

  static textInput(String? value) {
    if (value == null || value.isEmpty) {
      return "الاسم مطلوب";
    } else {
      return;
    }
  }

  static phoneNumberInput(String? value) {
    if (value == null || value.isEmpty) {
      return "رقم الهاتف مطلوب";
    } else {
      try {
        double.parse(value);
        return;
      } catch (e) {
        return "رقم الهاتف غير صحيح";
      }
    }
  }
}
