//
//  PaginatedResponse.swift
//
//
//  Created by george.apostolakis on 10/02/25.
//

public struct PaginatedResponse<T: Decodable> {
    public var showContents: Int
    public var total: Int
    public var currentPage: Int
    public var itemsBeforeTheEndToReload: Int
    public var items: [T]

    public init(
        showContents: Int = 0,
        total: Int = 0,
        currentPage: Int = 1,
        itemsBeforeTheEndToReload: Int = 6,
        items: [T] = []
    ) {
        self.showContents = showContents
        self.total = total
        self.currentPage = currentPage
        self.itemsBeforeTheEndToReload = itemsBeforeTheEndToReload
        self.items = items
    }

    public func shouldRequestMoreItems(_ index: Int) -> Bool {
        let theFirstRequestIsAlreadyDisplayed = showContents > 0
        let hasReachedNearTheEndOfTheScroll = index == (showContents - itemsBeforeTheEndToReload)
        let hasMoreItems = showContents < total
        return theFirstRequestIsAlreadyDisplayed && hasReachedNearTheEndOfTheScroll && hasMoreItems
    }
}
