import 'package:flutter/widgets.dart';

import 'odometer.dart';
import 'odometer_number.dart';

/// The signature for builders used to generate custom transitions for
/// the [OdometerNumber].
///
/// The function should return a widget that wraps the given `value`. It may
/// also use the `place` and the `animation` to inform its transition.
typedef OdometerAnimationTransitionBuilder = Widget Function(
  int value,
  int place,
  double animation,
);

/// The animated [OdometerNumber] automatically transitions from one number to another
/// over a given duration whenever the given [odometerNumber] changes.
class AnimatedOdometer extends ImplicitlyAnimatedWidget {
  const AnimatedOdometer({
    Key? key,
    required this.odometerNumber,
    required this.transitionIn,
    required this.transitionOut,
    Curve curve = Curves.linear,
    required Duration duration,
    VoidCallback? onEnd,
  }) : super(key: key, curve: curve, duration: duration, onEnd: onEnd);

  final OdometerNumber odometerNumber;

  /// The function returns a widget for each digit of the odometer number.
  /// For example, when changing the number from 6 to 7,
  /// this function will be used on the number 6.
  final OdometerAnimationTransitionBuilder transitionOut;

  /// The function returns a widget for each digit of the odometer number.
  /// For example, when changing the number from 6 to 7,
  /// this function will be used on the number 7.
  final OdometerAnimationTransitionBuilder transitionIn;

  @override
  _AnimatedOdometerState createState() => _AnimatedOdometerState();
}

class _AnimatedOdometerState extends AnimatedWidgetBaseState<AnimatedOdometer> {
  OdometerTween? _odometerTween;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _odometerTween = visitor(
      _odometerTween,
      widget.odometerNumber,
      (dynamic value) => OdometerTween(begin: value as OdometerNumber),
    ) as OdometerTween?;
  }

  @override
  Widget build(BuildContext context) {
    return Odometer(
      transitionOut: widget.transitionOut,
      transitionIn: widget.transitionIn,
      odometerNumber: _odometerTween!.evaluate(animation),
    );
  }
}

/// The explicitly animated widget that transitions the [OdometerNumber] by
/// the given [odometerAnimation].
class OdometerTransition extends AnimatedWidget {
  /// Creates the [OdometerTransition] that transitions the [OdometerNumber] by
  /// the given [odometerAnimation].
  const OdometerTransition({
    Key? key,
    required this.transitionIn,
    required this.transitionOut,
    required Animation<OdometerNumber> odometerAnimation,
  }) : super(key: key, listenable: odometerAnimation);

  /// The function returns a widget for each digit of the odometer number.
  /// For example, when changing the number from 6 to 7,
  /// this function will be used on the number 6.
  final OdometerAnimationTransitionBuilder transitionOut;

  /// The function returns a widget for each digit of the odometer number.
  /// For example, when changing the number from 6 to 7,
  /// this function will be used on the number 7.
  final OdometerAnimationTransitionBuilder transitionIn;

  /// The animation for the [OdometerNumber].
  Animation<OdometerNumber> get odometerAnimation =>
      listenable as Animation<OdometerNumber>;

  @override
  Widget build(BuildContext context) {
    return Odometer(
      transitionOut: transitionOut,
      transitionIn: transitionIn,
      odometerNumber: odometerAnimation.value,
    );
  }
}
