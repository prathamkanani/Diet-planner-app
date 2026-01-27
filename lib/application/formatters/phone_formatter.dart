import 'package:flutter/services.dart';

/// Input formatter for Indian phone numbers.
class PhoneInputFormatter extends TextInputFormatter {
  static const int maxDigits = 10; // Indian mobile numbers

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    // Extract digits only
    String digits = newValue.text.replaceAll(RegExp(r'\D'), '');

    // Remove leading 91 if user types it
    if (digits.startsWith('91')) {
      digits = digits.substring(2);
    }

    // Limit to 10 digits
    if (digits.length > maxDigits) {
      digits = digits.substring(0, maxDigits);
    }

    final buffer = StringBuffer('+91');

    if (digits.isNotEmpty) {
      buffer.write(' ');
      buffer.write(digits.substring(0, digits.length.clamp(0, 5)));
    }

    if (digits.length > 5) {
      buffer.write(' ');
      buffer.write(digits.substring(5));
    }

    final formatted = buffer.toString();

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(
        offset: formatted.length,
      ),
    );
  }
}
