//
//  TrackedActionMeta.swift
//  PickeMePassenger
//
//  Created by Bishan on 2025-06-22.
//

import Foundation

/// Stores metadata about a dispatched action, primarily used by the `ActionTracker`.
/// This enables debugging, retry handling, lifecycle inspection, and UI reflection.
public struct TrackedActionMeta {
    
    /// The actual action that was tracked (can be any type conforming to `Action`)
    public let action: Action
    
    /// Timestamp of the first dispatch (used for duration/debugging)
    public let timestamp: Date
    
    /// Number of times the same action (by ID) has been dispatched
    public let retryCount: Int
    
    /// Error encountered (if any) during the action's lifecycle
    public let error: APIError?
    
    /// Current lifecycle status of the action
    public let status: ActionStatus

    /// Initializes a tracked action metadata object with all fields.
    public init(
        action: Action,
        timestamp: Date = Date(),
        retryCount: Int = 0,
        error: APIError? = nil,
        status: ActionStatus = .INIT
    ) {
        self.action = action
        self.timestamp = timestamp
        self.retryCount = retryCount
        self.error = error
        self.status = status
    }

    // MARK: - Convenience Accessors

    /// Indicates whether the action is currently loading
    public var isLoading: Bool {
        status == .IN_PROGRESS
    }

    /// Returns the current state of the tracked action
    public func getState() -> ActionStatus {
        status
    }

    /// Returns the error, if any
    public func getError() -> APIError? {
        error
    }

    /// Compares whether another action is of the same type
    public func isSameType(as other: Action) -> Bool {
        type(of: action) == type(of: other)
    }
}
