
import SwiftUI

struct SaveBtn: View {
    let weather: Weather
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var city: City
    var body: some View {
        Button{
            city.add(weather)
            saveItemsToUserDefaults(weather: city.cities)
            withAnimation{
                self.presentationMode.wrappedValue.dismiss()
            }
        }label: {
            Text("Add")
                .foregroundColor(.white)
                .fontWeight(.bold)
                .frame(width: 60, height: 60)
        }
    }
    
    func saveItemsToUserDefaults(weather: [Weather]) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(weather)
            UserDefaults.standard.set(data, forKey: "weatherList")
        } catch {
            print("Error encoding items: \(error)")
        }
    }
    
}
