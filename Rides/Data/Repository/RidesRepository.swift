//
//  RidesRepository.swift
//  PickeMePassenger
//
//  Created by Bishan on 2025-06-22.
//

import Foundation

class RidesRepository {
    private let ridesService: RidesProtocol
    
    init(ridesService: RidesProtocol = RidesService()) {
        self.ridesService = ridesService
    }
    
    func getRide() async throws -> Ride {
        return try await ridesService.getRide()
    }
    
    func getRideDetails() async throws -> RideDetails {
        return try await ridesService.getRideDetails()
    }
}
