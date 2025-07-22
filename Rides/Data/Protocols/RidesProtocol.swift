//
//  RidesProtocol.swift
//  PickeMePassenger
//
//  Created by Bishan on 2025-06-22.
//

protocol RidesProtocol {
    func getRide() async throws -> Ride
    func getRideDetails() async throws -> RideDetails
}
