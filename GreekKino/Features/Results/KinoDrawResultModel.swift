//
//  KinoDrawResultModel.swift
//  GreekKino
//
//  Created by Miroljub Stoilkovic on 26.5.24..
//

import Foundation

struct KinoDrawResults: Decodable {
    let content: [KinoDrawResult]
}

struct KinoDrawResult: Decodable {
    let drawId: Int
    let drawTime: Int
    let status: DrawStatus
    let winningNumbers: WinningNumbers
    
    var formattedTime: String {
        let drawDate = Date(timeIntervalSince1970: Double(drawTime/1000))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM HH:mm"
        return dateFormatter.string(from: drawDate)
    }
}

struct WinningNumbers: Decodable {
    let list:[Int]
}
