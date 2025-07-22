//
//  SideEffectMiddleware.swift
//  PickeMePassenger
//
//  Created by Bishan on 2025-06-22.
//

import ReSwift

/// A protocol for defining asynchronous Redux actions.
///
/// - Conforming types can execute async logic (e.g., API calls),
///   and dispatch results (like `.success`, `.failure`, etc.) back to the store.
public protocol AsyncAction: Action {
    /// Executes the async logic associated with this action.
    ///
    /// - Parameters:
    ///   - dispatch: A function used to dispatch new actions into the store.
    ///   - getState: A function to retrieve the latest `AppState`.
    func execute(dispatch: @escaping DispatchFunction, getState: @escaping () -> AppState?)
}

/// A generic middleware that intercepts actions conforming to `AsyncAction`
/// and executes their asynchronous logic. All other actions are passed through.
///
/// - Returns: A middleware compatible with the `Store` instance.
public func middleware() -> Middleware<AppState> {
    return { dispatch, getState in
        return { next in
            return { action in
                if let asyncAction = action as? AsyncAction {
                    // Intercept AsyncAction and execute custom logic
                    asyncAction.execute(dispatch: dispatch, getState: getState)
                } else {
                    // Forward all other actions to the next middleware/reducer
                    next(action)
                }
            }
        }
    }
}

/// A centralized registry of middlewares used by the `Store`.
/// Extend this array to include other middlewares like analytics, logging, etc.
public enum AppMiddlewares {
    public static var all: [Middleware<AppState>] = [
        middleware() // Handles all `AsyncAction` conforming actions
    ]
}

