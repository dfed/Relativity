import PlaygroundSupport
import Relativity
import UIKit


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

containerView.addSubview(blueRect)
containerView.addSubview(redRect)
containerView.addSubview(yellowRect)
containerView.addSubview(greenRect)

PlaygroundPage.current.liveView = containerView

blueRect.topLeft --> .topLeft
redRect.topRight --> .topRight
yellowRect.bottomRight --> .bottomRight
greenRect.bottomLeft --> .bottomLeft

let anotherContainerView = UIView()
containerView.addSubview(anotherContainerView)

let purpleCircle = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))
let orangeCircle = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))

purpleCircle.backgroundColor = .purple
orangeCircle.backgroundColor = .orange

purpleCircle.layer.cornerRadius = purpleCircle.frame.height / 2.0
orangeCircle.layer.cornerRadius = orangeCircle.frame.height / 2.0

// Note that circles are not in the same coordinate space as the rects above.
anotherContainerView.addSubview(purpleCircle)
anotherContainerView.addSubview(orangeCircle)

purpleCircle.topCenter --> containerView.bottomCenter
orangeCircle.topCenter --> containerView.bottomCenter

DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.milliseconds(200)) {
    UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut, animations: {
        blueRect.center --> containerView.center + (-blueRect.frame.width / 2.0).horizontalOffset + (-blueRect.frame.height / 2.0).verticalOffset
        redRect.leftCenter --> blueRect.rightCenter
        yellowRect.topLeft --> blueRect.bottomRight
        greenRect.topCenter --> blueRect.bottomCenter
        purpleCircle.center --> greenRect.bottomCenter
        orangeCircle.center --> yellowRect.bottomCenter
    }, completion: nil)
}
