//
//  Operators.swift
//  Relativity
//
//  Created by Dan Federman on 12/26/16.
//  Copyright © 2016 Dan Federman.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import CoreGraphics
import Foundation
import UIKit


// MARK: – ViewPosition Operators


infix operator --> : AssignmentPrecedence
infix operator <-- : AssignmentPrecedence
infix operator |--| : AdditionPrecedence
infix operator <> : AdditionPrecedence
postfix operator ~

/// Aligns lhs to rhs.
/// - parameter lhs: The ViewPosition to align.
/// - parameter rhs: The position to which lhs is aligned.
public func -->(lhs: ViewPosition, rhs: ViewPosition) {
    lhs.align(to: rhs)
}

/// Aligns lhs to the rhs's position on the lhs's superview.
/// - parameter lhs: The ViewPosition to align.
/// - parameter rhs: The position on the lhs's superview to which lhs is aligned.
public func -->(lhs: ViewPosition, rhs: ViewPosition.Anchor) {
    lhs.align(toSuperviewAnchor: rhs)
}

/// Aligns lhs to the rhs's position on the lhs's superview.
/// - parameter lhs: The ViewPosition to align.
/// - parameter rhs: The position on the lhs's superview to which lhs is aligned.
public func -->(lhs: ViewPosition, rhs: ViewPosition.OffsetAnchor) {
    lhs.align(toSuperviewAnchor: rhs.anchor, xOffset: rhs.offset.horizontal, yOffset: rhs.offset.vertical)
}

/// Aligns rhs to lhs.
/// - parameter lhs: The position to which rhs is aligned.
/// - parameter rhs: The ViewPosition to align.
public func <--(lhs: ViewPosition, rhs: ViewPosition) {
    rhs --> lhs
}

/// Aligns rhs to the lhs's position on the rhs's superview.
/// - parameter lhs: The ViewPosition to align.
/// - parameter rhs: The position on the rhs's superview to which rhs is aligned.
public func <--(lhs: ViewPosition.Anchor, rhs: ViewPosition) {
    rhs --> lhs
}

/// Aligns rhs to the lhs's position on the rhs's superview.
/// - parameter lhs: The position on the rhs's superview to which rhs is aligned.
/// - parameter rhs: The ViewPosition to align.
public func <--(lhs: ViewPosition.OffsetAnchor, rhs: ViewPosition) {
    rhs --> lhs
}

/// Measures the distance between lhs and rhs in points.
/// - parameter lhs: The position on lhs from which to measure.
/// - parameter rhs: The position on rhs to which to measure.
/// - returns: The distance between lhs and rhs. Width and height values will always be positive.
public func |--|(lhs: ViewPosition, rhs: ViewPosition) -> CGSize {
    return lhs.measureDistance(to: rhs)
}

/// Measures the distance between lhs and rhs in points.
/// - parameter lhs: The position on lhs from which to measure.
/// - parameter rhs: The position on lhs's superview to which to measure.
/// - returns: The distance between lhs and rhs. Width and height values will always be positive.
public func |--|(lhs: ViewPosition, rhs: ViewPosition.Anchor) -> CGSize {
    return lhs.measureDistance(toSuperviewAnchor: rhs)
}

/// Measures the distance between lhs and rhs in points.
/// - parameter lhs: The position on rhs's superview from which to measure.
/// - parameter rhs: The position on rhs to which to measure.
/// - returns: The distance between lhs and rhs. Width and height values will always be positive.
public func |--|(lhs: ViewPosition.Anchor, rhs: ViewPosition) -> CGSize {
    return rhs |--| lhs
}

/// Measures the distance between lhs and rhs in points.
/// - parameter lhs: The position on lhs from which to measure.
/// - parameter rhs: The position on lhs's superview to which to measure.
/// - returns: The distance between lhs and rhs. Width and height values will always be positive.
public func |--|(lhs: ViewPosition, rhs: ViewPosition.OffsetAnchor) -> CGSize {
    return lhs.measureDistance(toSuperviewAnchor: rhs.anchor, xOffset: rhs.offset.horizontal, yOffset: rhs.offset.vertical)
}

