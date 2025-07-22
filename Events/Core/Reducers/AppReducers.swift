//
//  AppReducers.swift
//  PickeMePassenger
//
//  Created by Bishan on 2025-06-28.
//

import CoreArchitecture

extension AppStateFeatureReducers {
    @MainActor
    public static func registerEvents() {
        all.append(createFeatureReducer(
            key: "events",
            defaultState: EventsFeatureState(),
            reducer: eventsReducer
        ))
        all.append(createFeatureReducer(
            key: "events",
            defaultState: EventsFeatureState(),
            reducer: performEventsClearReducer
        ))
    }
}
