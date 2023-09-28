//
//  CountryView.swift
//  Assignment 5
//
//  Created by Emma  Hopson on 9/27/23.
//

import SwiftUI

struct Country: Codable, Identifiable {
    var id: Int { return UUID().hashValue }
    var name: CountryName
    var latlng: [Double]
}

struct CountryName: Codable {
    var common: String
    var official: String
}

struct CountryView: View {
    @State var countries =  [Country]()
    
    func getAllCountries() async -> () {
        do {
            let url = URL(string: "https://restcountries.com/v3.1/all")!
            let (data, _) = try await URLSession.shared.data(from: url)
            print(data)
            countries = try JSONDecoder().decode([Country].self, from: data)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    var body: some View {
            List(countries) { country in
                VStack(alignment: .leading) {
                    NavigationLink(destination: TimeDetailView(latlng: [country.latlng[0],country.latlng[1]])){
                        Text("\(country.name.common)")
                    }
                    //Text("\(country.latlng[0]) • \(country.latlng[1]) • \(country.name.common)")
                }
            }
            .task {
                await getAllCountries()
            }
        .navigationTitle("Country List")
    }
}

struct CountriesView_Previews: PreviewProvider {
    static var previews: some View {
        CountryView()
    }
}
