import 'package:flutter/foundation.dart' show kDebugMode;

extension IfDebugging on String {
  String? get ifDebugging => kDebugMode ? this : null;
}

void testIt() {
  'gokturk.acr2002@gmail.com'.ifDebugging;
}
