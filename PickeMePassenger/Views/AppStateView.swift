//
//  AppStateView.swift
//  PickeMePassenger
//
//  Created by Bishan on 2025-06-29.
//

import SwiftUI
import CoreArchitecture
import Events
import Rides

public struct AppStateView: View {

    public init() {}

    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                
                // MARK: - Ongoing Ride
                if !getOngoingRideBookingId(appStore.state).isEmpty {
                    Section(header: Text("Ongoing Ride").font(.title2.bold())) {
                        RideInfoRow(label: "Booking ID", value: getOngoingRideBookingId(appStore.state))
                        RideInfoRow(label: "Created At", value: getOngoingRideCreatedAt(appStore.state))
                        RideInfoRow(label: "Driver", value: getDriverName(appStore.state))
                        RideInfoRow(label: "Vehicle", value: getVehicleNumber(appStore.state))
                    }
                }

                // MARK: - Events
                if (getEventsList(appStore.state) != nil) {
                    Section(header: Text("Upcoming Events").font(.title2.bold())) {
                        ForEach(getEventsList(appStore.state) ?? [], id: \.id) { event in
                            VStack(alignment: .leading, spacing: 4) {
                                Text(event.name).font(.headline)
                                Text(event.startDate).font(.subheadline).foregroundColor(.secondary)
                                Text(event.venue).font(.subheadline).foregroundColor(.gray)
                                Divider()
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Central App State")
    }
}

private struct RideInfoRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text("\(label):").bold()
            Spacer()
            Text(value)
        }
        .padding(.vertical, 2)
    }
}
