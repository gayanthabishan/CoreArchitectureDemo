//
//  FetchEventsMiddleware.swift
//  PickeMePassenger
//
//  Created by Bishan on 2025-06-28.
//

import CoreArchitecture
import Foundation

@MainActor
let fetchEventsMiddleware: Middleware<AppState> = { dispatch, getState in
    return { next in
        return { action in
            
            if let tracked = action as? TrackedAction,
               let inner = tracked.innerAction as? FetchEventsAction {
                
                switch inner {
                case .request(let page):
                    Task {
                        do {
                            try? await Task.sleep(nanoseconds: 2_000_000_000)
                            
                            /// start data fetch
                            let eventsHomeRepository = EventsHomeRepository()
                            let eventListPagingData = try await eventsHomeRepository.fetchEventList(page: page)
                            
                            /// when fetch success, handover to reducer
                            dispatch(TrackedAction(
                                actionId: tracked.actionId,
                                innerAction: FetchEventsAction.perform(eventListPagingData: eventListPagingData)
                            ))
                            
                            dispatch(TrackedAction(
                                actionId: tracked.actionId,
                                innerAction: FetchEventsAction.success
                            ))
                        } catch {
                            dispatch(TrackedAction(
                                actionId: tracked.actionId,
                                innerAction: FetchEventsAction.failure(error: APIError(from: error))
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
