import '../models/key_value.dart';

/// A generator that returns a [KeyValue] for a given index. Extensibility allows keypads of different formats, layouts, etc.
abstract class KeypadIndexedGenerator {
  const KeypadIndexedGenerator();

  /// Returns a [KeyValue] for a given index.
  KeyValue get(int index);

  /// Returns a [KeyValue] for a given index's alternate selection (i.e. long press).
  KeyValue? getAlt(int index);

  /// Returns a hint for a given index.
  String? hint(int index) => null;
}
