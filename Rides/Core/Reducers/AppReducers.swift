//
//  AppReducers.swift
//  PickeMePassenger
//
//  Created by Bishan on 2025-06-23.
//

import CoreArchitecture

extension AppStateFeatureReducers {
    @MainActor
    public static func registerRides() {
        all.append(createFeatureReducer(
            key: "ride",
            defaultState: RideFeatureState(),
            reducer: rideReducer
        ))
        
        all.append(createFeatureReducer(
            key: "ride",
            defaultState: RideFeatureState(),
            reducer: FetchRideDetailsReducer
        ))
        
        all.append(createFeatureReducer(
            key: "ride",
            defaultState: RideFeatureState(),
            reducer: ClearRideStateReducer
        ))
    }
}
