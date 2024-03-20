//
//  UILabel+Relativity.swift
//  Relativity
//
//  Created by Dan Federman on 10/2/18.
//  Copyright © 2018 Dan Federman.
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

import UIKit


extension UILabel {

    // MARK: Public Properties

    /// The left of the cap line given the current font.
    public var capLeft: ViewPosition {
        position(for: .topLeft)
    }

    /// The middle of the cap line given the current font.
    public var cap: ViewPosition {
        position(for: .top)
    }

    /// The right of the cap line given the current font.
    public var capRight: ViewPosition {
        position(for: .topRight)
    }

    /// The left of the baseline given the current font.
    public var baselineLeft: ViewPosition {
        position(for: .bottomLeft)
    }

    /// The middle of the baseline given the current font.
    public var baseline: ViewPosition {
        position(for: .bottom)
    }

    /// The right of the baseline given the current font.
    public var baselineRight: ViewPosition {
        position(for: .bottomRight)
    }

    // MARK: Private Methods

    private func position(for anchor: ViewPosition.Anchor) -> ViewPosition {
        ViewPosition(view: self, position: anchor.anchorPoint(onRect: bounds.insetBy(capAndBaselineOf: font, with: PixelRounder(for: self))))
    }

}
