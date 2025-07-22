//
//  AppReducer.swift
//  PickeMePassenger
//
//  Created by Bishan on 2025-06-22.
//

import ReSwift

/// The main reducer that handles application-wide actions and delegates feature-specific logic.
///
/// - Parameters:
///   - action: The incoming action to be handled.
///   - state: The current `AppState`, or `nil` for first launch (creates default).
/// - Returns: The updated `AppState` after processing the action.
public func appReducer(action: Action, state: AppState?) -> AppState {
    var state = state ?? AppState()
    
    // Track or remove action states for global loaders, retries, etc.
    if let tracked = action as? TrackedAction {
        // Store tracked action metadata (e.g., IN_PROGRESS, COMPLETED, etc.)
        state.actionTracker.set(tracked.actionId, action: tracked.innerAction)
    } else if let remove = action as? RemoveStateStatus,
              case .perform(let id) = remove {
        // Remove tracking for a completed or cancelled action
        state.actionTracker.remove(id)
    }
    
    // Loop through all feature reducers and delegate action/state processing
    for featureReducer in AppStateFeatureReducers.all {
        state = featureReducer(action, state)
    }
    
    return state
}

/// Typealias for a reusable reducer pattern used by feature modules.
public typealias AppFeatureReducer = (_ action: Action, _ state: AppState) -> AppState

/// Registry that holds all feature-specific reducers.
///
/// - Each feature appends its reducer into this list at setup time.
/// - Enables modular reducer architecture without central coupling.
public enum AppStateFeatureReducers {
    public static var all: [AppFeatureReducer] = []
}


/// Creates a reducer wrapper for a specific feature using a known state type.
///
/// - Parameters:
///   - key: The unique key for the feature state (e.g., `"events"`, `"ride"`).
///   - defaultState: The initial state if none exists in `AppState.featureStates`.
///   - reducer: The feature-specific reducer which transforms the local state.
/// - Returns: A reducer closure that can be injected into `AppStateFeatureReducers.all`.
public func createFeatureReducer<S>(
    key: String,
    defaultState: S,
    reducer: @escaping (Action, S) -> S
) -> AppFeatureReducer {
    
    return { action, appState in
        var newState = appState
        
        // Get the current feature state or use default
        let rawState = newState.featureStates[key] as? S ?? defaultState
        
        // Unwrap tracked actions for accurate reducer delegation
        let actualAction: Action
        if let tracked = action as? TrackedAction {
            actualAction = tracked.innerAction
        } else {
            actualAction = action
        }
        
        // Run the feature reducer and store updated state
        let updated = reducer(actualAction, rawState)
        newState.featureStates[key] = updated
        
        return newState
    }
}

