//
//  ViewPositionVisualization.swift
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

let containerView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 375, height: 667)))
containerView.backgroundColor = .white

let blueRect = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))
let redRect = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))
let yellowRect = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))
let greenRect = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))

blueRect.backgroundColor = .blue
redRect.backgroundColor = .red
yellowRect.backgroundColor = .yellow
greenRect.backgroundColor = .green

let anotherContainerView = UIView()
let purpleCircle = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))
let orangeCircle = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))

purpleCircle.backgroundColor = .purple
orangeCircle.backgroundColor = .orange
purpleCircle.layer.cornerRadius = purpleCircle.bounds.midY
orangeCircle.layer.cornerRadius = orangeCircle.bounds.midY

//: ### Create view hierarchy

containerView.addSubview(blueRect)
containerView.addSubview(redRect)
containerView.addSubview(yellowRect)
containerView.addSubview(greenRect)

containerView.addSubview(anotherContainerView)

// Note that circles are not in the same coordinate space as the rects above.
anotherContainerView.addSubview(purpleCircle)
anotherContainerView.addSubview(orangeCircle)

PlaygroundPage.current.liveView = containerView

//: ### Position views

8.horizontalOffset + 8.verticalOffset + .topLeft    <--     blueRect.topLeft
redRect.topRight                                    -->     -8.horizontalOffset + 8.verticalOffset + .topRight
yellowRect.bottomRight                              -->     .bottomRight - 8.horizontalOffset - 8.verticalOffset
8.horizontalOffset - 8.verticalOffset + .bottomLeft <--     greenRect.bottomLeft

purpleCircle.top --> containerView.bottom
orangeCircle.top --> containerView.bottom

DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.milliseconds(200)) {
    UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut, animations: {
        blueRect.middle --> containerView.middle + (-blueRect.frame.width / 2.0).horizontalOffset + (-blueRect.frame.height / 2.0).verticalOffset
        blueRect.right <-- redRect.left
        blueRect.bottomRight <-- yellowRect.topLeft
        greenRect.top --> blueRect.bottom
        purpleCircle.middle --> greenRect.bottom
        orangeCircle.middle --> yellowRect.bottom
    }, completion: nil)
}
