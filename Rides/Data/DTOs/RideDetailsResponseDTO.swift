//
//  RideDetailsResponseDTO.swift
//  PickeMePassenger
//
//  Created by Bishan on 2025-06-22.
//

struct RideDetailsResponseDTO: Codable {
    let data: RideDetailsDto
    let error: RideResponseErrorDTO?
}

struct RideDetailsDto: Codable {
    let bookingId: Int
    let pxId: Int
    let createdAt: String
    let driverName: String
    let vehicleNumber: String
    
    enum CodingKeys: String, CodingKey {
        case bookingId = "booking_id"
        case pxId = "px_id"
        case createdAt = "created_at"
        case driverName = "driver_name"
        case vehicleNumber = "vehicle_number"
    }
}

extension RideDetailsDto {
    func toRideDetails() -> RideDetails {
        return RideDetails(
            bookingId: bookingId,
            pxId: pxId,
            createdAt: createdAt,
            driverName: driverName,
            vehicleNumber: vehicleNumber)
    }
}
