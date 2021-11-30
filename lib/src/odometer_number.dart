import 'dart:math';
import 'dart:ui';

import 'package:flutter/widgets.dart';

/// The odometer number that is used in widgets [AnimatedOdometer] and [OdometerTransition].
class OdometerNumber {
  final int number;
  final Map<int, double> digits;

  /// Creates the [OdometerNumber] that uses the given [number].
  OdometerNumber(this.number) : digits = generateDigits(number);

  /// Creates the [OdometerNumber] that uses the given [digits].
  OdometerNumber.fromDigits(this.digits) : number = digits[1]!.toInt();

  /// Returns digits generated from the given [number].
  static Map<int, double> generateDigits(int number) {
    final digits = <int, double>{};
    if (number <= 0) return {1: 0};
    var v = number;
    var place = 1;
    while (v > 0) {
      digits[place] = v.toDouble();
      v = v ~/ 10;
      place++;
    }
    return digits;
  }

  /// Returns truncated value represents the current odometer digit.
  static int digit(double value) => (value % 10).truncate();

  /// Returns the animation progress creates from the [value].
  static double progress(double value) => value - value.truncate();

  /// Linearly interpolates between two numbers.
  // ignore: prefer_constructors_over_static_methods
  static OdometerNumber lerp(
    OdometerNumber start,
    OdometerNumber end,
    double t,
  ) {
    final keyLength = max(start.digits.length, end.digits.length);
    final digits = <int, double>{};
    for (var i = 1; i <= keyLength; i++) {
      digits[i] = lerpDouble(start.digits[i], end.digits[i], t)!;
    }
    return OdometerNumber.fromDigits(digits);
  }

  @override
  String toString() {
    return 'OdometerNumber $number';
  }
}

/// The interpolation between two OdometerNumbers.
///
/// This class specializes in the interpolation of [Tween<OdometerNumber>] to use
/// the [OdometerNumber.lerp].
class OdometerTween extends Tween<OdometerNumber> {
  /// The [OdometerTween] constructor.
  ///
  /// The [begin] and [end] properties must be non-null before the tween is
  /// first used, but the arguments can be null if the values are going to be
  /// filled in later.
  OdometerTween({OdometerNumber? begin, OdometerNumber? end})
      : super(begin: begin, end: end);

  /// Returns the value this variable has at the given animation clock value.
  @override
  OdometerNumber lerp(double t) => OdometerNumber.lerp(begin!, end!, t);
}
