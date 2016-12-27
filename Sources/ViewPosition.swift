//
//  ViewPosition.swift
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


public struct ViewPosition {
    
    public enum Anchor {
        case topLeft
        case topCenter
        case topRight
        
        case bottomLeft
        case bottomCenter
        case bottomRight
        
        case leftCenter
        case rightCenter
        
        case center
        
        public func anchorPoint(onRect rect: CGRect) -> CGPoint {
            switch self {
            case .topLeft:
                return rect.origin
            case .topCenter:
                return CGPoint(x: rect.maxX / 2.0, y: rect.minY)
            case .topRight:
                return CGPoint(x: rect.maxX, y: rect.minY)
            case .bottomLeft:
                return CGPoint(x: rect.minX, y: rect.maxY)
            case .bottomCenter:
                return CGPoint(x: rect.maxX / 2.0, y: rect.maxY)
            case .bottomRight:
                return CGPoint(x: rect.maxX, y: rect.maxY)
            case .leftCenter:
                return CGPoint(x: rect.minX, y: rect.maxY / 2.0)
            case .rightCenter:
                return CGPoint(x: rect.maxX, y: rect.maxY / 2.0)
            case .center:
                return CGPoint(x: rect.maxX / 2.0, y: rect.maxY / 2.0)
            }
        }
    }
    
    // MARK: Initialization
    
    public init(_ view: UIView, _ anchor: Anchor) {
        self = ViewPosition(view: view, position: anchor.anchorPoint(onRect: view.bounds))
    }
    
    public init(_ label: UILabel, _ anchor: Anchor) {
        self = ViewPosition(view: label as UIView, position: anchor.anchorPoint(onRect: FontMetrics(for: label.font).textFrame(within: label.bounds)))
    }
    
    public init(view: UIView, position: CGPoint) {
        self.view = view
        self.anchor = PixelRounder(for: view).roundToPixel(position)
        originalBounds = view.bounds
    }
    
    // MARK: Public Methods
    
    /// Aligns the receiver's view to the passed in view/anchor.
    public func align(to view: UIView, _ anchor: Anchor, xOffset: CGFloat = 0.0, yOffset: CGFloat = 0.0) {
        align(to: ViewPosition(view, anchor), xOffset: xOffset, yOffset: yOffset)
    }
    
    /// Aligns the receiver's view to the passed in ViewPosition.
    public func align(to otherViewPosition: ViewPosition, xOffset: CGFloat = 0.0, yOffset: CGFloat = 0.0) {
        guard view.bounds == originalBounds else {
            assertionFailure("Bounds of view to align have changed since ViewPosition was created! \(originalBounds) -> \(view.bounds)")
            return
        }
        guard otherViewPosition.view.bounds == otherViewPosition.originalBounds else {
            assertionFailure("Bounds of view to align to have changed since ViewPosition was created! \(otherViewPosition.originalBounds) -> \(otherViewPosition.view.bounds)")
            return
        }
        guard let superview = view.superview else {
            assertionFailure("Attempting to align view but no superview exists! \(view)")
            return
        }
        guard let otherSuperview = otherViewPosition.view.superview else {
            assertionFailure("Attempting to align view but no superview exists! \(otherViewPosition.view)")
            return
        }
        
        let frameOriginToAlignTo = otherSuperview.convert(otherViewPosition.view.frame.origin, to: superview)
        view.frame.origin = PixelRounder(for: view).roundToPixel(
            CGPoint(x: frameOriginToAlignTo.x + otherViewPosition.anchor.x - anchor.x + xOffset,
                    y: frameOriginToAlignTo.y + otherViewPosition.anchor.y - anchor.y + yOffset)
        )
    }
    
    /// Convenience to align the receiver's view to the superview's anchor.
    public func align(toSuperviewAnchor superviewAnchor: Anchor, xOffset: CGFloat = 0.0, yOffset: CGFloat = 0.0) {
        guard let superview = view.superview else {
            assertionFailure("Trying to align to \(view)'s superview but no superview exists")
            return
        }
        
        align(to: superview, superviewAnchor, xOffset: xOffset, yOffset: yOffset)
    }
    
    // MARK: Internal Properties
    
    /// The pixel-rounded anchor point for positioning, in the coordinate space of the bounds.
    internal let anchor: CGPoint
    
    /// The view being positioned.
    internal let view: UIView
    
    // MARK: Private Properties
    
    /// The bounds of the view at initialization time. Used to check bounds changes at alignment-time.
    private let originalBounds: CGRect
}
