//
//  Route.swift
//  AppLibrary-Challenge4
//
//  Created by Felipe Nery Guevara Guevara on 08/03/22.
//

import Foundation
import UIKit

enum Route {
    case exchangeView(crypto: Crypto)
    case alert(title: String, message: String?)
    case newItemAlert(title: String, observer: Observable<Crypto>, buttonHandler: () -> Void)
    //case sellBuy(firstCurrency: String, secondCurrency: String)
    case none
    
    var viewController: UIViewController? {
        switch self {
        case .exchangeView(crypto: let crypto):
            return instantiateExchangeViewModule(crypto: crypto)
        case .alert(title: let title, message: let message):
            return instantiateAlertView(title: title, message: message)
        case .newItemAlert(title: let title, let observer, let handler):
            return instantiateNewItemAlert(title: title, observer: observer, buttonHandler: handler)
        /*case .sellBuy(firstCurrency: let firstCurrency, secondCurrency: let secondCurrency):
            return instantiateSellBuyModule(firstCurrency: firstCurrency, secondCurrency: secondCurrency)*/
        case .none:
            return nil
        }
    }
    
    private func instantiateExchangeViewModule(crypto: Crypto) -> UIViewController {
        let viewModel: ExchangeViewModel = ExchangeViewModel(crypto: crypto)
        let viewController: ExchangeRateViewController = ExchangeRateViewController()
         viewController.setViewModel(viewModel)
        return viewController
    }
    
    private func instantiateAlertView(title: String, message: String?) -> UIViewController {
        let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction: UIAlertAction = UIAlertAction(title: Constants.accept, style: .default, handler: nil)
        alertController.addAction(alertAction)
        return alertController
    }
    
    private func instantiateNewItemAlert(title: String, observer: Observable<Crypto>, buttonHandler: @escaping () ->()) -> UIViewController {
        let alertController: UIAlertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alertController.addTextField(configurationHandler: nil)
        
        let acceptAction: UIAlertAction = UIAlertAction(title: Constants.accept, style: .default) { _ in
            guard let currencyNameTextField: UITextField = alertController.textFields?[0] else {
                      buttonHandler()
                      return
                  }
            observer.value?.name = currencyNameTextField.text ?? ""
            
            buttonHandler()
        }
        
        alertController.addAction(acceptAction)
        return alertController
    }
    /*
    private func instantiateSellBuyModule(firstCurrency: String, secondCurrency: String) -> UIViewController {
        let viewController: BuySellViewController = BuySellViewController()
        let buySellViewModel: BuySellViewModel = BuySellViewModel(crypto: firstCurrency, secondCurrency: secondCurrency)
        viewController.viewModel = buySellViewModel
        return viewController
    }*/
}
