//
//  RidesService.swift
//  PickeMePassenger
//
//  Created by Bishan on 2025-06-22.
//

final class RidesService: RidesProtocol {
    
    func getRide() async throws -> Ride {
        let response: RideResponseDTO = rideResponseDTO
        return response.data.toRide()
    }
    
    func getRideDetails() async throws -> RideDetails {
        let response: RideDetailsResponseDTO = rideDetailsReponseDTO
        return response.data.toRideDetails()
    }

}
