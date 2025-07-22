//
//  AppStateObserver.swift
//  PickeMePassenger
//
//  Created by Bishanm on 2025-06-29.
//

import ReSwift
import Foundation
import Combine

import Combine
import ReSwift

/// `AppStateObserver` is a lightweight SwiftUI-friendly bridge that subscribes to the global ReSwift store.
/// It exposes the entire AppState via `@Published` so SwiftUI views can automatically react to state changes.
public final class AppStateObserver: ObservableObject {
    
    /// The current application state, published to allow SwiftUI views to observe and react to changes.
    @Published public var state: AppState

    /// A reference to the ReSwift store.
    private var store: Store<AppState>

    /// Initializes the observer with a reference to the global store.
    /// - Parameter store: The ReSwift store that holds the global `AppState`.
    public init(store: Store<AppState>) {
        self.store = store
        self.state = store.state // Set the initial state

        // Subscribe to all state changes. The selector `$0.select { $0 }` means:
        // “I want updates for the full AppState, not just a slice.”
        store.subscribe(self) {
            $0.select { $0 }
        }
    }

    /// Ensures the observer unsubscribes from the store when deallocated.
    /// This is crucial to prevent memory leaks and dangling subscriptions.
    deinit {
        store.unsubscribe(self)
    }
}

extension AppStateObserver: StoreSubscriber {
    
    /// This method is called whenever the global state changes.
    /// It updates the `@Published state` on the main thread to notify any SwiftUI views observing it.
    /// - Parameter state: The new `AppState` pushed from the ReSwift store.
    public func newState(state: AppState) {
        DispatchQueue.main.async {
            self.state = state
        }
    }
}



