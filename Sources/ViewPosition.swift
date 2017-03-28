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

import CoreGraphics
import UIKit


public struct ViewPosition {
    
    // MARK: – Anchor
    
    public enum Anchor {
        
        case topLeft
        case top
        case topRight
        
        case left
        case middle
        case right
        
        case bottomLeft
        case bottom
        case bottomRight
        
        public func anchorPoint(onRect rect: CGRect) -> CGPoint {
            switch self {
            case .topLeft:
                return rect.origin
            case .top:
                return CGPoint(x: rect.midX, y: rect.minY)
            case .topRight:
                return CGPoint(x: rect.maxX, y: rect.minY)
            case .left:
                return CGPoint(x: rect.minX, y: rect.midY)
            case .middle:
                return CGPoint(x: rect.midX, y: rect.midY)
            case .right:
                return CGPoint(x: rect.maxX, y: rect.midY)
            case .bottomLeft:
                return CGPoint(x: rect.minX, y: rect.maxY)
            case .bottom:
                return CGPoint(x: rect.midX, y: rect.maxY)
            case .bottomRight:
                return CGPoint(x: rect.maxX, y: rect.maxY)
            }
        }
    }
    
    // MARK: – OffsetAnchor
    
    public struct OffsetAnchor {
        
        // MARK: Initialization
        
        public init(offset: UIOffset, anchor: Anchor) {
            self.offset = offset
            self.anchor = anchor
        }
        
        // MARK: Internal Properties
        
        internal var offset: UIOffset
        internal var anchor: Anchor
        
    }
    
    // MARK: Initialization
    
    public init(view: UIView, anchor: Anchor) {
        self = ViewPosition(view: view, position: anchor.anchorPoint(onRect: view.bounds))
    }
    
    public init(label: UILabel, anchor: Anchor) {
        self = ViewPosition(view: label, position: anchor.anchorPoint(onRect: label.bounds.insetBy(capAndBaselineOf: label.font, with: PixelRounder(for: label))))
    }
    
    public init(view: UIView, position: CGPoint) {
        self.view = view
        self.anchorPoint = PixelRounder(for: view).roundToPixel(position)
        originalBounds = view.bounds
    }
    
    // MARK: Public Methods
    
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
        
        let frameCenterToAlignTo = untransformedCenter(of: otherViewPosition.view, inCoordinateSpaceOf: superview)
        // Find the desired unrounded center.
        let unroundedCenter = CGPoint(x: frameCenterToAlignTo.x + (otherViewPosition.anchorPoint.x - otherViewPosition.view.bounds.midX) - (anchorPoint.x - view.bounds.midX) + xOffset,
                                      y: frameCenterToAlignTo.y + (otherViewPosition.anchorPoint.y - otherViewPosition.view.bounds.midY) - (anchorPoint.y - view.bounds.midY) + yOffset)
        // Find and round the frame origin (ignoring any transforms).
        let roundedFrameOrigin = PixelRounder(for: view).roundToPixel(CGPoint(x: unroundedCenter.x - view.bounds.midX, y: unroundedCenter.y - view.bounds.midY))
        // Find the center again based off of the rounded frame origin, and set it.
        view.center = CGPoint(x: roundedFrameOrigin.x + view.bounds.midX, y: roundedFrameOrigin.y + view.bounds.midY)
    }
    
    /// Convenience to align the receiver's view to the superview's anchor.
    public func align(toSuperviewAnchor superviewAnchor: Anchor, xOffset: CGFloat = 0.0, yOffset: CGFloat = 0.0) {
        guard let superview = view.superview else {
            assertionFailure("Trying to align to \(view)'s superview but no superview exists")
            return
        }
        
        if let superview = superview as? UILabel {
            align(to: ViewPosition(label: superview, anchor: superviewAnchor), xOffset: xOffset, yOffset: yOffset)
        } else {
            align(to: ViewPosition(view: superview, anchor: superviewAnchor), xOffset: xOffset, yOffset: yOffset)
        }
    }
    
    // MARK: Internal Properties
    
    /// The pixel-rounded anchor point for positioning, in the coordinate space of the bounds.
    internal let anchorPoint: CGPoint
    
    /// The view being positioned.
    internal let view: UIView
    
    // MARK: Private Properties
    
    /// The bounds of the view at initialization time. Used to check bounds changes at alignment-time.
    private let originalBounds: CGRect
    
    // MARK: Private Methods
    
    private func untransformedCenter(of view: UIView, inCoordinateSpaceOf otherView: UIView) -> CGPoint {
        guard let superview = view.superview else {
            assertionFailure("Attempting to find center of view but no superview exists! \(view)")
            return .zero
        }
        
        let viewTransformToRestore = view.transform
        let superviewTransformToRestore = superview.transform
        let otherViewTranformToRestore = otherView.transform
        defer {
            view.transform = viewTransformToRestore
            superview.transform = superviewTransformToRestore
            otherView.transform = otherViewTranformToRestore
        }
        
        view.transform = .identity
        superview.transform = .identity
        otherView.transform = .identity
        
        return superview.convert(view.center, to: otherView)
    }
}
