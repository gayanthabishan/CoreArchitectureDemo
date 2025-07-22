//
//  FetchEventsAction.swift
//  PickeMePassenger
//
//  Created by Bishan on 2025-06-28.
//

import CoreArchitecture

enum FetchEventsAction: BaseAction {
    case request(page: Int)
    case perform(eventListPagingData: EventListPagingData)
    case success
    case failure(error: APIError)
    
    // MARK: boilerplate
    
    func getState() -> ActionStatus {
        switch self {
        case .request:
            return .INIT
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
        case .request, .perform, .success:
            return nil
        }
    }
    
    public func failureVersion(with error: APIError) -> Action? {
        return FetchEventsAction.failure(error: error)
    }
}
