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


let containerView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 375, height: 667)))
containerView.backgroundColor = .white

let blueRect = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 75, height: 75)))
let redRect = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 75, height: 75)))
let yellowRect = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 75, height: 75)))
let greenRect = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 75, height: 75)))

blueRect.backgroundColor = .blue
redRect.backgroundColor = .red
yellowRect.backgroundColor = .yellow
greenRect.backgroundColor = .green

containerView.addSubview(blueRect)
containerView.addSubview(redRect)
containerView.addSubview(yellowRect)
containerView.addSubview(greenRect)

PlaygroundPage.current.liveView = containerView

containerView.distributeSubviewsVertically() {
    .view(blueRect)
        <|> .relative(2)
        <|> .view(redRect)
        <|> .fixed(20)
        <|> .view(yellowRect)
        <|> .relative(1)
        <|> .view(greenRect)
}

DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.milliseconds(500)) {
    UIView.animate(withDuration: 1.0, animations: {
        containerView.distributeSubviewsHorizontally() {
            .fixed(20) <|> blueRect <|> .relative(1) <|> redRect <|> .relative(10) <|> yellowRect <|> .relative(1) <|> greenRect <|> .fixed(20)
        }
        
    }) { (_) in
        UIView.animate(withDuration: 1.0, animations: {
            containerView.distributeSubviewsHorizontally() {
                blueRect <|> .fixed(20) <|> redRect <|> .fixed(20) <|> yellowRect <|> .fixed(20) <|> greenRect
            }
            
        }) { (_) in
            UIView.animate(withDuration: 1.0, animations: {
                containerView.distributeSubviewsVertically() {
                    .relative(1) <|> .fixed(50) <|> blueRect <|> .relative(2) <|> greenRect
                }
                containerView.distributeSubviewsHorizontally() {
                    .relative(17) <|> redRect <|> .relative(3) <|> yellowRect <|> .relative(17)
                }
            })
        }
    }
}
