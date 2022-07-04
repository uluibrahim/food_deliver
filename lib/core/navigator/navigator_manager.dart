import 'package:flutter/material.dart';

mixin NavigatorManager {
  void navigateToWidget(BuildContext context, Widget widget) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget));
  }

  Future<T?> navigateToWidgetWithValue<T>(
      BuildContext context, Widget widget) async {
    return await Navigator.of(context)
        .push<T>(MaterialPageRoute(builder: (context) => widget));
  }

  void navigateReplaceToWidget(BuildContext context, Widget widget) {
    Route route = MaterialPageRoute(builder: (context) => widget);
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }
}
