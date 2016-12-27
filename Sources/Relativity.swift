//
//  Relativity.swift
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


public func align(view: UIView, _ anchor: ViewPosition.Anchor, to otherView: UIView, _ otherAnchor: ViewPosition.Anchor, xOffset: CGFloat = 0.0, yOffset: CGFloat = 0.0) {
    ViewPosition(view, anchor).align(to: otherView, otherAnchor, xOffset: xOffset, yOffset: yOffset)
}

public func align(view: UIView, _ anchor: ViewPosition.Anchor, toSuperviewAnchor superviewAnchor: ViewPosition.Anchor, xOffset: CGFloat = 0.0, yOffset: CGFloat = 0.0) {
    ViewPosition(view, anchor).align(toSuperviewAnchor: superviewAnchor, xOffset: xOffset, yOffset: yOffset)
}
