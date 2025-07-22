//
//  Event.swift
//  PickeMePassenger
//
//  Created by Bishan on 2025-06-24.
//

public struct Event {
    public let bannerImage: String
    public let id: Int
    public let minPrice: Double
    public let name: String
    public let startDate: String
    public let venue: String
}

public struct EventListPagingData {
    public var events: [Event]
    var pagination: Pagination
}
