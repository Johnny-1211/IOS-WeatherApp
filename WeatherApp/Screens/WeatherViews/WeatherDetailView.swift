
import SwiftUI
import SpriteKit
struct WeatherDetailView: View {
    let selectedAddress: AddressResult
    var topEdge:CGFloat
    @State var offset : CGFloat = 0
    @Binding var isShowingWeatherSheetView : Bool
    @EnvironmentObject var locationHelper: LocationHelper
    @ObservedObject var weatherViewModel = WeatherViewModel()
    @EnvironmentObject var city: City
    @Binding var backgroundImage :String

    var body: some View {
        ZStack{
            if let selectedWeather = weatherViewModel.weather{
                GeometryReader{ proxy in
                    
                    Image(backgroundImage)
                        .resizable()
                        .ignoresSafeArea()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: proxy.size.width, height: proxy.size.height)

                }
                .ignoresSafeArea()
                
                if selectedWeather.currentConditions.conditions.hasPrefix("Rain"){
                    GeometryReader{_ in
                        SpriteView(scene: RainFall(), options: [.allowsTransparency])
                            .ignoresSafeArea()
                    }
                }else if selectedWeather.currentConditions.conditions.hasPrefix("Snow"){
                    GeometryReader{_ in
                        SpriteView(scene: RainFall(), options: [.allowsTransparency])
                            .ignoresSafeArea()
                    }
                }

            
            if isShowingWeatherSheetView{
                    VStack{
                        HStack{
                            CancelBtn()
                            Spacer()
                            SaveBtn(weather: selectedWeather)
                        }
                        .padding(.horizontal)
                        
                        ScrollView(.vertical, showsIndicators: false){
                            VStack{
                                WeatherSummaryView(weather: selectedWeather, opacity: getTitleOpacity())
                                    .offset(y:-offset)
                                    .offset(y: offset > 0 ? (offset / UIScreen.main.bounds.width) * 140 : 0)
                                    .offset(y: getTitleOffset())
                                HourlyScrollView(weather: selectedWeather)
                                DayForecast(weather: selectedWeather)
                                HStack{
                                    UVIndexView(weather: selectedWeather)
                                    FeelLikeView(weather: selectedWeather)
                                }
                                HStack{
                                    VisibilityView(weather: selectedWeather)
                                    HumidityView(weather: selectedWeather)
                                }
                            }
                            .padding(.top,45)
                            .padding(.top, topEdge)
                            .padding([.horizontal,.bottom])
                            .padding(.bottom, 20)
                            .overlay{
                                GeometryReader{ proxy -> Color in
                                    let minY = proxy.frame(in: .global).minY
                                    
                                    DispatchQueue.main.async{
                                        self.offset = minY
                                    }
                                    return Color.clear
                                }
                            }
                        }
                    }
                }
            }
        }
        .onAppear{
            Task{
                print("doForwardGeocoding on: \(selectedAddress)")
                await locationHelper.doForwardGeocoding(address: "\(selectedAddress.title)", completionHandler: { (location, error) in
                    if location == nil {
                        weatherViewModel.weather = nil
                    }else{
                        weatherViewModel.getWeather(location: locationHelper.searchLocation!)
                    }
                    
                })
                try await Task.sleep(nanoseconds: 30_000_000)
            }

        }
    }
    func getTitleOpacity() -> CGFloat{
        
        let titleOffset = -getTitleOffset()
        
        let progress = titleOffset / 20
        
        let opacity = 1 - progress
        
        return opacity
    }
    
    
    func getTitleOffset() -> CGFloat{
        if offset < 0 {
            let progress = -offset/140
            
            let newOffset = (progress <= 1.0 ? progress : 1) * 20
            return -newOffset
        }
        return 0
    }
    
//    func backgroundImage(selectedWeather:Weather) -> Image{
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "HH:mm:ss"
//        dateFormatter.timeZone = TimeZone(identifier: "\(selectedWeather.timezone)")
//
//        
//        if let date = dateFormatter.date(from: selectedWeather.currentConditions.datetime) {
//            var calendar = Calendar(identifier: .gregorian)
//            calendar.timeZone = dateFormatter.timeZone!
//            
//            let hour = calendar.component(.hour, from: date)
//            
//            if hour >= 17 || hour < 6 {
//                return Image("nightSky")
//            } else {
//                return Image("sunSky")
//            }
//        }else{
//            return Image("sunSky")
//        }
//    }
    
}

