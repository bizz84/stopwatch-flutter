import 'dart:async';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

// Run this test using:
//
// flutter drive --profile test_driver/perf.dart
void main() {
  group('performance', () {
    FlutterDriver driver;

    setUp(() async {
      driver = await FlutterDriver.connect();
    });

    tearDown(() async {
      await driver.close();
    });

    test('timer performs well', () async {
      await new Future.delayed(const Duration(seconds: 2));
      await driver.tap(find.text('start'));
      final Timeline timeline = await driver.traceAction(() async {
        await new Future.delayed(const Duration(seconds: 5));
      });
      await driver.tap(find.text('stop'));
      final TimelineSummary summary = new TimelineSummary.summarize(timeline);

      // Average amount of time it takes the framework to build a frame (mostly Dart framework code).
      print('Avg. build: ${summary.computeAverageFrameBuildTimeMillis()} milliseconds');

      // Average amount of time it take to make pixels (mostly C++ engine code).
      print('Avg. rasterize: ${summary.computeAverageFrameRasterizerTimeMillis()} milliseconds');
    });
  });
}
