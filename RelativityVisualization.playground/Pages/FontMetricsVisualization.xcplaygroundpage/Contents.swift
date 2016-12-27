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
