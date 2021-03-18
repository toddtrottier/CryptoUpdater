//
//  ReturnedDataModel.swift
//  CryptoUpdater
//
//  Created by Todd Trottier on 2/18/21.
//

import Foundation

// handles/stores data after it is parsed/decoded
struct ReturnedDataModel {
    let exchangeRate: Double
    let currency: String
    let cryptoType: String
    
//computed variable that takes rate Double and turns it into a string and returns it
    var exchangeRateString: String {
        return String(format: "%.2f", exchangeRate) //rounds rate to 2 decimal places
    }
}

