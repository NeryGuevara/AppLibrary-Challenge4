//
//  BuySellViewController.swift
//  CryptoChecker
//
//  Created by L Daniel De San Pedro on 15/02/22.
//

import UIKit

class BuySellViewController: UIViewController {
    
    var viewModel: BuySellViewModel = BuySellViewModel()
    lazy var sellInfoView: RateView = RateView()
    lazy var buyInfoView: RateView = RateView()

    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initViewModel()
        
        self.view.backgroundColor = .systemBackground
        viewModel.fetchData()

    }
    
    func initViewModel() {
        viewModel.buyDataObserver.valueChanged = { [weak self] buyData in
            guard let model: SellBuyModel = buyData else { return }
            self?.buyInfoView.initUI(model: model)
        }
        
        viewModel.sellDataObserver.valueChanged = { [weak self] sellData in
            guard let model: SellBuyModel = sellData else { return }
            self?.sellInfoView.initUI(model: model)
        }
    }
    
    func initUI() {
        self.title = viewModel.obtainViewTitle()
        
        view.addSubview(sellInfoView)
        view.addSubview(buyInfoView)
        
        sellInfoView.translatesAutoresizingMaskIntoConstraints = false
        buyInfoView.translatesAutoresizingMaskIntoConstraints = false
        
        
    }
    
}
