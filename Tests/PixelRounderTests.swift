//
//  PixelRounderTests.swift
//  Relativity
//
//  Created by Dan Federman on 12/30/16.
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

import XCTest
@testable import Relativity


class PixelRounderTests: XCTestCase {
    
    public func test_roundToPixel() {
        XCTAssertEqual(PixelRounder(withScreenScale: 1.0).roundToPixel(1.1), 1.0)
        XCTAssertEqual(PixelRounder(withScreenScale: 1.0).roundToPixel(1.5), 2.0)
        XCTAssertEqual(PixelRounder(withScreenScale: 1.0).roundToPixel(CGPoint(x: 1.7, y: 1.2)), CGPoint(x: 2.0, y: 1.0))
        
        XCTAssertEqual(PixelRounder(withScreenScale: 2.0).roundToPixel(1.1), 1.0)
        XCTAssertEqual(PixelRounder(withScreenScale: 2.0).roundToPixel(1.5), 1.5)
        XCTAssertEqual(PixelRounder(withScreenScale: 2.0).roundToPixel(1.75), 2.0)
        XCTAssertEqual(PixelRounder(withScreenScale: 2.0).roundToPixel(CGPoint(x: 1.75, y: 1.25)), CGPoint(x: 2.0, y: 1.5))
        
        XCTAssertEqual(PixelRounder(withScreenScale: 3.0).roundToPixel(1.5), 1.667, accuracy: 0.001)
        XCTAssertEqual(PixelRounder(withScreenScale: 3.0).roundToPixel(CGPoint(x: 1.75, y: 1.25).x), 1.667, accuracy: 0.001)
        XCTAssertEqual(PixelRounder(withScreenScale: 3.0).roundToPixel(CGPoint(x: 1.75, y: 1.25).y), 1.333, accuracy: 0.001)
        XCTAssertEqual(PixelRounder(withScreenScale: 3.0).roundToPixel(CGPoint(x: 1.0, y: 2.0)), CGPoint(x: 1.0, y: 2.0))
    }
    
    public func test_ceilToPixel() {
        XCTAssertEqual(PixelRounder(withScreenScale: 1.0).ceilToPixel(1.1), 2.0)
        XCTAssertEqual(PixelRounder(withScreenScale: 1.0).ceilToPixel(1.5), 2.0)
        XCTAssertEqual(PixelRounder(withScreenScale: 1.0).ceilToPixel(CGPoint(x: 1.7, y: 1.2)), CGPoint(x: 2.0, y: 2.0))
        
        XCTAssertEqual(PixelRounder(withScreenScale: 2.0).ceilToPixel(1.1), 1.5)
        XCTAssertEqual(PixelRounder(withScreenScale: 2.0).ceilToPixel(1.5), 1.5)
        XCTAssertEqual(PixelRounder(withScreenScale: 2.0).ceilToPixel(1.75), 2.0)
        XCTAssertEqual(PixelRounder(withScreenScale: 2.0).ceilToPixel(CGPoint(x: 1.75, y: 1.25)), CGPoint(x: 2.0, y: 1.5))
        
        XCTAssertEqual(PixelRounder(withScreenScale: 3.0).ceilToPixel(1.1), 1.333, accuracy: 0.001)
        XCTAssertEqual(PixelRounder(withScreenScale: 3.0).ceilToPixel(1.5), 1.667, accuracy: 0.001)
        XCTAssertEqual(PixelRounder(withScreenScale: 3.0).ceilToPixel(CGPoint(x: 1.75, y: 1.25).x), 2.0)
        XCTAssertEqual(PixelRounder(withScreenScale: 3.0).ceilToPixel(CGPoint(x: 1.75, y: 1.25).y), 1.333, accuracy: 0.001)
        XCTAssertEqual(PixelRounder(withScreenScale: 3.0).ceilToPixel(CGPoint(x: 1.0, y: 2.0)), CGPoint(x: 1.0, y: 2.0))
    }
    
    public func test_floorToPixel() {
        XCTAssertEqual(PixelRounder(withScreenScale: 1.0).floorToPixel(1.1), 1.0)
        XCTAssertEqual(PixelRounder(withScreenScale: 1.0).floorToPixel(1.5), 1.0)
        XCTAssertEqual(PixelRounder(withScreenScale: 1.0).floorToPixel(CGPoint(x: 1.7, y: 1.2)), CGPoint(x: 1.0, y: 1.0))
        
        XCTAssertEqual(PixelRounder(withScreenScale: 2.0).floorToPixel(1.1), 1.0)
        XCTAssertEqual(PixelRounder(withScreenScale: 2.0).floorToPixel(1.5), 1.5)
        XCTAssertEqual(PixelRounder(withScreenScale: 2.0).floorToPixel(1.75), 1.5)
        XCTAssertEqual(PixelRounder(withScreenScale: 2.0).floorToPixel(CGPoint(x: 1.75, y: 1.25)), CGPoint(x: 1.5, y: 1.0))
        
        XCTAssertEqual(PixelRounder(withScreenScale: 3.0).floorToPixel(1.1), 1.0)
        XCTAssertEqual(PixelRounder(withScreenScale: 3.0).floorToPixel(1.5), 1.333, accuracy: 0.001)
        XCTAssertEqual(PixelRounder(withScreenScale: 3.0).floorToPixel(CGPoint(x: 1.75, y: 1.25).x), 1.667, accuracy: 0.001)
        XCTAssertEqual(PixelRounder(withScreenScale: 3.0).floorToPixel(CGPoint(x: 1.75, y: 1.25).y), 1.0)
        XCTAssertEqual(PixelRounder(withScreenScale: 3.0).floorToPixel(CGPoint(x: 1.0, y: 2.0)), CGPoint(x: 1.0, y: 2.0))
    }
    
}
