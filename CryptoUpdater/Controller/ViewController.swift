//
//  ViewController.swift
//  CryptoUpdater
//
//  Created by Todd Trottier on 2/15/21.
//

import UIKit

class ViewController: UIViewController {
    
    
    var cryptoManager = CryptoManager()
    

    

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setting VC as the data source for picker view
        currencyPicker.dataSource = self
        currencyPicker.delegate = self //setting self as pickerViewDelegate
        
        cryptoManager.delegate = self //setting VC as delegate
    }
    
}
    
    

//MARK: UIPickerViewDataSource and UIPickerViewDelegate

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate{
        
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        //number of columns in picker view
        return 1
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //number of rows needed based on the amt of currency labels in array
        return cryptoManager.currencyArray.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //setting the title for picker view using this method's row Int
        return cryptoManager.currencyArray[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //code that will execute everytime user selects a row
        
        let currencySelected = cryptoManager.currencyArray[row]
        print(currencySelected) //will print currency string from array
        
        cryptoManager.getPrice(for: currencySelected)
    }


}





//MARK: CryptoManagerDelegate

extension ViewController: CryptoManagerDelegate {
    //anything that deals with CryptoManagerDelegate
    
    func didUpdateCurrency(rateData: ReturnedDataModel) {
        
        DispatchQueue.main.async {
            self.priceLabel.text = rateData.exchangeRateString
            self.currencyLabel.text = rateData.currency
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}

