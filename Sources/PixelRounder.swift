//
//  PixelRounder.swift
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


public struct PixelRounder {
    
    // MARK: Initialization
    
    public init(for view: UIView) {
        ErrorHandler.assert(view.window != nil, "Creating PixelRounder with a view that has not been added to a window! Using the main screen's scale instead.")
        self = PixelRounder(withScreenScale: (view.window?.screen ?? UIScreen.main).scale)
    }
    
    public init(for window: UIWindow) {
        self = PixelRounder(withScreenScale: window.screen.scale)
    }
    
    public init(for screen: UIScreen = UIScreen.main) {
        self = PixelRounder(withScreenScale: screen.scale)
    }
    
    internal init(withScreenScale screenScale: CGFloat) {
        if screenScale.truncatingRemainder(dividingBy: 1.0) == 0.0 {
            self.screenScale = screenScale
            
        } else {
            ErrorHandler.assertionFailure("Initializing a PixelRounder with a screenScale that isn't integral.")
            self.screenScale = round(screenScale)
        }
    }
    
    // MARK: Public Methods
    
    public func roundToPixel(_ float: CGFloat) -> CGFloat {
        return round(float * screenScale) / screenScale
    }
    
    public func ceilToPixel(_ float: CGFloat) -> CGFloat {
        return ceil(float * screenScale) / screenScale
    }
    
    public func floorToPixel(_ float: CGFloat) -> CGFloat {
        return floor(float * screenScale) / screenScale
    }
    
    public func roundToPixel(_ point: CGPoint) -> CGPoint {
        return CGPoint(x: roundToPixel(point.x), y: roundToPixel(point.y))
    }
    
    public func ceilToPixel(_ point: CGPoint) -> CGPoint {
        return CGPoint(x: ceilToPixel(point.x), y: ceilToPixel(point.y))
    }
    
    public func floorToPixel(_ point: CGPoint) -> CGPoint {
        return CGPoint(x: floorToPixel(point.x), y: floorToPixel(point.y))
    }
    
    public func isRoundedToPixel(_ float: CGFloat) -> Bool {
        return abs(float - roundToPixel(float)) < 1e-10
    }
    
    public func isRoundedToPixel(_ point: CGPoint) -> Bool {
        return abs(point.x - roundToPixel(point.x)) < 1e-10 && abs(point.y - roundToPixel(point.y)) < 1e-10
    }
    
    // MARK: Internal Properties
    
    internal let screenScale: CGFloat
}
