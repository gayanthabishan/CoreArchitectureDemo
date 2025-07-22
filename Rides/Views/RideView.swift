//
//  RideView.swift
//  PickeMePassenger
//
//  Created by Bishan on 2025-06-23.
//

import SwiftUI
import CoreArchitecture

public struct RideView: View {
    @StateObject private var viewModel: RideViewModel
    
    public init() {
        _viewModel = StateObject(wrappedValue: RideViewModel())
    }
    
    public var body: some View {
        ZStack {
            Color(red: 0.98, green: 0.83, blue: 0.46)
                .ignoresSafeArea()

            VStack(spacing: 24) {
                VStack(alignment: .leading, spacing: 12) {
                    // 1. No ride → Show "Get a Ride"
                    if getOngoingRide(appStore.state) == nil {
                        Button("Get a Ride") {
                            viewModel.dispatchOrReject(FetchRideAction.request(lat: "6.9271", lng: "79.8612"))
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    
                    // 2. Ride exists, no details → Show booking info + "Get Ride Details"
                    else if getOngoingRideDetails(appStore.state) == nil {
                        HStack {
                            Text("Booking Id:").bold()
                            Spacer()
                            Text(getOngoingRideBookingId(appStore.state))
                        }
                        
                        HStack {
                            Text("Accepted At:").bold()
                            Spacer()
                            Text(getOngoingRideCreatedAt(appStore.state))
                        }
                        
                        Button("Get Ride Details") {
                            viewModel.dispatchOrReject(FetchRideDetailsAction.request(
                                bookingId: getOngoingRideBookingId(appStore.state)))
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    
                    // 3. Ride and details exist → Show full info + "Cancel Trip"
                    else {
                        HStack {
                            Text("Driver Name:").bold()
                            Spacer()
                            Text(getDriverName(appStore.state))
                        }
                        
                        HStack {
                            Text("Vehicle Number:").bold()
                            Spacer()
                            Text(getVehicleNumber(appStore.state))
                        }
                        
                        Button("Cancel Trip") {
                            viewModel.dispatchOrReject(ClearRideStateAction.perform)
                        }
                        .buttonStyle(.bordered)
                        .foregroundColor(.red)
                    }
                }
                .padding()
                .cornerRadius(12)
            }
            .padding()

            if viewModel.getLoadingStatus(for: FetchRideAction.self) ||
                viewModel.getLoadingStatus(for: FetchRideDetailsAction.self) {
                BaseLoader(message: "fetching data")
            }
        }
        .observes(viewModel)
    }
}

#Preview {
    RideView()
}
