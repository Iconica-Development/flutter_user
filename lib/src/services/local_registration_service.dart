import "dart:collection";

import "package:flutter_registration/flutter_registration.dart";

/// Local Implementation of the RegistrationRepository
class LocalRegistrationService implements RegistrationRepository {
  @override
  Future<String?> register(HashMap values) => Future.value(null);
}
