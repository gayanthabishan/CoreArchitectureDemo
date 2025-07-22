//
//  RideState.swift
//  PickeMePassenger
//
//  Created by Bishan on 2025-06-22.
//

import CoreArchitecture
import Foundation

//MARK: ride app state
public struct RideFeatureState {
    public var ongoingRide: Ride?
    public var ongoingRideDetails: RideDetails?
}

//MARK: projections

/// ongoingRide projections
public let getOngoingRide = { (state: AppState) -> Ride? in
    return state.rideFeatureState.ongoingRide ?? nil
}

public let getOngoingRideBookingId = { (state: AppState) -> String in
    if let bookingId = getOngoingRide(state)?.bookingId {
        return String(bookingId)
    }
    return ""
}

public let getOngoingRideCreatedAt = { (state: AppState) -> String in
    if let createdAt = getOngoingRide(state)?.createdAt {
        return String(createdAt)
    }
    return ""
}

/// ongoingRideDetails projections
public let getOngoingRideDetails = { (state: AppState) -> RideDetails? in
    return state.rideFeatureState.ongoingRideDetails ?? nil
}

public let getDriverName = { (state: AppState) -> String in
    if let driverName = getOngoingRideDetails(state)?.driverName {
        return String(driverName)
    }
    return ""
}

public let getVehicleNumber = { (state: AppState) -> String in
    if let vehicleNumber = getOngoingRideDetails(state)?.vehicleNumber {
        return String(vehicleNumber)
    }
    return ""
}
