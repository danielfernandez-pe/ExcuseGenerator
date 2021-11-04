//
//  UIBarButtonItem+.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 24.10.2021.
//

import UIKit
import Combine

extension UIBarButtonItem {
    func tapPublisher() -> EventPublisher {
        EventPublisher(buttonItem: self)
    }
}

// swiftlint:disable nesting
extension UIBarButtonItem {
    struct EventPublisher: Publisher {
        typealias Output = Void
        typealias Failure = Never

        fileprivate var buttonItem: UIBarButtonItem

        func receive<S>(subscriber: S) where S: Subscriber, Never == S.Failure, Void == S.Input {
            let subscription = EventSubscription<S>()
            subscription.target = subscriber
            subscriber.receive(subscription: subscription)
            buttonItem.target = subscription
            buttonItem.action = #selector(subscription.trigger)
        }
    }
}

private extension UIBarButtonItem {
    class EventSubscription<Target: Subscriber>: Subscription where Target.Input == Void {
        var target: Target?

        func request(_ demand: Subscribers.Demand) {}
        func cancel() {
            target = nil
        }

        @objc
        func trigger() {
            _ = target?.receive(())
        }
    }
}

private extension UIViewController {
    class EventSubscription<Target: Subscriber>: Subscription where Target.Input == Void {
        var target: Target?

        func request(_ demand: Subscribers.Demand) {}
        func cancel() {
            target = nil
        }

        @objc
        func trigger() {
            _ = target?.receive(())
        }
    }
}
