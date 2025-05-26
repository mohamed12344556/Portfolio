// Place fonts/MyIcons.ttf in your fonts/ directory and
// add the following to your pubspec.yaml
// flutter:
//   fonts:
//    - family: MyIcons
//      fonts:
//       - asset: fonts/MyIcons.ttf
import 'package:flutter/widgets.dart';

class MyIcons {
  MyIcons._();

  static const String _fontFamily = 'MyIcons';

  static const IconData whatsApp = IconData(0xe900, fontFamily: _fontFamily);
  static const IconData outlook = IconData(0xe901, fontFamily: _fontFamily);
  static const IconData mail = IconData(0xe902, fontFamily: _fontFamily);
  static const IconData linkedIN = IconData(0xe903, fontFamily: _fontFamily);
}
