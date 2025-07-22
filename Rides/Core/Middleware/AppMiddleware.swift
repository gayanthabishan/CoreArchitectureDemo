//
//  AppMiddleware.swift
//  PickeMePassenger
//
//  Created by Bishan on 2025-06-23.
//

import CoreArchitecture

extension AppMiddlewares {
    @MainActor
    public static func registerRides() {
        all.append(fetchRideMiddleware)
        all.append(fetchRideDetailsMiddleware)
    }
}
