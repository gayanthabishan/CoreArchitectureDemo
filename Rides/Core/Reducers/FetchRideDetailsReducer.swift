//
//  FetchRideDetailsReducer.swift
//  PickeMePassenger
//
//  Created by Bishan on 2025-06-23.
//

import CoreArchitecture

func FetchRideDetailsReducer(action: Action, state: RideFeatureState) -> RideFeatureState {
    var state = state
    guard let rideDetailsAction = action as? FetchRideDetailsAction else { return state }
    
    switch rideDetailsAction {
        case .perform(let rideDetails):
            state.ongoingRideDetails = rideDetails
            
        case .failure(let error):
            print(error)
            
        default:
            break
    }
    
    return state
}
