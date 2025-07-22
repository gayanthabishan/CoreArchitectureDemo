//
//  Untitled.swift
//  PickeMePassenger
//
//  Created by Bishan on 2025-06-22.
//

import CoreArchitecture
import Foundation

@MainActor
let fetchRideMiddleware: Middleware<AppState> = { dispatch, getState in
    return { next in
        return { action in

            if let tracked = action as? TrackedAction,
               let inner = tracked.innerAction as? FetchRideAction {

                switch inner {
                case .request(let lat, let lng):
                    DispatchQueue.main.async {
                        Task {
                            do {
                                /// action status changed to inprogress
                                dispatch(TrackedAction(
                                    actionId: tracked.actionId,
                                    innerAction: FetchRideDetailsAction.inProgress
                                ))
                                
                                let ridesRepository = RidesRepository()
                                let ride = try await ridesRepository.getRide()

                                try? await Task.sleep(nanoseconds: 1_000_000_000)
                                
                                /// when fetch success, handover to reducer
                                dispatch(TrackedAction(
                                    actionId: tracked.actionId,
                                    innerAction: FetchRideAction.perform(ride: ride)
                                ))

                                /// action status changed to success
                                dispatch(TrackedAction(
                                    actionId: tracked.actionId,
                                    innerAction: FetchRideAction.success
                                ))
                            } catch {
                                /// action status changed to fail
                                dispatch(TrackedAction(
                                    actionId: tracked.actionId,
                                    innerAction: FetchRideAction.failure(error: APIError(from: error))
                                ))
                            }
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

