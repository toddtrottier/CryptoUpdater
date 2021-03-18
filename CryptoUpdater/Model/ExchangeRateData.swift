//
//  ExchangeRateData.swift
//  CryptoUpdater
//
//  Created by Todd Trottier on 2/18/21.
//

import Foundation

//models api call data
//struct adpots decodable protocol allowing it to be decodable
struct ExchangeRateData: Decodable {
    let asset_id_base: String
    let asset_id_quote: String
    let rate: Double
}
