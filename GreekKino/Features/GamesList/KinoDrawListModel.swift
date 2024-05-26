//
//  KinoDrawListModel.swift
//  GreekKino
//
//  Created by Miroljub Stoilkovic on 26.5.24..
//

import Foundation

struct KinoDraw: Decodable, Hashable {

    let gameId: Int
    let drawId: Int
    let drawTime: Int
    let status: DrawStatus
    
    var formattedTime: String {
        let drawDate = Date(timeIntervalSince1970: Double(drawTime/1000))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: drawDate)
    }
    
    var remainingTime: String {
        let drawDate = Date(timeIntervalSince1970: Double(drawTime/1000))
        let diffComponents = Calendar.current.dateComponents([.hour, .minute], from: Date.now, to: drawDate)
        guard let hours = diffComponents.hour,
              let minutes = diffComponents.minute else {
            return ""
        }

        let hoursString = String(format: "%02d", hours)
        let minutesString = String(format: "%02d", minutes)
        return "\(hoursString):\(minutesString)"
    }
    
     var remainingSeconds: Double {
        let drawDate = Date(timeIntervalSince1970: Double(drawTime/1000))
        return drawDate.timeIntervalSinceNow
    }
}

enum DrawStatus: String, Decodable {
    case active
    case future
    case results
}
