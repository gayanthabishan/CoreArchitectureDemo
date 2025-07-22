//
//  FetchRideDetailsAction.swift
//  PickeMePassenger
//
//  Created by Bishan on 2025-06-22.
//

import CoreArchitecture

enum FetchRideDetailsAction: BaseAction {
    case request(bookingId: String)
    case inProgress
    case perform(rideDetails: RideDetails)
    case success
    case failure(error: APIError)

    // MARK: boilerplate
    
    func getState() -> ActionStatus {
        switch self {
        case .request:
            return .INIT
        case .inProgress:
            return .IN_PROGRESS
        case .perform:
            return .IN_PROGRESS
        case .success:
            return .COMPLETED
        case .failure:
            return .ERROR
        }
    }
    
    func getError() -> APIError? {
        switch self {
        case .failure(let error):
            return error
        case .request, .inProgress, .perform, .success:
            return nil
        }
    }
    
    public func failureVersion(with error: APIError) -> Action? {
        return FetchRideAction.failure(error: error)
    }
}
