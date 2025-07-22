//
//  PerformEventsClearReducer.swift
//  PickeMePassenger
//
//  Created by Bishan on 2025-06-29.
//

import CoreArchitecture

func performEventsClearReducer(action: Action, state: EventsFeatureState) -> EventsFeatureState {
    var state = state
    guard let action = action as? PerformEventsClear else { return state }

    switch action {
    case .perform:
        state.events = nil
    default:
        break
    }

    return state
}
