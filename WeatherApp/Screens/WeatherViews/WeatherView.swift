import SwiftUI
import SpriteKit

struct WeatherView: View {
    let selectedWeather : Weather
    
    @StateObject var weatherViewModel = WeatherViewModel()
    @EnvironmentObject var city:City
    @State var isShowingMap = false
    @State var currentWeatherCondition = ""
    @Binding var selectedTabIndex : Int
    
    @Binding var backgroundImage :String
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack(alignment:.bottom){
            
            GeometryReader{ proxy in
                
                Image(backgroundImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: proxy.size.width, height: proxy.size.height)
            }
            .ignoresSafeArea()
            
            if selectedWeather.currentConditions.conditions.contains("Rain"){
                GeometryReader{_ in
                    SpriteView(scene: RainFall(), options: [.allowsTransparency])
                        .ignoresSafeArea()
                }
            }else if selectedWeather.currentConditions.conditions.contains("Snow"){
                GeometryReader{_ in
                    SpriteView(scene: RainFall(), options: [.allowsTransparency])
                        .ignoresSafeArea()
                }
            }
            
            WeatherTabView(city: city, selectedTabIndex: $selectedTabIndex, currentWeatherCondition: $currentWeatherCondition, isShowingMap: $isShowingMap)
                .onChange(of: selectedTabIndex) { newIndex in
                    currentWeatherCondition = city.cities[newIndex].currentConditions.conditions
                }
        }
        .padding(.horizontal)
        .navigationBarBackButtonHidden(true)
        .safeAreaInset(edge: .bottom, content: {
            Color.clear
                .frame(height: 0)
                .background(.bar)
                .border(Color.black)
        })
        .alert(item: $weatherViewModel.alertItem) { alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: alertItem.dismissButton)
        }
        .onAppear{
            currentWeatherCondition = selectedWeather.currentConditions.conditions
        }
    }
    

    
}
