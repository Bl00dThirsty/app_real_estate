import 'package:flutter/material.dart';

class MyCinetPayWebAppInterface {
  final BuildContext context;

  MyCinetPayWebAppInterface(this.context);

  void onResponse(String response) {
    print("MyCinetPayWebApp Response: $response");
  }

  void onError(String response) {
    print("MyCinetPayWebApp Error: $response");
  }
}
