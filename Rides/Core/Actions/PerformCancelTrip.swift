//
//  PostCancelTrip.swift
//  PickeMePassenger
//
//  Created by Bishan on 2025-06-28.
//

import CoreArchitecture

// This is a fetchless action, therfore there is no request or error cases
enum ClearRideStateAction: BaseAction {
    case perform
    case success

    func getState() -> ActionStatus {
        .COMPLETED
    }

    static var autoSuccess: Action? {
        self.success
    }

    // Required explicitly due to protocol rules
    func getError() -> APIError? { nil }
}
