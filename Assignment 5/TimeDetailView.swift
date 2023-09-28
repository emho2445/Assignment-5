//
//  TimeDetailView.swift
//  Assignment 5
//
//  Created by Emma  Hopson on 9/27/23.
//

import SwiftUI

struct LocationTimes: Codable {
    var results: SunDetails
    var status: String
}

struct SunDetails: Codable{
    var sunrise: String
    var sunset: String
    var solar_noon: String
    var day_length: String
    var civil_twilight_begin: String
    var civil_twilight_end: String
    var nautical_twilight_begin: String
    var nautical_twilight_end: String
    var astronomical_twilight_begin: String
    var astronomical_twilight_end: String
}

struct TimeDetailView: View {
    @State var suntimes:  LocationTimes?
    let latlng: [Double]
    
    func getSunTimes(lat: String, long: String) async -> () {
        do {
            let url = URL(string: "https://api.sunrise-sunset.org/json?lat=\(latlng[0])&lng=\(latlng[1])")!
            let (data, _) = try await URLSession.shared.data(from: url)
            print(data)
            suntimes = try JSONDecoder().decode(LocationTimes.self, from: data)
            
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    var body: some View {
            ZStack(content: {
                Image("Earth")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                Rectangle()
                    .colorInvert()
                    .frame(height: 300)
                    .opacity(0.70)
                VStack{
                    Text("Lat: \(latlng[0]), Long: \(latlng[1])")
                        .task {
                            await getSunTimes(lat: String(latlng[0]), long: String(latlng[1]))
                        }
                    if let existingSunTimes = suntimes{
                        Text("Sunrise: \(existingSunTimes.results.sunrise)")
                        Text("Sunset: \(existingSunTimes.results.sunset)")
                        Text("Solar Noon: \(existingSunTimes.results.solar_noon)")
                        Text("Day Length: \(existingSunTimes.results.day_length)")
                        Text("Civil Twilight Start: \(existingSunTimes.results.civil_twilight_begin)")
                        Text("Civil Twilight End: \(existingSunTimes.results.civil_twilight_end)")
                        Text("Nautical Twilight Start: \(existingSunTimes.results.nautical_twilight_begin)")
                        Text("Nautical Twilight End: \(existingSunTimes.results.nautical_twilight_end)")
                        Text("Astronomical Twilight Start: \(existingSunTimes.results.astronomical_twilight_begin)")
                        Text("Astronomical Twilight End: \(existingSunTimes.results.astronomical_twilight_end)")
                    }
                }

            })
            
        .navigationTitle("")
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        
        //.foregroundColor(.white)
    }
}

struct TimeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TimeDetailView(latlng: [0.00,0.00])
    }
}

