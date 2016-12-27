//
//  FontMetrics.swift
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


public struct FontMetrics {
    
    // MARK: Initialization
    
    public init(for font: UIFont) {
        self.font = font
    }
    
    // MARK: Public Properties
    
    public let font: UIFont
    
    public var topInset: CGFloat {
        return PixelRounder().floorToPixel(font.ascender - font.capHeight)
    }
    
    public var bottomInset: CGFloat {
        return PixelRounder().ceilToPixel(abs(font.descender))
    }
    
    // MARK: Public Methods
    
    /// Returns a rect inset by teh top and bottom font inset.
    public func textFrame(within rect: CGRect) -> CGRect {
        var textFrame = rect
        textFrame.origin.y = topInset
        textFrame.size.height -= topInset + bottomInset
        
        return textFrame
    }
}
