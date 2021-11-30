[![Build Status](https://github.com/KirsApps/odometer/workflows/build/badge.svg)](https://github.com/KirsApps/odometer/actions?query=workflow%3A"build"+branch%3Amaster)
[![pub](https://img.shields.io/pub/v/odometer.svg)](https://pub.dev/packages/odometer)
[![stars](https://img.shields.io/github/stars/KirsApps/odometer.svg?style=flat&logo=github&colorB=deeppink&label=stars)](https://github.com/KirsApps/odometer)
[![style: lint](https://img.shields.io/badge/style-lint-4BC0F5.svg)](https://pub.dev/packages/lint)

# Odometer

The package which was inspired by the package [Odometer js](https://github.hubspot.com/odometer/).

Examples of counter animation customization are made using this package:

<p align="left">
<img src="https://github.com/KirsApps/odometer/raw/master/assets/preview.gif" height="350" alt="Examples Gif" />
</p>

In this package you will find **pre-built** widgets:
* AnimatedSlideOdometerNumber
* SlideOdometerTransition

and **high modifiable** widgets:
* AnimatedOdometer
* OdometerTransition

## AnimatedSlideOdometerNumber

The ImplicitlyAnimatedWidget uses the AnimatedOdometer with the sliding and fading digits transitions.
```dart 
   AnimatedSlideOdometerNumber(
     numberTextStyle: TextStyle(fontSize: 15),
     odometerNumber: OdometerNumber(_counter),
     duration: Duration(seconds: 1))
```

## SlideOdometerTransition

The ExplicitlyAnimatedWidget uses the OdometerTransition with the sliding and fading digits transitions.

```dart 
    SlideOdometerTransition(
      numberTextStyle: TextStyle(fontSize: 15),
      odometerAnimation: _odometerAnimation,
      duration: Duration(seconds: 1))
```

## Base widgets AnimatedOdometer and OdometerTransition

The AnimatedOdometer is based on implicit animation, and the OdometerTransition is based on explicit animation.
To customize the odometer, you need to use two OdometerAnimationTransitionBuilders for new and old numbers. 
You will have access to:
* The digit
* The digit place
* The animation progress of this digit


