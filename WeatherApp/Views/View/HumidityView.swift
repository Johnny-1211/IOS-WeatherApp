import SwiftUI

struct HumidityView: View {
    let weather: Weather
    var body: some View {
        
        CustomStackView {
            Label{
                Text("HUMIDITY")

            } icon: {
                Image(systemName: "humidity.fill")

            }
        } contentView: {
            VStack(alignment:.leading, spacing: 10){
                Text("\(weather.currentConditions.humidity, specifier: "%.0f")%")
                    .font(.title)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Text("The dew point is \(weather.currentConditions.feelslike, specifier: "%.0f")º right now.")
                    .fontWeight(.semibold)
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

