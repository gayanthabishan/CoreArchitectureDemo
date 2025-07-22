//
//  ActionTracker.swift
//  PickeMePassenger
//
//  Created by Bishan on 2025-06-22.
//

import Foundation

/// Tracks the lifecycle of actions (especially async) across the app,
/// useful for global loading states, retries, error tracking, and logging.
public struct ActionTracker {
    
    /// Holds metadata for each tracked action, keyed by a unique action ID.
    private var actions: [String: TrackedActionMeta] = [:]

    public init() {}

    // MARK: - Accessors

    /// Returns the full metadata object for a given action ID.
    public func meta(for id: String) -> TrackedActionMeta? {
        actions[id]
    }

    /// Returns the action object for a given ID (if available).
    public subscript(id: String) -> Action? {
        actions[id]?.action
    }

    // MARK: - Mutation

    /// Tracks or updates an action's metadata.
    ///
    /// - Parameters:
    ///   - id: The unique action ID.
    ///   - action: The action being tracked.
    public mutating func set(_ id: String, action: Action) {
        let status = (action as? BaseAction)?.getState() ?? .INIT
        let error = (action as? BaseAction)?.getError()

        let existing = actions[id]
        let retry = (existing?.retryCount ?? 0) + 1
        let timestamp = existing?.timestamp ?? Date()

        let meta = TrackedActionMeta(
            action: action,
            timestamp: timestamp,
            retryCount: retry,
            error: error,
            status: status
        )

        actions[id] = meta

        print("""
        🟡 Action Tracked
        ┌────────────────────────────
        │ ID        : \(id)
        │ Type      : \(type(of: action))
        │ Status    : \(status)
        │ Retry     : \(retry)
        │ Error     : \(error?.localizedDescription ?? "None")
        │ Started   : \(timestamp)
        └────────────────────────────
        """)
    }

    /// Removes a tracked action from the store and logs summary.
    public mutating func remove(_ id: String) {
        guard let removed = actions.removeValue(forKey: id) else {
            print("⚠️ Attempted to remove action \(id), but it was not found.")
            return
        }

        let duration = Date().timeIntervalSince(removed.timestamp)
        print("""
        ✅ Action Removed
        ┌────────────────────────────
        │ ID        : \(id)
        │ Type      : \(type(of: removed.action))
        │ Final     : \(removed.status)
        │ Duration  : \(String(format: "%.2f", duration))s
        └────────────────────────────
        """)
    }

    // MARK: - Status Helpers

    /// Returns whether the given action ID is in a loading state.
    public func isLoading(id: String) -> Bool {
        actions[id]?.isLoading ?? false
    }

    /// Returns whether any action is currently loading.
    public func isAnyLoading() -> Bool {
        actions.values.contains { $0.isLoading }
    }

    /// Returns the associated error for the action with the given ID.
    public func getError(for id: String) -> APIError? {
        actions[id]?.error
    }

    /// Returns retry count for the action with the given ID.
    public func retryCount(for id: String) -> Int {
        actions[id]?.retryCount ?? 0
    }

    /// Returns start time of the action (if available).
    public func startTime(for id: String) -> Date? {
        actions[id]?.timestamp
    }

    /// Returns a full map of all tracked actions.
    public var all: [String: TrackedActionMeta] {
        actions
    }

    // MARK: - Debug Utilities

    /// Prints a full summary of all currently tracked actions.
    public func debugDump() {
        print("📋 Action Tracker State — Total: \(actions.count)")
        for (id, meta) in actions {
            print("""
            ───────────────
            ID      : \(id)
            Type    : \(type(of: meta.action))
            Status  : \(meta.status)
            Error   : \(meta.error?.localizedDescription ?? "None")
            Retry   : \(meta.retryCount)
            Started : \(meta.timestamp)
            """)
        }
        print("──────────────────────────────\n")
    }
}


