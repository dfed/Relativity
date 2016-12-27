//
//  SubviewDistributor.swift
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
import Foundation
import UIKit


public struct SubviewDistributor {
    
    // MARK: Direction
    
    private enum Direction {
        case vertical
        case horizontal
    }
    
    // MARK: Public Static Methods
    
    public static func newVerticalSubviewDistributor(with superview: UIView) -> SubviewDistributor {
        return SubviewDistributor(with: superview, direction: .vertical)
    }
    
    public static func newHorizontalSubviewDistributor(with superview: UIView) -> SubviewDistributor {
        return SubviewDistributor(with: superview, direction: .horizontal)
    }
    
    // MARK: Initialization
    
    private init(with superview: UIView, direction: Direction) {
        self.superview = superview
        self.direction = direction
    }
    
    // MARK: Public Methods
    
    public func distribute(subviewDistribution: [DistributionItem], within rect: CGRect = .zero) {
        var distributionRect = rect
        if distributionRect == .zero {
            distributionRect = superview.bounds
        }
        
        let distributionItems: [DistributionItem] = {
            var distributionItems = subviewDistribution.filter { (distributionItem) -> Bool in
                switch distributionItem {
                case .fixed:
                    return true
                    
                case let .relative(spacer):
                    guard spacer > 0 else {
                        assertionFailure("Attempting to distribute a relative spacer \(spacer), which is less than 1!")
                        return false
                    }
                    
                    return true
                    
                case let .view(view):
                    guard superview.subviews.contains(view) else {
                        assertionFailure("Attempting to distribute a view \(view) that is not a subview of \(superview)!")
                        return false
                    }
                    
                    return true
                }
            }
            
            // Ensure our first element is a spacer.
            if let firstDistributionItem = distributionItems.first {
                switch firstDistributionItem {
                case .fixed, .relative:
                    // Nothing to do here. Our first element is already a spacer.
                    break
                    
                case .view:
                    distributionItems.insert(.relative(1), at: 0)
                }
            }
                
            if let lastDistributionItem = distributionItems.last {
                switch lastDistributionItem {
                case .fixed, .relative:
                    // Nothing to do here. Our last element is already a spacer.
                    break
                    
                case .view:
                    distributionItems.append(.relative(1))
                }
            }
            
            return distributionItems
        }()
        
        let totalRelativeSpaceForDistribution: CGFloat = {
            var totalRelativeSpace: CGFloat
            
            switch direction {
            case .vertical:
                totalRelativeSpace = distributionRect.size.height
            case .horizontal:
                totalRelativeSpace = distributionRect.size.width
            }
            
            for case let .fixed(space) in distributionItems {
                totalRelativeSpace -= CGFloat(space)
            }
            
            for case let .view(view) in distributionItems {
                switch direction {
                case .vertical:
                    totalRelativeSpace -= view.frame.size.height
                case .horizontal:
                    totalRelativeSpace -= view.frame.size.width
                }
            }
            
            return totalRelativeSpace
        }()
        
        if totalRelativeSpaceForDistribution < 0 {
            assertionFailure("Views are too large to fit in distribution.")
            // Make the space we're distributing in big enough to fit the views. This will look bad, but it is a better option than bailing out entirely.
            switch direction {
            case .vertical:
                distributionRect = distributionRect.insetBy(dx: 0.0, dy: totalRelativeSpaceForDistribution)
            case .horizontal:
                distributionRect = distributionRect.insetBy(dx: totalRelativeSpaceForDistribution, dy: 0.0)
            }
        }
        
        var relativeSpacers = [Int]()
        for case let .relative(space) in distributionItems {
            relativeSpacers.append(space)
        }
        let smallestRelativeSpacer = relativeSpacers.min() ?? 1
        let cumulativeRelativeSpace: Int = {
            var cumulativeRelativeSpace = 0
            relativeSpacers.forEach { cumulativeRelativeSpace += $0 }
            return cumulativeRelativeSpace
        }()
        
        func offset(forFixedSpacer fixedSpacer: CGFloat) -> UIOffset {
            switch direction {
            case .vertical:
                return fixedSpacer.verticalOffset
            case .horizontal:
                return fixedSpacer.horizontalOffset
            }
        }
        
        func offset(forRelativeSpacer relativeSpacer: Int) -> UIOffset {
            let relativeSpacePerUnit = CGFloat(smallestRelativeSpacer) / CGFloat(cumulativeRelativeSpace)
            return offset(forFixedSpacer: totalRelativeSpaceForDistribution * CGFloat(relativeSpacer) * relativeSpacePerUnit)
        }
        
        // Calculate the ViewPosition (e.g. the Anchor) on `superview` for aligning. Make sure to take the `rect` into account.
        
        var leadingViewPosition: ViewPosition = {
            let leadingOffset = UIOffset(horizontal: distributionRect.origin.x, vertical: distributionRect.origin.y)
            switch direction {
            case .vertical:
                return superview.topCenter + leadingOffset
            case .horizontal:
                return superview.leftCenter + leadingOffset
            }
        }()
        
        for distributionItem in distributionItems {
            switch distributionItem {
            case let .fixed(spacer):
                leadingViewPosition = leadingViewPosition + offset(forFixedSpacer: CGFloat(spacer))
                
            case let .relative(spacer):
                leadingViewPosition = leadingViewPosition + offset(forRelativeSpacer: spacer)
                
            case let .view(view):
                switch direction {
                case .vertical:
                    view.topCenter --> leadingViewPosition
                    leadingViewPosition = view.bottomCenter
                case .horizontal:
                    view.leftCenter --> leadingViewPosition
                    leadingViewPosition = view.rightCenter
                }
            }
        }
    }
    
    // MARK: Private Properties
    
    private let direction: Direction
    private let superview: UIView
    
    // MARK: Private Methods
    
}
