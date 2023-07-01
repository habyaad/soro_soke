import 'package:flutter_test/flutter_test.dart';
import 'package:soro_soke/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('DatabaseServiceTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
