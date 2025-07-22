//
//  PerformCancelTripReducer.swift
//  PickeMePassenger
//
//  Created by Bishan on 2025-06-28.
//

import CoreArchitecture

func ClearRideStateReducer(action: Action, state: RideFeatureState) -> RideFeatureState {
    var state = state
    guard let action = action as? ClearRideStateAction else { return state }

    switch action {
    case .perform:
        state.ongoingRide = nil
        state.ongoingRideDetails = nil
    default:
        break
    }

    return state
}
