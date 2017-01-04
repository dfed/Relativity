//
//  FontMetricsVisualization.swift
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

import PlaygroundSupport
import UIKit

// This import will only work when the Playground is run within Relativity.xcworkspace.
import Relativity


//: ### Create views

let containerView = UIView()

let font = UIFont.systemFont(ofSize: 160)
let label = UILabel()
label.backgroundColor = .white
label.text = "Sample"
label.numberOfLines = 0
label.font = font

let topAlignmentMargin = UIView()
topAlignmentMargin.backgroundColor = .blue
topAlignmentMargin.alpha = 0.4

let bottomAlignmentMargin = UIView()
bottomAlignmentMargin.backgroundColor = .blue
bottomAlignmentMargin.alpha = 0.4

//: ### Create view hierarchy

containerView.addSubview(label)
containerView.addSubview(topAlignmentMargin)
containerView.addSubview(bottomAlignmentMargin)
containerView.sendSubview(toBack: label)

//: ### Size views

label.sizeToFit()
containerView.frame = label.bounds

PlaygroundPage.current.liveView = containerView

topAlignmentMargin.frame.size = CGSize(width: label.frame.width, height: font.capInset(with: PixelRounder(for: topAlignmentMargin)))
bottomAlignmentMargin.frame.size = CGSize(width: label.frame.width, height: font.baselineInset(with: PixelRounder(for: bottomAlignmentMargin)))

//: ### Position views

topAlignmentMargin.bottom --> label.top
bottomAlignmentMargin.top --> label.bottom
