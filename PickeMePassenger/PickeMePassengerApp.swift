//
//  PickeMePassengerApp.swift
//  PickeMePassenger
//
//  Created by Bishan on 2025-06-22.
//

import SwiftUI
import Rides
import Events

@main
struct PickeMePassengerApp: App {
    
    // regitser verticals
    init() {
        RidesFeatureInitializer.register()
        EventsFeatureInitializer.register()
    }

    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
    
}
