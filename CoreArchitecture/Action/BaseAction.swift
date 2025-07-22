//
//  BaseAction.swift
//  PickeMePassenger
//
//  Created by Bishan on 2025-06-22.
//

import ReSwift

// MARK: - BaseAction Protocol

/// Protocol that defines a lifecycle-aware action with status and error tracking.
/// Conforming types can represent `.INIT`, `.IN_PROGRESS`, `.COMPLETED`, `.ERROR` states.
/// Supports optional chaining for error recovery and auto-success triggers.
public protocol BaseAction: Action {
    
    /// Returns the current state of the action (INIT, IN_PROGRESS, COMPLETED, ERROR)
    func getState() -> ActionStatus
    
    /// If the action failed, returns the associated APIError (if any)
    func getError() -> APIError?
    
    /// Optional: Provide a failure version of this action, useful for reducers or logging
    func failureVersion(with error: APIError) -> Action?
    
    /// Optional: If the action needs to auto-dispatch a success action after `.perform`, define here
    static var autoSuccess: Action? { get }
}

public extension Action {
    
    /// Default getter to extract state if the action conforms to `BaseAction`.
    func getState() -> ActionStatus {
        (self as? BaseAction)?.getState() ?? .INIT
    }

    /// Default getter to extract error if the action conforms to `BaseAction`.
    func getError() -> APIError? {
        (self as? BaseAction)?.getError()
    }

    /// Checks if two actions are of the same concrete type.
    func isSameType(as other: Action) -> Bool {
        return type(of: self) == type(of: other)
    }

    /// Default implementation returns nil (can be overridden).
    func failureVersion(with error: APIError) -> Action? {
        return nil
    }

    /// Default implementation for autoSuccess (can be overridden).
    static var autoSuccess: Action? {
        return nil
    }
}

/// Used to remove an action from global action tracker (usually after cleanup or logout).
public enum RemoveStateStatus: BaseAction {
    case perform(actionId: String)

    public func getState() -> ActionStatus { .COMPLETED }
    public func getError() -> APIError? { nil }
}

/// Enum that represents the lifecycle phase of an async or tracked action.
public enum ActionStatus {
    case INIT        // Action has been dispatched but not yet started
    case IN_PROGRESS // Action is executing
    case COMPLETED   // Action completed successfully
    case ERROR       // Action encountered an error
}

/// Wrapper enum to capture errors from network, decoding, or custom rejection.
public enum APIError: Error {
    case networkError(Error)
    case invalidResponse
    case decodingError
    case rejected(reason: String)

    public init(from error: Error) {
        self = .networkError(error)
    }
}

/// Wraps an action with a unique ID to enable global tracking, retry, and debug inspection.
public struct TrackedAction: Action {
    public let actionId: String
    public let innerAction: Action
    
    public init(actionId: String, innerAction: Action) {
        self.actionId = actionId
        self.innerAction = innerAction
    }
}

