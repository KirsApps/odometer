import 'package:flutter/widgets.dart';

import 'odometer.dart';
import 'odometer_number.dart';

/// Signature for builders used to generate custom transitions for
/// [OdometerNumber].
///
/// The function should return a widget which wraps the given `value`. It may
/// also use the `place` and `animation` to inform its transition. It must not return null.
typedef OdometerAnimationTransitionBuilder = Widget Function(
    int value, int place, double animation);

/// Animated [OdometerNumber] which automatically transitions from one number to another
/// over a given duration whenever the given [odometerNumber] changes.
class AnimatedOdometer extends ImplicitlyAnimatedWidget {
  AnimatedOdometer({
    Key? key,
    required this.odometerNumber,
    required this.transitionIn,
    required this.transitionOut,
    Curve curve = Curves.linear,
    required Duration duration,
    VoidCallback? onEnd,
  }) : super(key: key, curve: curve, duration: duration, onEnd: onEnd);

  final OdometerNumber odometerNumber;

  /// А function that returns a widget for each digit of the odometer number.
  /// For example, when changing the number from 6 to 7,
  /// this function will be used on the number 6
  final OdometerAnimationTransitionBuilder transitionOut;

  /// А function that returns a widget for each digit of the odometer number.
  /// For example, when changing the number from 6 to 7,
  /// this function will be used on the number 7
  final OdometerAnimationTransitionBuilder transitionIn;

  @override
  _AnimatedOdometerState createState() => _AnimatedOdometerState();
}

class _AnimatedOdometerState extends AnimatedWidgetBaseState<AnimatedOdometer> {
  OdometerTween? _odometerTween;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _odometerTween = visitor(_odometerTween, widget.odometerNumber,
            (dynamic value) => OdometerTween(begin: value as OdometerNumber))
        as OdometerTween?;
  }

  @override
  Widget build(BuildContext context) {
    return Odometer(
        transitionOut: widget.transitionOut,
        transitionIn: widget.transitionIn,
        odometerNumber: _odometerTween!.evaluate(animation));
  }
}

/// Animates the [OdometerNumber]

class OdometerTransition extends AnimatedWidget {
  /// Creates a odometer number transition.

  const OdometerTransition({
    Key? key,
    required this.transitionIn,
    required this.transitionOut,
    required Animation<OdometerNumber> odometerAnimation,
  }) : super(key: key, listenable: odometerAnimation);

  /// А function that returns a widget for each digit of the odometer number.
  /// For example, when changing the number from 6 to 7,
  /// this function will be used on the number 6
  final OdometerAnimationTransitionBuilder transitionOut;

  /// А function that returns a widget for each digit of the odometer number.
  /// For example, when changing the number from 6 to 7,
  /// this function will be used on the number 7
  final OdometerAnimationTransitionBuilder transitionIn;

  /// The animation that controls the [OdometerNumber].
  Animation<OdometerNumber> get odometerAnimation =>
      listenable as Animation<OdometerNumber>;

  @override
  Widget build(BuildContext context) {
    return Odometer(
        transitionOut: transitionOut,
        transitionIn: transitionIn,
        odometerNumber: odometerAnimation.value);
  }
}
