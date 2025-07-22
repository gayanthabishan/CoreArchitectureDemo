//
//  RideDetails.swift
//  PickeMePassenger
//
//  Created by Bishan on 2025-06-22.
//

public struct RideDetails {
    public let bookingId: Int
    public let pxId: Int
    public let createdAt: String
    public let driverName: String
    public let vehicleNumber: String
}

/// mock object
let rideDetails = RideDetailsDto(bookingId: 123, pxId: 001, createdAt: "2025-12-13T01:00:00Z", driverName: "Indika Buddhika", vehicleNumber: "JM-1000")

let rideDetailsReponseDTO = RideDetailsResponseDTO(data: rideDetails, error: nil)
