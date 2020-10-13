//
//  Lugar.swift
//  Viajero
//
//  Created by Mikel Lopez on 30/08/2020.
//  Copyright © 2020 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit


enum TipoLugar: String {
       case bajo = "pin_verde"
       case medio = "pin_azul"
       case alto = "pin_amarillo"
       case muyAlto = "pin_naranja"
       case patrimonio = "pin_rojo"
   
       func getImage() -> String{
           switch self {
           case .patrimonio:
               return "pin_rojo_image"
           case .muyAlto:
               return "pin_naranja_image"
           case .alto:
               return "pin_amarillo_image"
           case .medio:
               return "pin_azul_image"
           case .bajo:
               return "pin_verde_image"
           }
       }
   }

struct LugarModelo: Codable{
    var lugares: [Lugar]?
}

struct Lugar: Codable{
        var nombre: String?
        var latitud: String?
        var longitud: String?
        var descripcion: String?
        var puntos: Int?
        var _id: String?
        var categoria: String?
        var localidad: String?
        var provincia: String?
        var ccaa: String?
        var foto1: String?
        var foto2: String?
        var foto3: String?
        var interes: String?
    
    
    func getTipoLugar() -> TipoLugar{
        switch self.interes {
            case "BAJO","bajo","Bajo":
                return .bajo
            case "MEDIO","medio","Medio":
                return .medio
            case "ALTO","alto","Alto":
                return .alto
            case "MUYALTO", "MUY ALTO", "Muy alto", "muy alto", "Muyalto", "muyalto":
                return .muyAlto
            case "PATRIMONIO", "patrimonio", "Patrimonio":
                return .patrimonio
            default:
                return .bajo
        }
    }
    
    func getTipoLugarString() -> String{
        switch self.interes {
            case "BAJO","bajo","Bajo":
                return "BAJO"
            case "MEDIO","medio","Medio":
                return "MEDIO"
            case "ALTO","alto","Alto":
                return "ALTO"
            case "MUYALTO", "MUY ALTO", "Muy alto", "muy alto", "Muyalto", "muyalto":
                return "MUYALTO"
            case "PATRIMONIO", "patrimonio", "Patrimonio":
                return "PATRIMONIO"
            default:
                return "BAJO"
        }
    }
}

class Lugares{
    
    static var shared: Lugares = Lugares()
    
    var lugares: [Lugar] = []
    
    func guardarLugares(lugares: [Lugar]){
        self.lugares = lugares
    }
    
    func getLugares() -> [Lugar]{
        return self.lugares
    }
    
    
    
    func createGeoJSONFile(lugares: [Lugar]){
        
        
            let head = "{\"type\": \"FeatureCollection\",\"features\": ["
            var body = ""
            for (i,lugar) in lugares.enumerated(){
                //if i > 280 && i < 284 {
                body = body + "{\"type\":\"Feature\",\"properties\": { \"tipoLugar\": \"\(lugar.getTipoLugarString())\", \"nombre\":\"\(lugar.nombre?.replacingOccurrences(of: "\"", with: "") ?? "")\", \"puntos\": \"\(lugar.puntos ?? 0)\", \"foto\": \"\(lugar.foto1 ?? "")\", \"id\": \"\(lugar._id ?? "-1")\", \"visitado\":\"\(LugaresManager.shared.isLugarVisited(lugarId: lugar._id ?? "-1") ? "si" : "no")\"},\"geometry\":{\"type\":\"Point\",\"coordinates\": [ \(Double(lugar.longitud ?? "0.0") ?? 0.0),\(Double(lugar.latitud ?? "0.0") ?? 0.0)]}}"
                    if i != lugares.count - 1{body = body + ","}
                    //if i != 284 - 1{body = body + ","}
                //}
                
            }
            let tail = "]}"
            let geoJSONValue = "\(head)\(body)\(tail)"
        
            let filename = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("PrivateDocuments")
            do {
                try FileManager.default.createDirectory(at: filename,
                                                        withIntermediateDirectories: true,
                                                        attributes: nil)
            } catch {
                print("Couldn't create directory")
            }
            
            let dataURL = filename.appendingPathComponent("LugaresGJ" + ".geojson")
            
            do{ try geoJSONValue.write(to: dataURL, atomically: false, encoding: .utf8)}catch{return}
            
        }
        
        func readGeoJSONFile(){
            let documentsURL = try! FileManager().url(for: .documentDirectory,
                                                          in: .userDomainMask,
                                                          appropriateFor: nil,
                                                          create: true)
                
            let privateDoc = documentsURL.appendingPathComponent("PrivateDocuments")
            let fileData = privateDoc.appendingPathComponent("LugaresGJ" + ".geojson")
        
            if FileManager().fileExists(atPath: fileData.path) {
                    
                do {
                    let geojsonText = try String(contentsOf: fileData, encoding: .utf8)
                    print(geojsonText)
                }
                catch {/* error handling here */}
                
            }
        }
        
        func removeGeoJSONFile(){
            let documentsURL = try! FileManager().url(for: .documentDirectory,
                                                          in: .userDomainMask,
                                                          appropriateFor: nil,
                                                          create: true)
                
            let privateDoc = documentsURL.appendingPathComponent("PrivateDocuments")
            let fileData = privateDoc.appendingPathComponent("LugaresGJ" + ".geojson")
            
            do {
                try FileManager().removeItem(at: fileData)
            } catch{
                print("ERROR removing GEOJSON file")
            }
        }
        
        func existFileLugaresGJ() -> Bool {
            
            let documentsURL = try! FileManager().url(for: .documentDirectory,
                                                                  in: .userDomainMask,
                                                                  appropriateFor: nil,
                                                                  create: true)
                        
            let privateDoc = documentsURL.appendingPathComponent("PrivateDocuments")
            let fileData = privateDoc.appendingPathComponent("LugaresGJ" + ".geojson")
                    
            if FileManager().fileExists(atPath: fileData.path) {
                return true
            } else {
                return false
            }
        }
    
}



