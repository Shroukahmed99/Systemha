class ValidationHelper {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (!RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)').hasMatch(value)) {
      return 'Password must contain upper, lower, and number';
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String? original) {
    if (value == null || value.isEmpty) {
      return 'Confirm password is required';
    }
    if (value != original) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }
    if (value.length < 3) {
      return 'Name must be at least 3 characters';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    final phoneRegex = RegExp(r'^(?:\+?20)?(1[0-9]{9})$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Enter a valid Egyptian phone number';
    }
    return null;
  }

  static String? validateNotEmpty(String? value, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName ?? "This field"} is required';
    }
    return null;
  }

  static String? validateNumber(String? value, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? "Number"} is required';
    }
    if (double.tryParse(value) == null) {
      return '${fieldName ?? "Value"} must be a valid number';
    }
    return null;
  }

 

  static String? validateNationalID(String? value) {
    if (value == null || value.isEmpty) {
      return 'National ID is required';
    }
    if (!RegExp(r'^\d{14}$').hasMatch(value)) {
      return 'National ID must be exactly 14 digits';
    }
    return null;
  }

}
