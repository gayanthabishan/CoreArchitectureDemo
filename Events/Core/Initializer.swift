//
//  Initializer.swift
//  PickeMePassenger
//
//  Created by Bishan on 2025-06-24.
//

import CoreArchitecture

public enum EventsFeatureInitializer {
    @MainActor
    public static func register() {
        AppStateFeatureReducers.registerEvents()
        AppMiddlewares.registerEvents()
    }
}
