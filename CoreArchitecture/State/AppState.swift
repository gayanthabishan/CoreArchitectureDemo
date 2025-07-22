//
//  AppState.swift
//  PickeMePassenger
//
//  Created by Bishan on 2025-06-22.
//

import ReSwift

/// `AppState` represents the central state container for the entire application.
/// It holds feature-specific states in a generic, dynamic way, and also tracks actions globally.
public struct AppState {
    
    /// A dictionary to hold individual feature states using string keys.
    ///
    /// - Key: A unique string identifier for the feature module (e.g., `"ride"`, `"events"`).
    /// - Value: The corresponding feature state (any type, typically cast to the expected struct).
    ///
    /// This design enables modular and extensible architecture where features
    /// can plug into the global state without tightly coupling their definitions.
    public var featureStates: [String: Any] = [:]

    /// A centralized action tracker that keeps record of ongoing, completed, and failed actions.
    ///
    /// Used to track side effects like API requests, retries, and statuses for loaders, analytics, etc.
    public var actionTracker: ActionTracker = .init()
}
