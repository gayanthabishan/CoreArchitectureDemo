//
//  AppState.swift
//  PickeMePassenger
//
//  Created by Bishan on 2025-06-28.
//

import CoreArchitecture

// MARK: register your feature state into core architecture app state

public extension AppState {
    var eventsFeatureState: EventsFeatureState {
        get {
            featureStates["events"] as? EventsFeatureState ?? EventsFeatureState()
        }
        set {
            featureStates["events"] = newValue
        }
    }
}
