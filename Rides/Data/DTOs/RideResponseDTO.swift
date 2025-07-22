//
//  RideDTO.swift
//  PickeMePassenger
//
//  Created by Bishan on 2025-06-22.
//

struct RideResponseDTO: Codable {
    let data: RideDto
    let error: RideResponseErrorDTO?
}

struct RideDto: Codable {
    let bookingId: Int
    let pxId: Int
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case bookingId = "booking_id"
        case pxId = "px_id"
        case createdAt = "created_at"
    }
}

struct RideResponseErrorDTO: Codable {
    let correlationId: String
    let code: String
    let message: String
    let developerMessage: String
    
    enum CodingKeys: String, CodingKey {
        case correlationId
        case code
        case message
        case developerMessage
    }
}

extension RideDto {
    func toRide() -> Ride {
        return Ride(
            bookingId: bookingId,
            pxId: pxId,
            createdAt: createdAt)
    }
}
