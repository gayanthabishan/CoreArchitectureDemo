//
//  FetchRideDetailsMiddleware.swift
//  PickeMePassenger
//
//  Created by Bishan on 2025-06-23.
//

import CoreArchitecture
import Foundation

@MainActor
let fetchRideDetailsMiddleware: Middleware<AppState> = { dispatch, getState in
    return { next in
        return { action in
            
            if let tracked = action as? TrackedAction,
               let inner = tracked.innerAction as? FetchRideDetailsAction {
                
                switch inner {
                case .request(let bookingId):
                    Task {
                        do {
                            /// action status changed to inprogress
                            dispatch(TrackedAction(
                                actionId: tracked.actionId,
                                innerAction: FetchRideDetailsAction.inProgress
                            ))
                            
                            /// start data fetch
                            let ridesRepository = RidesRepository()
                            let rideDetails = try await ridesRepository.getRideDetails()
                            
                            try? await Task.sleep(nanoseconds: 1_000_000_000)
                            
                            /// when fetch success, handover to reducer
                            dispatch(TrackedAction(
                                actionId: tracked.actionId,
                                innerAction: FetchRideDetailsAction.perform(rideDetails: rideDetails)
                            ))
                            
                            /// action status changed to success
                            dispatch(TrackedAction(
                                actionId: tracked.actionId,
                                innerAction: FetchRideDetailsAction.success
                            ))
                        } catch {
                            /// action status changed to fail
                            dispatch(TrackedAction(
                                actionId: tracked.actionId,
                                innerAction: FetchRideDetailsAction.failure(error: APIError(from: error))
                            ))
                        }
                    }
                    
                default: break
                }
            }
            
            /// Always forward the action to next middleware/reducer
            next(action)
        }
    }
}
