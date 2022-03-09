//
//  ReusableTableViewCell.swift
//  AppLibrary-Challenge4
//
//  Created by Felipe Nery Guevara Guevara on 08/03/22.
//

import UIKit

class ReusableTableViewCell: UITableViewCell {
    
    let width = Constants.width
    let height = Constants.height
    
    static var reuseIdentifier: String = "CurrencyListTableViewCell"
    
    //MARK: Labels
    var nameLabel: UILabel?
    var subtitleLabel: UILabel?
    
    var ownContent = UIView()
    
    func initUI(model: TableViewCellVieable) {
        
        self.backgroundColor = .systemGray5
        
        ownContent = UIView(frame: CGRect(x: 5, y: 5, width: width - 10, height: height/7 - 10))
        ownContent.backgroundColor = .systemGray3
        ownContent.layer.cornerRadius = 8
        
        contentView.addSubview(ownContent)
        
        //Agregar los labels a las views
        nameLabel = UILabel(frame: CGRect(x: (width-20)/4, y: 0, width: 3*(width-20)/4, height: (height/7 - 10)/3))
        nameLabel?.text = model.title
        nameLabel?.textAlignment = .left
        nameLabel?.font = .boldSystemFont(ofSize: 18)
        nameLabel?.textColor = .systemBlue
        
        ownContent.addSubview(nameLabel!)
        
        subtitleLabel = UILabel(frame: CGRect(x: (width-20)/4, y: (height/7 - 10)/3, width: 5*(width-20)/8, height: (height/7 - 10)/3))
        subtitleLabel?.text = model.subtitle
        subtitleLabel?.textAlignment = .left
        subtitleLabel?.font = .boldSystemFont(ofSize: 14)
        subtitleLabel?.textColor = .systemBlue
        
        ownContent.addSubview(subtitleLabel!)
        
        
    }
    override func prepareForReuse() {
        self.nameLabel?.removeFromSuperview()
        self.subtitleLabel?.removeFromSuperview()
        self.nameLabel = nil
        self.subtitleLabel = nil
    }
}
