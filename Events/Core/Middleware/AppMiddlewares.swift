//
//  AppMiddlewares.swift
//  PickeMePassenger
//
//  Created by Bishan on 2025-06-28.
//

import CoreArchitecture

extension AppMiddlewares {
    @MainActor
    public static func registerEvents() {
        all.append(fetchEventsMiddleware)
    }
}
