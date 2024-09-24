abstract class ValidationTextField {
  static emailInput(String? value) {
    if (value == null || value.isEmpty) {
      return "Please Enter Email";
    } else if (RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(value))
      return null;
    else
      return 'Not Valid Email';
  }

  static phoneNumberInput(String? value) {
    if (value == null || value.isEmpty) {
      return "Please Enter PhoneNumber";
    } else {
      try {
        double.parse(value);
        return;
      } catch (e) {
        return "Please Enter valid PhoneNumber";
      }
    }
  }

  static textInput(String? value, {int? length}) {
    if ((value?.length ?? 0) < (length ?? 3)) {
      return 'length must be more than ${length ?? 3} letters';
    } else {
      return null;
    }
  }

  static textOnlyInput(String? value, {int? minLength, int? maxLength}) {
    // Check the length constraints
    if ((value?.length ?? 0) < (minLength ?? 3)) {
      return 'length must be more than ${minLength ?? 3} letters';
    }
    if ((value?.length ?? 0) > (maxLength ?? 20)) {
      return 'length must be less than ${maxLength ?? 20} letters';
    }

    // Check if the string contains only letters and spaces
    if (value != null && RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return null;
    } else {
      return 'this field accepts letters and spaces only';
    }
  }
}
