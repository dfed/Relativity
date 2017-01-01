//
//  TestHelpers.swift
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

import CoreGraphics
import Foundation
@testable import Relativity
import UIKit


extension CGPoint {
    
    func isEqual(toRounded point: CGPoint, using pixelRounder: PixelRounder) -> Bool {
        let xIsWithinOnePixel = x.roundedToThirdDecimalPoint == point.x.roundedToThirdDecimalPoint
        let yIsWithinOnePixel = y.roundedToThirdDecimalPoint == point.y.roundedToThirdDecimalPoint
        
        return xIsWithinOnePixel && yIsWithinOnePixel
    }
    
}


extension CGFloat {
    
    func isEqual(toRounded float: CGFloat, using pixelRounder: PixelRounder) -> Bool {
        return self.roundedToThirdDecimalPoint == float.roundedToThirdDecimalPoint
    }
    
    var roundedToThirdDecimalPoint: CGFloat {
        return RelativityTests.roundedToThirdDecimalPoint(self)
    }
    
}


func roundedToThirdDecimalPoint(_ float: CGFloat) -> CGFloat {
    return round(float * 1000.0) / 1000.0
}
