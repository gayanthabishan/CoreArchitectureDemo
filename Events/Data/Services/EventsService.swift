//
//  EventService.swift
//  PickeMePassenger
//
//  Created by Bishan on 2025-06-24.
//

import Foundation

final class EventsService: EventsProtocol {
    
    private let itemsPerPage = 10

    func fetchEvents(page: Int) async throws -> EventListPagingData {
        // Load the JSON file from the bundle
        guard let url = Bundle.main.url(forResource: "event_data", withExtension: "json") else {
            throw NSError(
                domain: "EventsService",
                code: 1,
                userInfo: [NSLocalizedDescriptionKey: "event_data.json not found in bundle"]
            )
        }

        // Decode the JSON into DTO structure
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let response = try decoder.decode(EventsResponseDTO.self, from: data)

        // Total items and pages for pagination logic
        let totalItems = response.data.count
        let totalPages = Int(ceil(Double(totalItems) / Double(itemsPerPage)))

        // Calculate index range for the current page
        let startIndex = (page - 1) * itemsPerPage
        let endIndex = min(startIndex + itemsPerPage, totalItems)

        // If page is out of range, return empty with updated pagination
        guard startIndex < endIndex else {
            return EventListPagingData(
                events: [],
                pagination: Pagination(
                    previous: max(page - 1, 0), // previous page
                    next: 0,                    // no more pages to fetch
                    nbPages: totalPages
                )
            )
        }

        // Slice the data for current page
        let pageItems = response.data[startIndex..<endIndex]

        // Map DTOs to domain models
        let eventsList = pageItems.map { $0.toEvent() }

        // Construct accurate pagination info for the current response
        let pagination = Pagination(
            previous: page > 1 ? page - 1 : 0,
            next: endIndex < totalItems ? page + 1 : 0,
            nbPages: totalPages
        )

        // Return final paging data
        return EventListPagingData(events: eventsList, pagination: pagination)
    }
    
}
