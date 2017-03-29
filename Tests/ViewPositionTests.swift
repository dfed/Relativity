//
//  ViewPositionTests.swift
//  Relativity
//
//  Created by Dan Federman on 3/29/17.
//  Copyright © 2017 Dan Federman.
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

import XCTest
@testable import Relativity


class ViewPositionTests: XCTestCase {
    
    // MARK: XCTestCase
    
    public override func setUp() {
        window.subviews.forEach { $0.removeFromSuperview() }
        view.subviews.forEach { $0.removeFromSuperview() }
        subview1.subviews.forEach { $0.removeFromSuperview() }
        subview2.subviews.forEach { $0.removeFromSuperview() }
        
        window.frame = CGRect(x: 0.0, y: 0.0, width: 375, height: 667)
        view.frame = window.bounds
        window.addSubview(view)
        
        let pixelRounder = PixelRounder(for: window)
        func randomFrameWithinWindow() -> CGRect {
            let subviewOrigin = CGPoint(x: pixelRounder.floorToPixel(CGFloat(arc4random_uniform(UInt32(window.bounds.width - 1)))),
                                        y: pixelRounder.floorToPixel(CGFloat(arc4random_uniform(UInt32(window.bounds.height - 1)))))
            return CGRect(origin: subviewOrigin,
                          size: CGSize(width: pixelRounder.floorToPixel(CGFloat(arc4random_uniform(UInt32(window.bounds.width - subviewOrigin.x)))),
                                       height: pixelRounder.floorToPixel(CGFloat(arc4random_uniform(UInt32(window.bounds.height - subviewOrigin.y))))))
        }
        subview1.frame = randomFrameWithinWindow()
        subview2.frame = randomFrameWithinWindow()
        
        view.addSubview(subview1)
        view.addSubview(subview2)
    }
    
    // MARK: Behavior Tests
    
    public func test_measureDistance_measuresToPixelBoundaries() {
        subview1.frame.size.height += 1.2345
        subview2.frame.size.width += 0.54321
        
        view.addSubview(subview1)
        view.addSubview(subview2)

        let pixelRounder = PixelRounder(for: window)
        XCTAssertEqualWithAccuracy(subview1.left |--| subview2.right,
                                   CGSize(width: abs(pixelRounder.roundToPixel(subview1.frame.minX) - pixelRounder.roundToPixel(subview2.frame.maxX)),
                                          height: abs(pixelRounder.roundToPixel(subview1.frame.midY) - pixelRounder.roundToPixel(subview2.frame.midY))),
                                   accuracy: 1e-10)
    }
    
    public func test_measureDistance_isCommutative() {
        XCTAssertEqualWithAccuracy(subview1.topLeft |--| subview2.bottomRight, subview2.bottomRight |--| subview1.topLeft, accuracy: 1e-10)
    }

    public func test_measureDistance_ignoresTransforms() {
        let preTransformDistance = subview1.bottom |--| subview2.top
        
        subview1.transform = CGAffineTransform(translationX: 50.0, y: -11.0)
        subview2.transform = CGAffineTransform(scaleX: 2.0, y: -1.2)
        
        XCTAssertEqual(subview1.bottom |--| subview2.top, preTransformDistance)
    }
    
    // MARK: Private Properties
    
    private let window = UIWindow()
    private let view = UIView()
    private let subview1 = UIView()
    private let subview2 = UIView()
}


// MARK: - Test Helpers


public func XCTAssertEqualWithAccuracy(_ size1: CGSize, _ size2: CGSize, accuracy: CGFloat, _ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) {
    XCTAssertEqualWithAccuracy(size1.width, size2.width, accuracy: accuracy, message, file: file, line: line)
    XCTAssertEqualWithAccuracy(size1.height, size2.height, accuracy: accuracy, message, file: file, line: line)
}
