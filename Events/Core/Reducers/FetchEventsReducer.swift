//
//  FetchEventsReducer.swift
//  PickeMePassenger
//
//  Created by Bishan on 2025-06-28.
//

import CoreArchitecture

func eventsReducer(action: Action, state: EventsFeatureState) -> EventsFeatureState {
    var state = state
    guard let eventsAction = action as? FetchEventsAction else {
        return state
    }
    
    switch eventsAction {
        
    case .perform(let newPagingData):
        // If events already exist, merge with new ones
        if let currentData = state.events {
            
            // Extract existing IDs to avoid duplicates
            let existingIds = Set(currentData.events.map(\.id))
            
            // Filter out duplicates from incoming events
            let newEvents = newPagingData.events.filter { !existingIds.contains($0.id) }
            
            // Combine existing and new events
            let combinedEvents = currentData.events + newEvents
            
            // Update pagination
            let updatedPagination: Pagination = {
                // Stop pagination if no new events came and pagination is same
                if newEvents.isEmpty &&
                    newPagingData.pagination.next == currentData.pagination.next {
                    return Pagination(
                        previous: currentData.pagination.previous,
                        next: 0, // no more pages to load
                        nbPages: currentData.pagination.nbPages
                    )
                } else {
                    return newPagingData.pagination
                }
            }()
            
            // Update state with merged data
            state.events = EventListPagingData(
                events: combinedEvents,
                pagination: updatedPagination
            )
            
        } else {
            // First time loading events
            state.events = newPagingData
        }
        
    case .failure(let error):
        // Handle errors (you may log or track this in production)
        print("FetchEventsAction failed with error:", error)
        
    default:
        break
    }
    
    return state
}

