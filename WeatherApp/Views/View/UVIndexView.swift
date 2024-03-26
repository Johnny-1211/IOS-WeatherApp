import SwiftUI

struct UVIndexView: View {
    let weather : Weather
    var body: some View {
        
        CustomStackView {
            Label{
                Text("UV INDEX")
            } icon: {
                Image(systemName: "sun.max.fill")
            }
        } contentView: {
            VStack(alignment:.leading, spacing: 10){
                Text("\(weather.currentConditions.uvindex)")
                    .font(.title)
                    .fontWeight(.semibold)
                
                VStack{
                    switch weather.currentConditions.uvindex {
                    case let uv where uv <= 3:
                        Text("Low")
                    case let uv where uv <= 6:
                        Text("Moderate")
                    default:
                        Text("High")
                    }
                }
                .font(.title2)
                .fontWeight(.bold)
                
                Spacer()
                
                ProgressView(value: Double(weather.currentConditions.uvindex)/10)
                    .overlay(
                        LinearGradient(gradient: Gradient(colors: [.green,.yellow,.orange,.red,.purple]), startPoint: .leading, endPoint: .trailing))
                    .overlay(
                        GeometryReader { geometry in
                            let dotPosition = CGFloat(Double(weather.currentConditions.uvindex)/10) * geometry.size.width
                            ZStack{
                                Circle()
                                    .foregroundColor(.white)
                                    .frame(width: 6, height: 6)
                                Circle()
                                    .stroke(Color.black, lineWidth: 1)
                                    .frame(width: 6, height: 6)
                            }
                            .offset(x: dotPosition - 1, y: -1)
                        }
                    )
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
