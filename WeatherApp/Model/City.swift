import SwiftUI

final class City: ObservableObject {
    
    @Published var cities: [Weather] = []
    
    func add(_ weather: Weather) {
        cities.append(weather)
    }
    
    
    func deleteItems(at offsets: IndexSet) {
        cities.remove(atOffsets: offsets)
    }
}
