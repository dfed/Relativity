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


extension UIView {

    // MARK: Public Properties

    public var topLeft: ViewPosition {
        position(with: .topLeft)
    }

    public var top: ViewPosition {
        position(with: .top)
    }

    public var topRight: ViewPosition {
        position(with: .topRight)
    }

    public var left: ViewPosition {
        position(with: .left)
    }

    public var middle: ViewPosition {
        position(with: .middle)
    }

    public var right: ViewPosition {
        position(with: .right)
    }

    public var bottomLeft: ViewPosition {
        position(with: .bottomLeft)
    }

    public var bottom: ViewPosition {
        position(with: .bottom)
    }

    public var bottomRight: ViewPosition {
        position(with: .bottomRight)
    }

    // MARK: Public Methods

    public func distributeSubviewsVertically(within rect: CGRect = .zero, @DistributionItemsBuilder subviewDistributionCreationBlock: () -> [DistributionItem]) {
        SubviewDistributor.newVerticalSubviewDistributor(with: self).distribute(subviewDistribution: subviewDistributionCreationBlock(), within: rect)
    }

    public func distributeSubviewsHorizontally(within rect: CGRect = .zero, @DistributionItemsBuilder subviewDistributionCreationBlock: () -> [DistributionItem]) {
        SubviewDistributor.newHorizontalSubviewDistributor(with: self).distribute(subviewDistribution: subviewDistributionCreationBlock(), within: rect)
    }

    // MARK: Private Methods

    private func position(with anchor: ViewPosition.Anchor) -> ViewPosition {
        ViewPosition(view: self, anchor: anchor)
    }
}
