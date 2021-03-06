//
//  NextFlowItem.swift
//  RxFlow
//
//  Created by Thibault Wittemberg on 17-10-09.
//  Copyright (c) RxSwiftCommunity. All rights reserved.
//

/// A NextFlowItem is the result of the coordination action between a Flow and a Step (See Flow.navigate(to:) function)
/// It describes the next thing that will be presented (a Presentable) and
/// the next thing the Coordinator will listen to have the next navigation Steps (a Stepper).
/// If a navigation action does not have to lead to a NextFlowItem, it is possible to have an empty NextFlowItem array
public struct NextFlowItem {

    /// The presentable that will be handle by the Coordinator. The Coordinator is not
    /// meant to display this presentable, it will only handle its "Display" status
    /// so that the associated Stepper will be listened or not
    let nextPresentable: Presentable

    /// The Stepper that will be handle by the Coordinator. It will emit the new
    /// navigation Steps. The Coordinator will listen to them only if the associated
    /// Presentable is displayed
    let nextStepper: Stepper

	/// Flag to determin if this flow is suppose to be root in UIWindow, this mechanism
	/// proved support to swap flows. In future it would be good to have mechanism to
	/// swap flows event in spacific place in hierarchy.
	var isRootFlowItem: Bool

    /// Initialize a new NextFlowItem
    ///
    /// - Parameters:
    ///   - nextPresentable: the next presentable to be handled by the Coordinator
    ///   - nextStepper: the next Steper to be handled by the Coordinator
    public init(nextPresentable presentable: Presentable, nextStepper stepper: Stepper, isRootFlowable isRoot: Bool = false) {
        self.nextPresentable = presentable
        self.nextStepper = stepper
		self.isRootFlowItem = isRoot
    }
}

/// NextFlowItems reprent the next things that will trigger
/// navigation actions inside a Flow
///
/// - multiple: a Flow will trigger several NextFlowItem at the same time for the same Step
/// - one: a Flow will trigger only one NextFlowItem for a Step
/// - none: no further navigation will be triggered for a Step
/// - stepNotHandled: the Step matches no NextFlowItem at all
public enum NextFlowItems {
    /// a Flow will trigger several NextFlowItem at the same time for the same Step
    case multiple (flowItems: [NextFlowItem])
    /// a Flow will trigger only one NextFlowItem for a Step
    case one (flowItem: NextFlowItem)
    /// no further navigation will be triggered for a Step
    case none
    /// the Step matches no NextFlowItem at all
    case stepNotHandled
}
