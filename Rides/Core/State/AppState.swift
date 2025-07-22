//
//  AppState.swift
//  PickeMePassenger
//
//  Created by Bishan on 2025-06-23.
//

import CoreArchitecture

// MARK: register your feature state into core architecture app state

public extension AppState {
    var rideFeatureState: RideFeatureState {
        get {
            featureStates["ride"] as? RideFeatureState ?? RideFeatureState()
        }
        set {
            featureStates["ride"] = newValue
        }
    }
}
