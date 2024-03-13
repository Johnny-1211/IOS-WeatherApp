//
//  MapService.swift
//  WeatherApp
//
//  Created by Johnny Tam on 10/3/2024.
//

import Foundation
import Combine
import MapKit

class LocationSearchService: NSObject, ObservableObject {

    enum LocationStatus: Equatable {
        case idle
        case noResults
        case isSearching
        case error(String)
        case result
    }

    @Published var queryFragment: String = ""
    @Published private(set) var status: LocationStatus = .idle
    @Published private(set) var searchResults: [MKLocalSearchCompletion] = []

    private var queryCancellable: AnyCancellable?
    private let searchCompleter: MKLocalSearchCompleter!

    init(searchCompleter: MKLocalSearchCompleter = MKLocalSearchCompleter()) {
        self.searchCompleter = searchCompleter
        super.init()
        self.searchCompleter.delegate = self

        queryCancellable = $queryFragment
            .receive(on: DispatchQueue.main)
            .debounce(for: .milliseconds(100), scheduler: RunLoop.main, options: nil)
            .sink(receiveValue: { fragment in
                self.status = .isSearching
                if !fragment.isEmpty {
                    self.searchCompleter.queryFragment = fragment
                } else {
                    self.status = .idle
                    self.searchResults = []
                }
        })
    }
}

extension LocationSearchService: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.searchResults = completer.results.filter({ $0.subtitle == "" })
        self.status = completer.results.isEmpty ? .noResults : .result
    }

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        self.status = .error(error.localizedDescription)
    }
}
