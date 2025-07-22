//
//  RideViewModel.swift
//  PickeMePassenger
//
//  Created by Bishan on 2025-06-22.
//

import CoreArchitecture

class RideViewModel: BaseViewModel {

    override func onSuccess(state: AppState, action: Action?) -> Bool {
        guard let action = action else { return false }
        
        switch action {
        case is FetchRideAction:
            return true
        case is FetchRideDetailsAction:
            return true
        case is ClearRideStateAction:
            return true
        default:
            return false
        }
    }
    
    override func onError(error: APIError?, action: Action?) {
        guard let action = action else { return }
        
        switch action {
        case is FetchRideAction:
            break
        case is FetchRideDetailsAction:
            break
        default:
            break
        }
    }
    
}
