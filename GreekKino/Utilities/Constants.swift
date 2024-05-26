//
//  Constants.swift
//  GreekKino
//
//  Created by Miroljub Stoilkovic on 25.5.24..
//

import SwiftUI

enum Constants {

    struct Network {
        static let getUpcomingDrawListURL = "https://api.opap.gr/draws/v3.0/1100/upcoming/20"
        static let liveDrawURL = "https://www.mozzartbet.com/sr/lotto-animation/26#/"
        static let getDrawURL = "https://api.opap.gr/draws/v3.0/{gameId}/{drawId}"
        static let getDrawResultsURL = "https://api.opap.gr/draws/v3.0/{gameId}/draw-date/{fromDate}/{toDate}"
    }
    
    struct Colors {
        static let primary = Color(red: 243/255, green: 179/255, blue: 34/255)
        static let secondary = Color(red: 13/255, green: 27/255, blue: 66/255)
    }
}
