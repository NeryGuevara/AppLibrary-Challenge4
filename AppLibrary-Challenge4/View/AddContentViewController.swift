//
//  AddContentViewController.swift
//  AppLibrary-Challenge4
//
//  Created by Felipe Nery Guevara Guevara on 11/03/22.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class AddContentViewController: UIViewController {
    
    let width = Constants.width
    let height = Constants.height
    
    lazy var agradecimiento : UILabel = UILabel()
    lazy var titulo : UITextField = UITextField()
    lazy var autor : UITextField = UITextField()
    lazy var descripcionLabel : UILabel = UILabel()
    lazy var descripcion : UITextView = UITextView()
    lazy var obraLabel : UILabel = UILabel()
    lazy var obra : UITextView = UITextView()
    lazy var imagen : UIImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        initUI()
    }
    
    func initUI(){
        agradecimiento = UILabel(frame: CGRect(x: width/10, y: height/12, width: 8*width/10, height: height/18))
        agradecimiento.text = Constants.thanksContent
        agradecimiento.font = .boldSystemFont(ofSize: 40)
        agradecimiento.adjustsFontSizeToFitWidth = true
        agradecimiento.backgroundColor = .clear
        agradecimiento.textColor = .orange
        
        view.addSubview(agradecimiento)
        
        titulo = UITextField(frame: CGRect(x: width/8, y: 2*height/12, width: 3*width/4, height: height/18))
        titulo.format()
        titulo.attributedPlaceholder = NSAttributedString(
            string: Constants.title,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        )
        
        view.addSubview(titulo)
        
        autor = UITextField(frame: CGRect(x: width/8, y: 3*height/12, width: 3*width/4, height: height/18))
        autor.format()
        autor.attributedPlaceholder = NSAttributedString(
            string: Constants.author,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        )
        
        view.addSubview(autor)
        
        descripcionLabel = UILabel(frame: CGRect(x: width/8, y: 4*height/12-5, width: width/3, height: height/28))
        descripcionLabel.font = .boldSystemFont(ofSize: 30)
        descripcionLabel.text = Constants.description
        descripcionLabel.textColor = .systemBlue
        descripcionLabel.adjustsFontSizeToFitWidth = true
        
        view.addSubview(descripcionLabel)
        
        descripcion = UITextView(frame: CGRect(x: width/8, y: 4*height/12+height/36, width: 3*width/4, height: height/9))
        descripcion.format()
        
        view.addSubview(descripcion)
        
        obraLabel = UILabel(frame: CGRect(x: width/8, y: 6*height/12-5, width: width/3, height: height/28))
        obraLabel.font = .boldSystemFont(ofSize: 30)
        obraLabel.text = Constants.work
        obraLabel.textColor = .systemBlue
        obraLabel.adjustsFontSizeToFitWidth = true
        
        view.addSubview(obraLabel)
        
        obra = UITextView(frame: CGRect(x: width/8, y: 6*height/12+height/36, width: 3*width/4, height: height/9))
        obra.format()
        
        view.addSubview(obra)
        
        imagen = UIImageView(frame: CGRect(x: width/8, y: 8*height/12, width: 1*width/4, height: 3*width/8))
        imagen.layer.borderColor = UIColor.systemBlue.cgColor
        imagen.layer.borderWidth = 1
        imagen.layer.cornerRadius = 5
        imagen.backgroundColor = .systemGray6
        imagen.isUserInteractionEnabled = true
        
        view.addSubview(imagen)
        
        
    }
    
    

}
