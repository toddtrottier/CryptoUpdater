//
//  CryptoManager.swift
//  CryptoUpdater
//
//  Created by Todd Trottier on 2/15/21.
//

import Foundation

protocol CryptoManagerDelegate {
    func didUpdateCurrency(rateData: ReturnedDataModel)
    
    //captures errors
    func didFailWithError(error: Error)
}


struct CryptoManager {
    
    //set delegate as optional CryptoManagerDelegate
    var delegate: CryptoManagerDelegate?
    
    let beginningURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    
    
    func getPrice(for currency: String) {
        let urlString = "\(beginningURL)/\(currency)?apikey=\(apiKey)"
        //print(urlString)
        performRequest(with: urlString)
    }
    
    
    
    
    
    
    //MARK: Networking
    
    func performRequest(with urlString: String) {
        //step 1: create URL
        if let url = URL(string: urlString) {
            
            //Step 2: Create URLSession
            let session = URLSession(configuration: .default)
            
            
            //Step 3: give URLSession a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    //catching error IF task fails
                    print(error!)
                }
                if let safeData = data {
                    //if task returns data, set it = safeDaata and do the following code
                    
                    //put data into parseJSON func and return it and put data in cryptoInfo
                    if let cryptoInfo = parseJSON(safeData) {
                        
                        //call delegate to perform didUpdateCrypto func
                        self.delegate?.didUpdateCurrency(rateData: cryptoInfo)
                    }
                }
                
                
            }
            
            //Step 4: resume task (task is paused when initalized)
            task.resume()
        
        }
    }
    
    
    
    
    //MARK: Parsing
    
    func parseJSON(_ exchangeData: Data) -> ReturnedDataModel? {
        //parses safeData and puts it into pretty form based on ExchangeRateData Model that was created
        
        let decoder = JSONDecoder() //a new JSONDecoder
        
        do{
            let decodedData = try decoder.decode(ExchangeRateData.self, from: exchangeData)
            
            let rate = decodedData.rate
            let currency = decodedData.asset_id_quote
            let crypto = decodedData.asset_id_base
            
            //making new object from ReturnedDataModel and storing decoded data inside of it
            let returnedData = ReturnedDataModel(exchangeRate: rate, currency: currency, cryptoType: crypto)
            return returnedData 
        }
        catch {
            //catch errors here
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
