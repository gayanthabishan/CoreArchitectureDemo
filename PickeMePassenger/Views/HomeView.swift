//
//  HomeViews.swift
//  PickeMePassenger
//
//  Created by Bishan on 2025-06-29.
//

import SwiftUI
import CoreArchitecture
import Rides
import Events

struct HomeView: View {
    @StateObject private var stateObserver = AppStateObserver(store: appStore)

    private var rideAvailable: Bool {
        getOngoingRide(appStore.state) != nil
    }

    private var eventsCount: Int {
        getEventsList(appStore.state)?.count ?? 0
    }

    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    NavigationLink(destination: AppStateView()) {
                        BigButton(title: "State", showBadge: false, badgeCount: 0)
                    }

                    NavigationLink(destination: RideView()) {
                        BigButton(title: "Ride", showBadge: rideAvailable, badgeCount: 1)
                    }

                    NavigationLink(destination: EventsHomeView()) {
                        BigButton(title: "Events", showBadge: eventsCount > 0, badgeCount: eventsCount)
                    }
                }
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red: 0.98, green: 0.83, blue: 0.46))
            .navigationTitle("PickMe")
        }
    }
}

// MARK: - Reusable Big Button

struct BigButton: View {
    let title: String
    var showBadge: Bool = false
    var badgeCount: Int = 0
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            // Main Button Look
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(red: 0.94, green: 0.94, blue: 0.94))
                .frame(maxWidth: 200, minHeight: 100)
                .overlay(
                    Text(title)
                        .font(.title2.bold())
                        .foregroundColor(.black)
                )
                .padding(.horizontal)
            
            // Notification Badge
            if showBadge && badgeCount > 0 {
                Text("\(badgeCount)")
                    .font(.caption2.bold())
                    .foregroundColor(.white)
                    .padding(6)
                    .background(Color.red)
                    .clipShape(Circle())
                    .offset(x: 12, y: -12)
            }
        }
    }
}
