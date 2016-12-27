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

import Foundation


// MARK: – ViewPosition Operators


infix operator --> : AssignmentPrecedence

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

public func +(lhs: ViewPosition, rhs: UIOffset) -> ViewPosition {
    return ViewPosition(view: lhs.view, position: CGPoint(x: lhs.anchor.x + rhs.horizontal, y: lhs.anchor.y + rhs.vertical))
}

public func -(lhs: ViewPosition, rhs: UIOffset) -> ViewPosition {
    return ViewPosition(view: lhs.view, position: CGPoint(x: lhs.anchor.x - rhs.horizontal, y: lhs.anchor.y - rhs.vertical))
}

public func +(lhs: ViewPosition.Anchor, rhs: UIOffset) -> ViewPosition.OffsetAnchor {
    return ViewPosition.OffsetAnchor(offset: rhs, anchor: lhs)
}

public func -(lhs: ViewPosition.Anchor, rhs: UIOffset) -> ViewPosition.OffsetAnchor {
    return ViewPosition.OffsetAnchor(offset: rhs, anchor: lhs)
}

public func +(lhs: ViewPosition.OffsetAnchor, rhs: UIOffset) -> ViewPosition.OffsetAnchor {
    return ViewPosition.OffsetAnchor(offset: lhs.offset + rhs, anchor: lhs.anchor)
}

public func -(lhs: ViewPosition.OffsetAnchor, rhs: UIOffset) -> ViewPosition.OffsetAnchor {
    return ViewPosition.OffsetAnchor(offset: lhs.offset - rhs, anchor: lhs.anchor)
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


// MARK: – CGFloat Extension


public extension CGFloat {
    
    public var horizontalOffset: UIOffset {
        return UIOffset(horizontal: self, vertical: 0.0)
    }
    
    public var verticalOffset: UIOffset {
        return UIOffset(horizontal: 0.0, vertical: self)
    }
    
}


// MARK: – Double Extension


public extension Double {
    
    public var horizontalOffset: UIOffset {
        return UIOffset(horizontal: CGFloat(self), vertical: 0.0)
    }
    
    public var verticalOffset: UIOffset {
        return UIOffset(horizontal: 0.0, vertical: CGFloat(self))
    }
    
}


// MARK: – Float Extension


public extension Float {
    
    public var horizontalOffset: UIOffset {
        return UIOffset(horizontal: CGFloat(self), vertical: 0.0)
    }
    
    public var verticalOffset: UIOffset {
        return UIOffset(horizontal: 0.0, vertical: CGFloat(self))
    }
    
}


// MARK: – Int Extension


public extension Int {
    
    public var horizontalOffset: UIOffset {
        return UIOffset(horizontal: CGFloat(self), vertical: 0.0)
    }
    
    public var verticalOffset: UIOffset {
        return UIOffset(horizontal: 0.0, vertical: CGFloat(self))
    }
    
}