/// Measures the distance between lhs and rhs in points.
/// - parameter lhs: The position on rhs's superview from which to measure.
/// - parameter rhs: The position on rhs to which to measure.
/// - returns: The distance between lhs and rhs. Width and height values will always be positive.
public func |--|(lhs: ViewPosition.OffsetAnchor, rhs: ViewPosition) -> CGSize {
    return rhs |--| lhs
}

public func +(lhs: ViewPosition, rhs: UIOffset) -> ViewPosition {
    return ViewPosition(view: lhs.view, position: CGPoint(x: lhs.anchorPoint.x + rhs.horizontal, y: lhs.anchorPoint.y + rhs.vertical))
}

public func -(lhs: ViewPosition, rhs: UIOffset) -> ViewPosition {
    return ViewPosition(view: lhs.view, position: CGPoint(x: lhs.anchorPoint.x - rhs.horizontal, y: lhs.anchorPoint.y - rhs.vertical))
}

public func +(lhs: UIOffset, rhs: ViewPosition) -> ViewPosition {
    return rhs + lhs
}

public func +(lhs: ViewPosition.Anchor, rhs: UIOffset) -> ViewPosition.OffsetAnchor {
    return ViewPosition.OffsetAnchor(offset: rhs, anchor: lhs)
}

public func -(lhs: ViewPosition.Anchor, rhs: UIOffset) -> ViewPosition.OffsetAnchor {
    return ViewPosition.OffsetAnchor(offset: -rhs, anchor: lhs)
}

public func +(lhs: UIOffset, rhs: ViewPosition.Anchor) -> ViewPosition.OffsetAnchor {
    return rhs + lhs
}

public func +(lhs: ViewPosition.OffsetAnchor, rhs: UIOffset) -> ViewPosition.OffsetAnchor {
    return ViewPosition.OffsetAnchor(offset: lhs.offset + rhs, anchor: lhs.anchor)
}

public func -(lhs: ViewPosition.OffsetAnchor, rhs: UIOffset) -> ViewPosition.OffsetAnchor {
    return ViewPosition.OffsetAnchor(offset: lhs.offset - rhs, anchor: lhs.anchor)
}

public func +(lhs: UIOffset, rhs: ViewPosition.OffsetAnchor) -> ViewPosition.OffsetAnchor {
    return rhs + lhs
}


// MARK: - DistributionItem Operators


/// Create a DistributionItem array denoting that rhs should be aligned next to lhs.
public func <>(lhs: DistributionItem, rhs: DistributionItem) -> [DistributionItem] {
    return [lhs, rhs]
}

/// Create a DistributionItem array denoting that rhs should be aligned next to the last item in lhs.
public func <>(lhs: [DistributionItem], rhs: DistributionItem) -> [DistributionItem] {
    var bothSides = lhs
    bothSides.append(rhs)
    return bothSides
}

/// Create a DistributionItem array denoting that rhs should be aligned next to the last item in lhs.
public func <>(lhs: [DistributionItem], rhs: UIView) -> [DistributionItem] {
    return lhs <> .view(rhs)
}

/// Create a DistributionItem array denoting that rhs should be aligned next to lhs.
public func <>(lhs: UIView, rhs: DistributionItem) -> [DistributionItem] {
    return .view(lhs) <> rhs
}

/// Create a DistributionItem array denoting that rhs should be aligned next to lhs.
public func <>(lhs: UIView, rhs: UIView) -> [DistributionItem] {
    return .view(lhs) <> .view(rhs)
}

/// Create a DistributionItem array denoting that rhs should be aligned next to lhs.
public func <>(lhs: DistributionItem, rhs: UIView) -> [DistributionItem] {
    return lhs <> .view(rhs)
}

/// Create a DistributionItem array denoting that rhs should be aligned next to the last item in lhs.
public func <>(lhs: [DistributionItem], rhs: CGFloatConvertible) -> [DistributionItem] {
    return lhs <> .fixed(CGFloat(rhs))
}

