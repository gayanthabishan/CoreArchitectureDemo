//
//  AppStore.swift
//  PickeMePassenger
//
//  Created by Bishan on 2025-06-22.
//

import ReSwift

/// Global app store that holds the entire application state and manages all state updates.
/// This is the single source of truth for app-wide data in a Redux-style architecture.
public let appStore = Store<AppState>(
    
    /// Root reducer that coordinates child feature reducers and tracks action lifecycle
    reducer: appReducer,
    
    /// Initial state of the app; `nil` means the `AppState()` default initializer will be used
    state: nil,
    
    /// Middleware array to handle async actions or intercept side effects (e.g., logging, networking)
    middleware: AppMiddlewares.all
)

