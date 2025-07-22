//
//  EventsProtocol.swift
//  PickeMePassenger
//
//  Created by Bishan on 2025-06-24.
//

protocol EventsProtocol {
    func fetchEvents(page: Int) async throws -> EventListPagingData
}
