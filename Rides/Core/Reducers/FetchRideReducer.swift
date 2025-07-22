//
//  RideReducer.swift
//  PickeMePassenger
//
//  Created by Bishan on 2025-06-22.
//

import CoreArchitecture

func rideReducer(action: Action, state: RideFeatureState) -> RideFeatureState {
    var state = state
    guard let rideAction = action as? FetchRideAction else { return state }
    
    switch rideAction {
        case .perform(let ride):
            state.ongoingRide = ride
            
        case .failure(let error):
            print(error)
            
        default:
            break
    }
    
    return state
}


