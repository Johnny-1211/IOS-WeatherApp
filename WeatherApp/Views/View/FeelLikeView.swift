import SwiftUI

struct FeelLikeView: View {
    let weather:Weather
    var body: some View {
        
        CustomStackView {
            Label{
                Text("FEELS LIKE")
            } icon: {
                Image(systemName: "thermometer.medium")
            }
        } contentView: {
            VStack(alignment:.leading, spacing: 10){
                Text("\(weather.currentConditions.feelslike, specifier: "%.0f")º")
                    .font(.title)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Text("Wind is making it feel colder.")
                    .fontWeight(.semibold)
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}