/// Create a DistributionItem array denoting that rhs should be aligned next to lhs.
public func <>(lhs: CGFloatConvertible, rhs: DistributionItem) -> [DistributionItem] {
    return .fixed(CGFloat(lhs)) <> rhs
}

/// Create a DistributionItem array denoting that rhs should be aligned next to lhs.
public func <>(lhs: DistributionItem, rhs: CGFloatConvertible) -> [DistributionItem] {
    return lhs <> .fixed(CGFloat(rhs))
}

/// Create a DistributionItem array denoting that rhs should be aligned next to lhs.
public func <>(lhs: UIView, rhs: CGFloatConvertible) -> [DistributionItem] {
    return .view(lhs) <> .fixed(CGFloat(rhs))
}

/// Create a DistributionItem array denoting that rhs should be aligned next to lhs.
public func <>(lhs: CGFloatConvertible, rhs: UIView) -> [DistributionItem] {
    return .fixed(CGFloat(lhs)) <> .view(rhs)
}

/// Create a .flexible DistributionItem from a HalfFlexibleDistributionItem.
public prefix func ~(flexibleSpacerHalf: HalfFlexibleDistributionItem) -> DistributionItem {
    return .flexible(flexibleSpacerHalf.flexibleSpacerValue)
}

/// Create half of a .flexible DistributionItem from an integer.
public postfix func ~(flexibleSpacer: Int) -> HalfFlexibleDistributionItem {
    return HalfFlexibleDistributionItem(flexibleSpacerValue: flexibleSpacer)
}


// MARK: – UIOffset Operators


public func +(lhs: UIOffset, rhs: UIOffset) -> UIOffset {
    return UIOffset(horizontal: lhs.horizontal + rhs.horizontal, vertical: lhs.vertical + rhs.vertical)
}

public func -(lhs: UIOffset, rhs: UIOffset) -> UIOffset {
    return UIOffset(horizontal: lhs.horizontal - rhs.horizontal, vertical: lhs.vertical - rhs.vertical)
}

public func /(lhs: UIOffset, rhs: UIOffset) -> UIOffset {
    return UIOffset(horizontal: lhs.horizontal / rhs.horizontal, vertical: lhs.vertical / rhs.vertical)
}

public func *(lhs: UIOffset, rhs: UIOffset) -> UIOffset {
    return UIOffset(horizontal: lhs.horizontal * rhs.horizontal, vertical: lhs.vertical * rhs.vertical)
}

public prefix func -(offset: UIOffset) -> UIOffset {
    return UIOffset(horizontal: -offset.horizontal, vertical: -offset.vertical)
}

public func +(lhs: CGSize, rhs: UIOffset) -> CGSize {
    return CGSize(width: lhs.width + rhs.horizontal, height: lhs.height + rhs.vertical)
}

public func +(lhs: UIOffset, rhs: CGSize) -> CGSize {
    return CGSize(width: rhs.width + lhs.horizontal, height: rhs.height + lhs.vertical)
}


// MARK: CGFloatConvertible


public protocol CGFloatConvertible {}


extension CGFloatConvertible {
    
    public var horizontalOffset: UIOffset {
        return UIOffset(horizontal: CGFloat(self), vertical: 0.0)
    }
    
    public var verticalOffset: UIOffset {
        return UIOffset(horizontal: 0.0, vertical: CGFloat(self))
    }
    
}


// MARK: – CGFloat Extension


extension CGFloat: CGFloatConvertible {
    
    public init(_ convertible: CGFloatConvertible) {
        if let cgFloat = convertible as? CGFloat {
            self = cgFloat
        } else if let double = convertible as? Double {
            self = CGFloat(double)
        } else if let float = convertible as? Float {
            self = CGFloat(float)
        } else if let int = convertible as? Int {
            self = CGFloat(int)
        } else {
            ErrorHandler.assertionFailure("Can not convert \(convertible) to CGFloat!")
            self = 0.0
        }
    }
    
}


// MARK: – Double Extension


extension Double: CGFloatConvertible {}


// MARK: – Float Extension


extension Float: CGFloatConvertible {}


// MARK: – Int Extension


extension Int: CGFloatConvertible {}
