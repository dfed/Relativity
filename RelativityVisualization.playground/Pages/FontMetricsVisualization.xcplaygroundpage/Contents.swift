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
import Relativity
import UIKit


let containerView = UIView()

let font = UIFont.systemFont(ofSize: 160)
let label = UILabel()
label.backgroundColor = UIColor.white
label.text = "Sample"
label.numberOfLines = 0
label.font = font
label.sizeToFit()

let topAlignmentMargin = UIView()
topAlignmentMargin.backgroundColor = .blue
topAlignmentMargin.alpha = 0.4
topAlignmentMargin.frame.size = CGSize(width: label.frame.width, height: FontMetrics(for: font).topInset)

let bottomAlignmentMargin = UIView()
bottomAlignmentMargin.backgroundColor = .blue
bottomAlignmentMargin.alpha = 0.4
bottomAlignmentMargin.frame.size = CGSize(width: label.frame.width, height: FontMetrics(for: font).bottomInset)

containerView.addSubview(label)
containerView.frame.size = label.frame.size

PlaygroundPage.current.liveView = containerView

containerView.addSubview(topAlignmentMargin)
containerView.addSubview(bottomAlignmentMargin)

topAlignmentMargin.bottomCenter --> label.topCenter
bottomAlignmentMargin.topCenter --> label.bottomCenter

containerView.sendSubview(toBack: label)
