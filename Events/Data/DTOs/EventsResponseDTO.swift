//
//  EventDTO.swift
//  PickeMePassenger
//
//  Created by Bishan on 2025-06-24.
//

// MARK: EventDTO
struct EventDTO: Codable {
    let bannerImage: String
    let id: Int
    let minPrice: Double
    let name: String
    let startDate: String
    let venue: String
    
    enum CodingKeys: String, CodingKey {
        case bannerImage = "banner_image"
        case id = "id"
        case minPrice = "min_price"
        case name = "name"
        case startDate = "start_date"
        case venue = "venue"
    }
}

extension EventDTO {
    func toEvent() -> Event {
        return Event(
            bannerImage: bannerImage,
            id: id,
            minPrice: minPrice,
            name: name,
            startDate: startDate,
            venue: venue        )
    }
}

// MARK: EventsResponseDTO
struct EventsResponseDTO : Decodable {
    let data: [EventDTO]
    let pagination: Pagination
}

extension EventsResponseDTO {
    func toEventListPagingData() -> EventListPagingData {
        return EventListPagingData(
            events: data.map { $0.toEvent() },
            pagination: pagination.toPagination()
        )
    }
}

// MARK: Pagination
public struct Pagination: Codable {
    let previous: Int
    let next: Int
    let nbPages: Int

    enum CodingKeys: String, CodingKey {
        case previous
        case next
        case nbPages = "nb_pages"
    }
}

extension Pagination {
    func toPagination() -> Pagination {
        return Pagination(
            previous: nbPages,
            next: next,
            nbPages: previous
        )
    }
}
