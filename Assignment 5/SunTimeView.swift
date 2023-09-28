//
//  SunTimeView.swift
//  Assignment 5
//
//  Created by Emma  Hopson on 9/27/23.
//

import SwiftUI


struct SunTimeView: View {
    @State var latitude: String = ""
    @State var longitude: String = ""
    @State var latlng: [Double] = [0.00, 0.00]
    
//    func convertToDouble(){
//        Double = [Double(latitude)!, Double(longitude)!]
//    }

    var body: some View {
            ZStack(content: {
                Image("Earth")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                Rectangle()
                    .colorInvert()
                    .frame(height: 400)
                    .opacity(0.70)
                
                VStack{
                    
                    Text("Enter a LATITUDE in the field below. This is a number between -90 and 90. You may include up to 4 decimal points")
                    TextField("Latitude", text: $latitude)
                    
                    Text("Enter a LONGITUDE in the field below. This is a number between -180 and 180. You may include up to 4 decimal points")
                    TextField("Longitude", text: $longitude)
                    
                    if longitude != "", latitude != "" {
                        NavigationLink(destination: TimeDetailView(latlng: [Double(latitude) ?? 0.00, Double(longitude) ?? 0.00])){
                            Text("Search Time Details ->")
                        }
                    }
                    Spacer()
                        .frame(height: 25.0)
                    
                    Button("Clear Fields"){
                        latitude = ""
                        longitude = ""
                    }
                    
                }
                .frame(minWidth: 300, idealWidth: 300, maxWidth: 300)
            })

        .navigationTitle("Set Location")
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        
        
        
    }
}

struct SunTimeView_Previews: PreviewProvider {
    static var previews: some View {
        SunTimeView()
    }
}
