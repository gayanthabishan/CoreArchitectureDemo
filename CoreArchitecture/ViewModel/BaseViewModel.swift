//
//  BaseViewModel.swift
//  PickeMePassenger
//
//  Created by Bishan on 2025-06-22.
//

import Foundation
import ReSwift
import Combine

open class BaseViewModel: ObservableObject, StoreSubscriber {
    
    @Published public var isLoading: Bool = false
    @Published private var actionStatusMap: [String: ActionStatus] = [:]
    
    /// Forces UI updates when any status changes
    @Published public var loadingTrigger: Bool = false
    
    /// Tracks the action IDs currently in progress
    private var actionIds: Set<String> = []
    
    public init() {
        appStore.subscribe(self)
    }
    
    deinit {
        appStore.unsubscribe(self)
    }
    
    // MARK: - StoreSubscriber
    
    open func newState(state: AppState) {
        var stillLoading = false
        var updatedStatusMap: [String: ActionStatus] = [:]
        
        for id in actionIds {
            guard let action = state.actionTracker[id] else { continue }
            
            let typeKey = String(describing: type(of: action))
            updatedStatusMap[typeKey] = action.getState()
            
            switch action.getState() {
            case .COMPLETED:
                if onSuccess(state: state, action: action) {
                    cleanup(id: id)
                }
                
                // Dispatch autoSuccess if declared for fetchless actions
                if let baseAction = action as? BaseAction,
                   let autoSuccess = type(of: baseAction).autoSuccess {
                    appStore.dispatch(autoSuccess)
                }
            case .ERROR:
                onError(error: action.getError(), action: action)
                cleanup(id: id)
            default:
                stillLoading = true
            }
        }
        
        DispatchQueue.main.async {
            self.isLoading = stillLoading
            self.actionStatusMap = updatedStatusMap
            self.loadingTrigger.toggle() // This will trigger SwiftUI to update
        }
    }
    
    // MARK: - Dispatch
    
    public func dispatchOrReject(_ action: Action) {
        for id in actionIds {
            if let existing = appStore.state.actionTracker[id],
               existing.isSameType(as: action) {
                
                print("Error: dispatching two identical calls is prohibited → \(type(of: action))")
                
                if let base = action as? BaseAction,
                   let failure = base.failureVersion(with: .rejected(reason: "Duplicate call")) {
                    
                    let id = UUID().uuidString
                    actionIds.insert(id)
                    
                    appStore.dispatch(TrackedAction(
                        actionId: id,
                        innerAction: failure
                    ))
                }
                
                return
            }
        }
        dispatchAction(action)
    }
    
    func dispatchAction(_ action: Action) {
        let id = UUID().uuidString
        actionIds.insert(id)
        isLoading = true
        appStore.dispatch(TrackedAction(actionId: id, innerAction: action))
    }
    
    // MARK: - Cleanup
    
    private func cleanup(id: String) {
        actionIds.remove(id)
        appStore.dispatch(RemoveStateStatus.perform(actionId: id))
    }
    
    // MARK: action handling
    
    public func getStatus(for type: Action.Type) -> ActionStatus {
        let key = String(describing: type)
        return actionStatusMap[key] ?? .INIT
    }
    
    public func isAction(_ status: ActionStatus, for type: Action.Type) -> Bool {
        getStatus(for: type) == status
    }
    
    // MARK: - Overridable Hooks
    
    /// Called when an action completes successfully.
    open func onSuccess(state: AppState, action: Action?) -> Bool {
        return true
    }
    
    /// Called when an action fails.
    open func onError(error: APIError?, action: Action?) {}
    
    // MARK: - Available projections for actions
    
    /// Check action status
    public func status(for actionId: String) -> ActionStatus {
        appStore.state.actionTracker[actionId]?.getState() ?? .INIT
    }
    
    /// Checks any status for multiple actions
    /// viewModel.isAnyAction(.INIT, for: [ActionA.self, ActionB.self])
    public func isAnyAction(_ status: ActionStatus, for types: [Action.Type]) -> Bool {
        types.contains { type in
            getStatus(for: type) == status
        }
    }
    
    /// Returns the loading status of an action for loaders
    public func getLoadingStatus<T: Action>(for type: T.Type) -> Bool {
        let key = String(describing: type)
        let status = actionStatusMap[key]
        return (status == .IN_PROGRESS || status == .INIT) ? true : false
    }

}
