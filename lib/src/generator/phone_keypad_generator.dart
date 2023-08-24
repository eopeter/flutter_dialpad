import '../models/key_value.dart';
import 'keypad_indexed_generator.dart';

/// Phone keypad generator for a standard mobile phone keypad, including the digits 0-9, asterisk, and hash in a logical grid format from indexed values (0-11):
/// ```
/// 1 2 3
/// 4 5 6
/// 7 8 9
/// * 0 #
/// ```
///
/// For index values 0-8, 10, the [DigitKey] value is returned. For index values 9 and 11, the [ActionKey] value is returned.
class PhoneKeypadGenerator extends KeypadIndexedGenerator {
  const PhoneKeypadGenerator();

  @override
  KeyValue get(int index) {
    switch (index) {
      case 9:
        return ActionKey.asterisk();
      case 10:
        return DigitKey.value('0');
      case 11:
        return ActionKey.hash();
      default:
        return DigitKey(index + 1);
    }
  }

  @override
  KeyValue? getAlt(int index) {
    switch (index) {
      case 9:
        return ActionKey.plus();
      default:
        return null;
    }
  }

  /// Returns a hint for a given index.
  /// ```
  /// null  ABC   DEF
  /// GHI   JKL   MNO
  /// PQRS  TUV   WXYZ
  /// +     null  null
  /// ```
  ///
  @override
  String? hint(int index) {
    switch (index) {
      case 1:
        return 'ABC';
      case 2:
        return 'DEF';
      case 3:
        return 'GHI';
      case 4:
        return 'JKL';
      case 5:
        return 'MNO';
      case 6:
        return 'PQRS';
      case 7:
        return 'TUV';
      case 8:
        return 'WXYZ';
      case 9:
        return '+';
      default:
        return null;
    }
  }
}
