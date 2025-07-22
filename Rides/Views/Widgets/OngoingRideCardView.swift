//
//  OngoingRideCardView.swift
//  PickeMePassenger
//
//  Created by Bishan on 2025-06-29.
//

import SwiftUI
import CoreArchitecture

public struct OngoingRideCardView: View {
    public init() {} // expose init

    public var body: some View {
        if let _ = getOngoingRide(appStore.state) {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Ongoing Ride")
                            .font(.headline)

                        Text("Booking ID: \(getOngoingRideBookingId(appStore.state))")
                            .font(.subheadline)

                        Text("Created At: \(getOngoingRideCreatedAt(appStore.state))")
                            .font(.subheadline)
                    }
                    Spacer()
                }

                Divider()

                VStack(alignment: .leading, spacing: 4) {
                    Text("Driver: \(getDriverName(appStore.state))")
                    Text("Vehicle: \(getVehicleNumber(appStore.state))")
                }
                .font(.footnote)
                .foregroundColor(.secondary)
            }
            .padding()
            .background(Color.blue.opacity(0.1))
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
        }
    }
}
