//
//  LugarWorker.swift
//  Viajero
//
//  Created by Mikel Lopez on 30/08/2020.
//  Copyright © 2020 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

class LugarWorker: BaseWorker {
    
    func getLugares() async -> Bool {
        let lugaresCreateDate = Settings.shared.lugaresCreateDate?.toDate() ?? Date()
        if lugaresCreateDate > (Usuario.shared.ultimoIngreso?.toDate() ?? Date()) || !Lugares.shared.existsLugaresFile(){
            return await execute()
        } else {
            return Lugares.shared.getLugaresFromFile()
        }
    }
    
    func execute() async -> Bool {
        guard let lugaresURL = URL(string: "\(baseUrl)Lugares.json") else {
            return false
        }
        
        let session = getUrlSession()
        let request = generateRequest(url: lugaresURL, method: .get)
        
        guard let download = try? await session.download(for: request, delegate: self) else {
            return false
        }
        guard
            let data = try? Data(contentsOf: download.0),
            let lugaresModel = try? newJSONDecoder().decode([Lugar].self, from: data) else { return false }
        Lugares.shared.guardarLugares(lugares: lugaresModel)
        return true
    }
    
}

extension LugarWorker: URLSessionTaskDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("downloadFinished")
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        print("Progress: \(Double(totalBytesWritten)/Double(totalBytesExpectedToWrite))")
    }
    
}
