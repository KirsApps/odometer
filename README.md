[![Build Status](https://github.com/KirsApps/odometer/workflows/build/badge.svg)](https://github.com/KirsApps/odometer/actions?query=workflow%3A"build"+branch%3Amaster)
[![pub](https://img.shields.io/pub/v/odometer.svg)](https://pub.dev/packages/odometer)
[![style: lint](https://img.shields.io/badge/style-lint-4BC0F5.svg)](https://pub.dev/packages/lint)

# Odometer

Package which was inspired by the package [Odometer js](https://github.hubspot.com/odometer/).

Examples of counter animation customization made using this package:

![Gif](https://github.com/KirsApps/odometer/blob/master/assets/1.gif "Fancy Gif")

![Gif](https://github.com/KirsApps/odometer/blob/master/assets/2.gif "Fancy Gif")

![Gif](https://github.com/KirsApps/odometer/blob/master/assets/3.gif "Fancy Gif")

In this package you will find **pre-built** widgets:
* AnimatedSlideOdometerNumber
* SlideOdometerTransition

and **high modifiable** widgets:
* AnimatedOdometer
* OdometerTransition

## AnimatedSlideOdometerNumber

ImplicitlyAnimatedWidget based on AnimatedOdometer
with a slide and fade digits transition.
```dart 
   AnimatedSlideOdometerNumber(
     numberTextStyle: TextStyle(fontSize: 15),
     odometerNumber: OdometerNumber(_counter),
     duration: Duration(seconds: 1))
```

## SlideOdometerTransition

ExplicitlyAnimatedWidget based on OdometerTransition
with a slide and fade digits transition
```dart 
    SlideOdometerTransition(
      numberTextStyle: TextStyle(fontSize: 15),
      odometerAnimation: _odometerAnimation,
      duration: Duration(seconds: 1))
```

## Base widgets AnimatedOdometer and OdometerTransition

AnimatedOdometer based on Implicit Animations and OdometerTransition based on explicit animation.
to customize the odometer, you need to use two OdometerAnimationTransitionBuilders
for new and old numbers you will have access to:
* digit
* digit place
* animation progress of this digit


