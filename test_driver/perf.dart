import 'package:flutter_driver/driver_extension.dart';
import 'package:stopwatch/main.dart' as app;

void main() {
  // The Flutter Driver extension adds just enough instrumentation
  // for the test script to interact with the app.
  enableFlutterDriverExtension();
  app.main();
}
