//
//  BaseLoader.swift
//  PickeMePassenger
//
//  Created by Bishan on 2025-06-29.
//

import SwiftUI

/// A reusable loading indicator view with a customizable message.
/// Displays a spinner and a message centered in a semi-transparent black background.
public struct BaseLoader: View {
    
    /// The message shown below the loading spinner
    let message: String

    /// Initializes the loader with a custom message (defaults to "Loading...")
    public init(message: String = "Loading...") {
        self.message = message
    }

    public var body: some View {
        ZStack {
            VStack(spacing: 12) {
                
                // Circular spinner
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(1.5)
                    .frame(width: 200)
                
                // Loading message text
                Text(message)
                    .foregroundColor(.white)
                    .font(.caption)
            }
            .padding(24)
            .background(Color.black.opacity(0.7))
            .cornerRadius(12)
        }
    }
}
