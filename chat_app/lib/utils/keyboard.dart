import 'package:flutter/cupertino.dart';

class KeyboardUtils {
  static bool isKeyboardVisible() {
    return WidgetsBinding.instance.window.viewInsets.bottom > 0;
  }

  static closeKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}
