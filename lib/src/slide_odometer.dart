import 'package:flutter/widgets.dart';

import 'odometer_animation.dart';
import 'odometer_number.dart';

///[ImplicitlyAnimatedWidget] based on [AnimatedOdometer]
///with slide and fade digits transition
class AnimatedSlideOdometerNumber extends StatelessWidget {
  final OdometerNumber odometerNumber;
  final Duration duration;

  ///The width of the SizedBox widget around each digit
  ///to avoid the movement of the digits when they change
  final double letterWidth;

  /// A widget that is used to separate digit groups.
  final Widget groupSeparator;

  /// TextStyle for digits
  final TextStyle numberTextStyle;

  /// Vertical offset what is used to translate digits
  final double verticalOffset;

  /// The curve to apply when animating the odometer number.
  final Curve curve;

  AnimatedSlideOdometerNumber(
      {Key key,
      @required this.odometerNumber,
      @required this.duration,
      this.numberTextStyle,
      this.curve = Curves.linear,
      @required this.letterWidth,
      this.verticalOffset = 20,
      this.groupSeparator})
      : assert(odometerNumber != null),
        assert(duration != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOdometer(
        curve: curve,
        odometerNumber: odometerNumber,
        transitionIn: (value, place, animation) => _buildSlideOdometerDigit(
            value,
            place,
            animation,
            verticalOffset * animation - verticalOffset,
            groupSeparator,
            numberTextStyle,
            letterWidth),
        transitionOut: (value, place, animation) => _buildSlideOdometerDigit(
            value,
            place,
            1 - animation,
            verticalOffset * animation,
            groupSeparator,
            numberTextStyle,
            letterWidth),
        duration: duration);
  }
}

///ExplicitlyAnimatedWidget based on [OdometerTransition]
///with slide and fade digits transition
class AnimatedSlideOdometerTransition extends StatelessWidget {
  final Animation<OdometerNumber> odometerAnimation;

  ///The width of the SizedBox widget around each digit
  ///to avoid the movement of the digits when they change
  final double letterWidth;

  /// A widget that is used to separate digit groups.
  final Widget groupSeparator;

  /// TextStyle for digits
  final TextStyle numberTextStyle;

  /// Vertical offset what is used to translate digits
  final double verticalOffset;

  AnimatedSlideOdometerTransition(
      {Key key,
      @required this.odometerAnimation,
      this.numberTextStyle,
      @required this.letterWidth,
      this.verticalOffset = 20,
      this.groupSeparator})
      : assert(odometerAnimation != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return OdometerTransition(
      odometerAnimation: odometerAnimation,
      transitionIn: (value, place, animation) => _buildSlideOdometerDigit(
          value,
          place,
          animation,
          verticalOffset * animation - verticalOffset,
          groupSeparator,
          numberTextStyle,
          letterWidth),
      transitionOut: (value, place, animation) => _buildSlideOdometerDigit(
          value,
          place,
          1 - animation,
          verticalOffset * animation,
          groupSeparator,
          numberTextStyle,
          letterWidth),
    );
  }
}

Widget _buildSlideOdometerDigit(
    int value,
    int place,
    double opacity,
    double offsetY,
    Widget thousandSeparator,
    TextStyle numberTextStyle,
    double letterWidth) {
  if (thousandSeparator != null && place % 3 == 0) {
    return Row(
      children: [
        thousandSeparator,
        _valueText(value, opacity, offsetY, numberTextStyle, letterWidth)
      ],
    );
  } else {
    return _valueText(value, opacity, offsetY, numberTextStyle, letterWidth);
  }
}

Widget _valueText(int value, double opacity, double offsetY,
        TextStyle numberTextStyle, double letterWidth) =>
    Transform.translate(
        offset: Offset(0, offsetY),
        child: Opacity(
          opacity: opacity,
          child: SizedBox(
            width: letterWidth,
            child: Text(
              value.toString(),
              style: numberTextStyle,
            ),
          ),
        ));
