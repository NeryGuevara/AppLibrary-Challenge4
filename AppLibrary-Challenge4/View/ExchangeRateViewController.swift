//
//  ExchangeRateViewController.swift
//  AppLibrary-Challenge4
//
//  Created by Felipe Nery Guevara Guevara on 08/03/22.
//

import Foundation
import UIKit

class ExchangeRateViewController: UIViewController {
    
    let width = Constants.width
    let height = Constants.height
    
    lazy var topImage : UIImageView = UIImageView()
    
    lazy var labelRegresoButton: UILabel = UILabel()
    lazy var botonRegreso: UIButton = UIButton()
    
    private var viewModel: ExchangeViewModel = ExchangeViewModel()
        
    lazy var exchangesTableView: UITableView = UITableView()
    
    lazy var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    lazy var errorLabel: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        initUI()
        initViewModel()
        viewModel.requestInfo()
    }
    
    func initViewModel() {
        viewModel.fetchingData.valueChanged = { [weak self] isFetchig in
            if isFetchig ?? false {
                self?.initActivityView()
            } else {
                self?.removeActivityView()
            }
        }
        viewModel.exchangeData.valueChanged = { [weak self] _ in
            self?.initUI()
        }
        
        viewModel.didObtainError.valueChanged = { [weak self] errorState in
            errorState ?? false ? self?.showErrorLabel() : self?.hideErrorLabel()
        }
         
        /*
        viewModel.route.valueChanged = {[weak self] route in
            guard let nextView: UIViewController = route?.viewController else { return }
            self?.navigationController?.pushViewController(nextView, animated: false)
        }
         */
    }
    
    func showErrorLabel() {
        errorLabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: height))
        errorLabel.text = "ErrorLabel"
        view.addSubview(errorLabel)
    }
    
    func hideErrorLabel() {
        errorLabel.removeFromSuperview()
    }
    
    func initActivityView() {
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func removeActivityView() {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
    
    func initUI() {
        
        topImage = UIImageView(frame: CGRect(x: -20, y: -height/6, width: width*2, height: height/3))
        topImage.image = UIImage(named: "libros")
        
        view.addSubview(topImage)
        
        botonRegreso = UIButton(frame: CGRect(x: 20, y: height/12, width: 9*width/40, height: height/12))
        botonRegreso.backgroundColor = .clear
        botonRegreso.addTarget(self, action: #selector(regresoAction), for: .touchUpInside)
        
        view.addSubview(botonRegreso)
        
        labelRegresoButton = UILabel(frame: CGRect(x: 0, y: 0, width: 9*width/40, height: height/12))
        labelRegresoButton.text = Constants.back
        labelRegresoButton.textColor = .systemBlue
        labelRegresoButton.font = .boldSystemFont(ofSize: 35)
        labelRegresoButton.adjustsFontSizeToFitWidth = true
        
        botonRegreso.addSubview(labelRegresoButton)
        
        exchangesTableView = UITableView(frame: CGRect(x: 0, y: height/2, width: width, height: height))
        view.addSubview(exchangesTableView)
        exchangesTableView.register(ReusableTableViewCell.self, forCellReuseIdentifier: ReusableTableViewCell.reuseIdentifier)
        exchangesTableView.delegate = self
        exchangesTableView.dataSource = self
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: width/2-10, y: height/2-10, width: 20, height: 20))
        view.addSubview(activityIndicator)
    }
    
    func setViewModel(_ viewModel: ExchangeViewModel) {
        self.viewModel = viewModel
    }
    
    @objc func regresoAction(){
        self.dismiss(animated: false, completion: nil)
    }
    
}

extension ExchangeRateViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //viewModel.didSelectRowAt(index: indexPath.row)
    }
}

extension ExchangeRateViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return height/7
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.obtainNumberOfResults()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewCell: ReusableTableViewCell = tableView.dequeueReusableCell(withIdentifier: ReusableTableViewCell.reuseIdentifier, for: indexPath) as? ReusableTableViewCell else {
                  return UITableViewCell()
              }
        let exchange: ExchangeRateModel = viewModel.obtainModelAtIndex(index: indexPath.row)
        viewCell.initUI(model: exchange)
        return viewCell
    }
    
}
