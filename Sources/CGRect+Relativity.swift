//
//  CGRect+Relativity.swift
//  Relativity
//
//  Created by Dan Federman on 1/4/17.
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

import CoreGraphics
import UIKit


public extension CGRect {
    
    public func insetBy(capAndBaselineOf font: UIFont, with pixelRounder: PixelRounder = PixelRounder()) -> CGRect {
        var textFrame = self
        
        textFrame.origin.y += font.capInset(with: pixelRounder)
        textFrame.size.height -= font.capInset(with: pixelRounder) + font.baselineInset(with: pixelRounder)
        
        return textFrame
    }
    
}
