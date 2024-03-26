import SwiftUI

struct VisibilityView: View {
    let weather:Weather
    var body: some View {
        
        CustomStackView {
            Label{
                Text("VISIBILITY")
                
            } icon: {
                Image(systemName: "eye.fill")
                
            }
        } contentView: {
            VStack(alignment: .leading, spacing: 10){
                Text("\(weather.currentConditions.visibility, specifier: "%.0f") km")
                    .font(.title)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Text("Perfectly clear view.")
                    .fontWeight(.semibold)
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
            
        }
    }
}
