//
//  ViewModelHome.swift
//  PruebaTecnicaBimbo
//
//  Created by Omar Aldair on 31/05/23.
//

import Foundation
import Alamofire

class ViewModelHome {
    let userDefaults = UserDefaults.standard
    var refreshData = { () -> () in }
    
    var dataArray: [Mission] = [] {
        didSet {
            refreshData()
        }
    }
    
    func retrieveData() {
        if let lastTimeSavedData = userDefaults.value(forKey: "lastTimeSavedData") as? String {
            let today = Date().localDate(date: Date()).description.components(separatedBy: " ")[0]
            if lastTimeSavedData != today {
                // Obtener datos de nuevo porque es un nuevo día
                retrieveDataFromAPI()
            } else {
                // Obtener datos de la bd sin consumir de la API
                retrieveDataFromLocal()
            }
        } else {
            // No hay data guardada localmente
            retrieveDataFromAPI()
        }
        
    }
    
    func retrieveDataFromAPI() {
        let request = AF.request("https://api.spacexdata.com/v3/launches/past")
        request.responseDecodable(of: [Mission].self){(response) in
            guard let missions = response.value else { return }
            self.dataArray = missions
            // Guardar en local la data después de consumir API
            let encoder = JSONEncoder()
            do {
                let data = try encoder.encode(self.dataArray)
                self.userDefaults.set(data, forKey: "missions")
                self.userDefaults.set(Date().localDate(date: Date()).description.components(separatedBy: " ")[0], forKey: "lastTimeSavedData")
            } catch {
                print("Error d")
            }
        }
    }
    
    func retrieveDataFromLocal() {
        if let missionsData = userDefaults.data(forKey: "missions") {
            do {
                let decoder = JSONDecoder()
                let missions = try decoder.decode([Mission].self, from: missionsData)
                self.dataArray = missions
            } catch {
                print("Error decoding")
            }
        } else {
            retrieveDataFromAPI()
        }
    }
}
