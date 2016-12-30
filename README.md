# Relativity

[![CI Status](https://travis-ci.org/dfed/Relativity.svg?branch=master)](https://travis-ci.org/dfed/Relativity)
[![Carthage Compatibility](https://img.shields.io/badge/carthage-✓-e2c245.svg)](https://github.com/Carthage/Carthage/)
[![Version](https://img.shields.io/cocoapods/v/Relativity.svg)](http://cocoadocs.org/docsets/Relativity)
[![License](https://img.shields.io/cocoapods/l/Relativity.svg)](http://cocoadocs.org/docsets/Relativity)
[![Platform](https://img.shields.io/cocoapods/p/Relativity.svg)](http://cocoadocs.org/docsets/Relativity)

A DSL for laying out views without Auto Layout in Swift.

## Installation

### CocoaPods

To install Relativity in your iOS project with [CocoaPods](http://cocoapods.org), add the following to your `Podfile`:

```
platform :ios, '8.0'
pod 'Relativity', '~> 0.8.0'
```

### Carthage

To install Relativity in your iOS project with [Carthage](https://github.com/Carthage/Carthage), add the following to your `Cartfile`:

```ogdl
github "dfed/Relativity"
```

Run `carthage` to build the framework and drag the built `Relativity.framework` into your Xcode project.

### Swift Package Manager

To install Relativity in your iOS project with [Swift Package Manager](https://github.com/apple/swift-package-manager), the following definition can be added to the dependencies of your `Project`:

```swift
  .Package(url: "https://github.com/dfed/Relativity.git", majorVersion: 0, minor: 8),
```

### Submodules

To use git submodules, checkout the submodule with `git submodule add git@github.com:dfed/Relativity.git`, drag Relativity.xcodeproj to your project, and add Relativity as a build dependency.

## Usage

### Positioning UIViews

To align view `a` to be 10 points to the left of view `b`:

```swift
  a.rightCenter --> 10.horizontalOffset + b.leftCenter
```

To align view `a` to be 10 points to the right of view `b`:

```swift
  b.rightCenter + 10.horizontalOffset <-- a.leftCenter
```

To align view `a` to be 10 points below its superview’s top center:

```swift
  a.topCenter --> 10.verticalOffset + .topCenter
```

For more examples, check out the [ViewPositionVisualization](RelativityVisualization.playground/Pages/ViewPositionVisualization.xcplaygroundpage/Contents.swift) playground page.

#### Positioning UILabels

Relativity makes it easy to position your `UILabel`s to your designer’s spec. Design teams (and design products like [Sketch](https://www.sketchapp.com) and [Zeplin](https://zeplin.io)) measure the vertical distance to a label using the font’s [cap height](https://en.wikipedia.org/wiki/Cap_height) and [baseline](https://en.wikipedia.org/wiki/Baseline_(typography)). Relativity’s `align` methods measure `UILabel` distances the same way. So if your spec says that label `b` should be eight vertical points below label `a`, all you need is:

```swift
  a.bottomCenter --> 8.verticalOffset + b.topCenter
```

For a visual example, check out the [FontMetricsVisualization](RelativityVisualization.playground/Pages/FontMetricsVisualization.xcplaygroundpage/Contents.swift) playground page.

### Distributing subviews

Since view controllers need to be laid out flexibly over various iOS device sizes, Relativity has the ability to easily distribute subviews with relative positioning along an axis.

To equally distribute subviews `a`, `b`, and `c` at equal distances along a horizontal axis:

```swift
  superview.distributeSubviewsHorizontally() {
    a <|> .relative(1) <|> b <|> .relative(1) <|> c
  }
```

To make the space between `a` and `b` twice as large as the space between `b` and `c`:

```swift
  superview.distributeSubviewsHorizontally() {
    a <|> .relative(2) <|> b <|> .relative(1) <|> c
  }
```

To pin `a` to be 8pts from the left side, and distribute `b` and `c` with equal spacing over the remaining space:

```swift
  superview.distributeSubviewsHorizontally() {
    .fixed(8) <|> a <|> .relative(1) <|> b <|> .relative(1) <|> c
  }
```

To equally distribute subviews `a`, `b`, and `c` at equal distances along a vertical axis, but align the subviews within the left half of `superview`:

```swift
  superview.distributeSubviewsVertically(within: CGRect(x: 0.0, y: 0.0, width: superview.frame.width / 2.0, height: superview.frame.height)) {
    a <|> .relative(1) <|> b <|> .relative(1) <|> c
  }
```

For a visual example, check out the [ViewPositionVisualization](RelativityVisualization.playground/Pages/ViewPositionVisualization.xcplaygroundpage/Contents.swift) playground page.

### Pixel Rounding

Relativity ensures that you never align a frame to a non-integral pixel, so no need to worry about blurry UI! I’ve also vended a public [PixelRounder](Sources/PixelRounder.h) for those who want to use it for frame sizing.

## Requirements

* Xcode 8.0 or later.
* iOS 8 or later.
* Swift 3.0 or later.

## Contributing

I’m glad you’re interested in Relativity, and I’d love to see where you take it. Please read the [contributing guidelines](Contributing.md) prior to submitting a Pull Request.

Thanks, and happy positioning!

## Attribution

Shout out to [Peter Westen](https://twitter.com/pwesten) who inspired the creation of this library.
