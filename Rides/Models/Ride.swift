//
//  Ride.swift
//  PickeMePassenger
//
//  Created by Bishan on 2025-06-22.
//

public struct Ride {
    public let bookingId: Int
    public let pxId: Int
    public let createdAt: String
}

/// mock objects
let ride = RideDto(bookingId: 123, pxId: 001, createdAt: "2025-12-13T01:00:00Z")
let rideResponseDTO = RideResponseDTO(data: ride, error: nil)
