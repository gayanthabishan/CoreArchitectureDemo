//
//  EventsHomeView.swift
//  PickeMePassenger
//
//  Created by Bishan on 2025-06-29.
//

import SwiftUI
import CoreArchitecture
import Rides

public struct EventsHomeView: View {
    @StateObject private var viewModel: EventsHomeViewModel
    
    public init() {
        _viewModel = StateObject(wrappedValue: EventsHomeViewModel())
    }
    
    public var body: some View {
        ZStack {
            ScrollView {
                OngoingRideCardView()
                
                LazyVStack(spacing: 16) {
                    ForEach(getEventsList(appStore.state) ?? [], id: \.id) { event in
                        EventRowView(event: event)
                            .onAppear {
                                let lastId = getEventsList(appStore.state)?.last?.id ?? -1
                                
                                if event.id == lastId {
                                    viewModel.loadNextPageIfNeeded(currentItem: event)
                                }
                            }
                    }
                }
                .padding()
            }
            .navigationTitle("Events")
            
            if viewModel.getLoadingStatus(for: FetchEventsAction.self) {
                BaseLoader(message: "loading events")
            }
        }
        .onAppear {
            viewModel.loadNextPageIfNeeded()
        }
        .onDisappear{
            //viewModel.dispatchOrReject(PerformEventsClear.perform)
        }
        .observes(viewModel)
    }
}

struct EventRowView: View {
    let event: Event
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Rectangle()
                .fill(Color.random)
                .frame(height: 200)
                .overlay(
                    Text("")
                        .foregroundColor(.white)
                )
                .cornerRadius(10)
            
            Text(event.name)
                .font(.headline)
            
            Text(event.startDate)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text(event.venue)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}

private extension Color {
    static var random: Color {
        let colors: [Color] = [.red, .blue, .green, .orange, .purple, .pink, .yellow]
        return colors.randomElement() ?? .gray
    }
}
