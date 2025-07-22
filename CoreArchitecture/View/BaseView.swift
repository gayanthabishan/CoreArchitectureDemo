//
//  BaseView.swift
//  PickeMePassenger
//
//  Created by Bishan on 2025-06-29.
//

import SwiftUI

// MARK: - View Extension for Automatic State Observation

public extension View {
    /// Automatically observes state updates from a BaseViewModel without modifying the main view hierarchy.
    ///
    /// This is useful when you want a SwiftUI View to re-render in response to changes
    /// in an ObservableObject-based view model (like BaseViewModel), without explicitly
    /// referencing its properties inside the main body.
    ///
    /// - Parameter viewModel: A subclass of BaseViewModel conforming to ObservableObject.
    /// - Returns: The original view with an invisible observer attached in the background.
    func observes<ViewModel: BaseViewModel>(_ viewModel: ViewModel) -> some View {
        self.background(ObserverView(viewModel: viewModel))
    }
}

// MARK: - Internal Observer View

/// A helper view that binds to a BaseViewModel to trigger updates in parent views.
///
/// This invisible view does nothing visually, but because it uses `@ObservedObject`
/// on the BaseViewModel, it ensures the surrounding SwiftUI view hierarchy re-renders
/// when any `@Published` property inside the view model changes.
private struct ObserverView<ViewModel: BaseViewModel>: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        EmptyView() // This view is invisible but reactive
    }
}

