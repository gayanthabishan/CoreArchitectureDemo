//
//  EventsHomeRepository.swift
//  PickeMePassenger
//
//  Created by Bishan on 2025-06-28.
//

import Foundation

class EventsHomeRepository {
    private let eventsService: EventsProtocol
    
    init(eventsService: EventsProtocol = EventsService()) {
        self.eventsService = eventsService
    }
    
    func fetchEventList(page: Int) async throws -> EventListPagingData {
        return try await eventsService.fetchEvents(page: page)
    }
}
