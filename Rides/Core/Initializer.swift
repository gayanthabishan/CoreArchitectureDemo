//
//  Initializer.swift
//  PickeMePassenger
//
//  Created by Bishan on 2025-06-23.
//

import CoreArchitecture

public enum RidesFeatureInitializer {
    @MainActor
    public static func register() {
        AppStateFeatureReducers.registerRides()
        AppMiddlewares.registerRides()
    }
}
