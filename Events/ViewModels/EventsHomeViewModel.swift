//
//  EventsHomeViewModel.swift
//  PickeMePassenger
//
//  Created by Bishan on 2025-06-29.
//

import Foundation
import Combine
import CoreArchitecture

public final class EventsHomeViewModel: BaseViewModel {
    
    public override init() {
        super.init()
    }

    public func loadNextPageIfNeeded(currentItem: Event? = nil) {
        if getEvents(appStore.state) == nil {
            dispatchOrReject(FetchEventsAction.request(page: 1))
            return
        }

        let pagination = getEventsPaination(appStore.state)
        let isFetching = getLoadingStatus(for: FetchEventsAction.self)

        guard
            let nextPage = pagination?.next,
            nextPage != 0,
            !isFetching
        else {
            return
        }

        if currentItem == nil || isLastItem(currentItem) {
            dispatchOrReject(FetchEventsAction.request(page: nextPage))
        }
    }

    private func isLastItem(_ item: Event?) -> Bool {
        guard let item = item else { return false }
        return getEventsList(appStore.state)?.last?.id == item.id
    }

    public override func onSuccess(state: AppState, action: Action?) -> Bool {
        guard let action = action else { return false }

        switch action {
        case is FetchEventsAction:
            break
        default:
            break
        }
        return true
    }
}

