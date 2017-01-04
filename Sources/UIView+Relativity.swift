//
//  UIView+Relativity.swift
//  Relativity
//
//  Created by Dan Federman on 12/27/16.
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


public extension UIView {
    
    // MARK: Public Properties
    
    public var topLeft: ViewPosition {
        return position(with: .topLeft)
    }
    
    public var top: ViewPosition {
        return position(with: .top)
    }
    
    public var topRight: ViewPosition {
        return position(with: .topRight)
    }
    
    public var left: ViewPosition {
        return position(with: .left)
    }
    
    public var center: ViewPosition {
        return position(with: .center)
    }
    
    public var right: ViewPosition {
        return position(with: .right)
    }
    
    public var bottomLeft: ViewPosition {
        return position(with: .bottomLeft)
    }
    
    public var bottom: ViewPosition {
        return position(with: .bottom)
    }
    
    public var bottomRight: ViewPosition {
        return position(with: .bottomRight)
    }
    
    // MARK: Public Methods
    
    public func distributeSubviewsVertically(within rect: CGRect = .zero, subviewDistributionCreationBlock: () -> [DistributionItem]) {
        SubviewDistributor.newVerticalSubviewDistributor(with: self).distribute(subviewDistribution: subviewDistributionCreationBlock(), within: rect)
    }
    
    public func distributeSubviewsHorizontally(within rect: CGRect = .zero, subviewDistributionCreationBlock: () -> [DistributionItem]) {
        SubviewDistributor.newHorizontalSubviewDistributor(with: self).distribute(subviewDistribution: subviewDistributionCreationBlock(), within: rect)
    }
    
    // MARK: Private Methods
    
    private func position(with anchor: ViewPosition.Anchor) -> ViewPosition {
        if let label = self as? UILabel {
            return ViewPosition(label: label, anchor: anchor)
            
        } else {
            return ViewPosition(view: self, anchor: anchor)
        }
    }
}
