import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_user/flutter_user.dart';

class ExampleRegistrationRepository with RegistrationRepository {
  @override
  Future<String?> register(HashMap values) {
    debugPrint('register: $values');
    return Future.value(null);
  }
}
