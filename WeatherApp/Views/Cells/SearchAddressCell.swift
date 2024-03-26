import SwiftUI

struct SearchAddressCell: View {
    @State var isShowingWeatherSheetView :Bool = false
    let address: AddressResult
    @Binding var backgroundImage :String

    
    var body: some View {
            Button {
                isShowingWeatherSheetView = true
                 
            } label: {
                VStack(alignment: .leading) {
                    Text(address.title)
                    Text(address.subtitle)
                        .font(.caption)
                }
            }
            .sheet(isPresented: $isShowingWeatherSheetView){
                let topEdge = UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
                WeatherDetailView(selectedAddress: address, topEdge: topEdge, isShowingWeatherSheetView: $isShowingWeatherSheetView, backgroundImage: $backgroundImage)
            }
            .padding(.bottom, 2)
    }
}

