//
//  EventsState.swift
//  PickeMePassenger
//
//  Created by Bishan on 2025-06-28.
//

import CoreArchitecture

// events app state
public struct EventsFeatureState {
    public var events: EventListPagingData?
}

// projections
public let getEvents = { (state: AppState) -> EventListPagingData? in
    return state.eventsFeatureState.events ?? nil
}

public let getEventsList = { (state: AppState) -> [Event]? in
    return state.eventsFeatureState.events?.events ?? nil
}

public let getEventsPaination = { (state: AppState) -> Pagination? in
    return state.eventsFeatureState.events?.pagination ?? nil
}
