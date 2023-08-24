import '../generator/keypad_indexed_generator.dart';
import '../generator/phone_keypad_generator.dart';

/// A raw KeyEvent, retaining a keyboard key.
class KeyValue {
  final String value;

  /// Returns true if the value is a digit (0-9).
  bool get isDigit => int.tryParse(value) != null;

  /// Returns true if the value is a symbol (* or #).
  bool get isSymbol => value == '*' || value == '#';

  const KeyValue(this.value) : assert(value.length <= 1, 'value must be a single character or empty');

  @override
  String toString() => "KeyValue('$value')";
}

class DigitKey extends KeyValue {
  DigitKey(int value) : super(value.toString());

  /// Returns a [DigitKey] for a given index using the provided [KeypadIndexedGenerator].
  factory DigitKey.index(int index, {KeypadIndexedGenerator generator = const PhoneKeypadGenerator()}) {
    final key = generator.get(index);

    // we will only know what type of key we have at runtime, so we need to assert that it is a DigitKey
    assert(
        key is DigitKey,
        'generator must return a DigitKey, is your generator configured correctly or check the index value?'
        'index: $index, generator key: $key');

    return key as DigitKey;
  }

  factory DigitKey.value(String value) {
    assert(value.length == 1, 'value must be a single character');
    assert(int.tryParse(value) != null, 'value must be a valid numeric character');
    assert(int.parse(value) >= 0 && int.parse(value) <= 9, 'value must conform to the constraints 0 <= value <= 9');
    return DigitKey(int.parse(value));
  }
}

enum DialActionKey { backspace, asterisk, hash, plus, enter }

class ActionKey extends KeyValue {

  final DialActionKey action;

  const ActionKey(this.action, super.value);

  const ActionKey.enter() : this(DialActionKey.enter, '');

  const ActionKey.backspace() : this(DialActionKey.backspace, '');

  const ActionKey.hash() : this(DialActionKey.hash, '#');

  const ActionKey.plus() : this(DialActionKey.plus, '+');

  const ActionKey.asterisk() : this(DialActionKey.asterisk, '*');

  @override
  String toString() => "ActionKey('$value')";
}
