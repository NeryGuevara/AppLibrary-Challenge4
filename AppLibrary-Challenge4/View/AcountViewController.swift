//
//  AcountViewController.swift
//  AppLibrary-Challenge4
//
//  Created by Felipe Nery Guevara Guevara on 11/03/22.
//

import UIKit
import Combine

class AccountViewController: UIViewController {

    let width = Constants.width
    let height = Constants.height
    
    var email : String = ""
    
    lazy var topImage : UIImageView = UIImageView()
    lazy var linea : UIView = UIView()
    lazy var hola : UILabel = UILabel()
    lazy var nombre : UILabel = UILabel()
    lazy var botonCierre: UIButton = UIButton()
    lazy var labelBotonCierre : UILabel = UILabel()
    lazy var correoLabel : UILabel = UILabel()
    lazy var correoValorLabel : UILabel = UILabel()
    
    let accountViewModel : AccountViewModel = AccountViewModel()
    private var cancellables: [AnyCancellable] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
    
        initUI()
        
        accountViewModel.recibirInfoPerfil()
        receiveName()
        receiveEmail()
        
    }
    
    func initUI(){
        
        topImage = UIImageView(frame: CGRect(x: -20, y: -height/6, width: width*2, height: height/3))
        topImage.image = UIImage(named: "libros")
        
        view.addSubview(topImage)
        
        hola = UILabel(frame: CGRect(x: 20, y: height/15, width: width/5, height: 40))
        hola.text = Constants.hello
        hola.font = .boldSystemFont(ofSize: 40)
        hola.adjustsFontSizeToFitWidth = true
        hola.textColor = UIColor.orange
        hola.textAlignment = .left
        
        view.addSubview(hola)
        
        nombre = UILabel(frame: CGRect(x: 20, y: height/15 + 40, width: width-40, height: 42))
        nombre.font = .boldSystemFont(ofSize: 33)
        nombre.textColor = UIColor.systemBlue
        nombre.textAlignment = .left
        
        view.addSubview(nombre)
        
        linea = UIView(frame: CGRect(x: width/2 - 20, y: 42, width: width/2, height: height/200))
        linea.backgroundColor = .systemBlue
        
        nombre.addSubview(linea)
        
        botonCierre = UIButton(frame: CGRect(x: 17*width/24 - 20, y: height/36, width: 7*width/24, height: height/12))
        botonCierre.backgroundColor = .clear
        botonCierre.addTarget(self, action: #selector(cierreSesion), for: .touchUpInside)
        
        view.addSubview(botonCierre)
        
        labelBotonCierre = UILabel(frame: CGRect(x: 0, y: 0, width: 7*width/24, height: height/12))
        labelBotonCierre.text = Constants.logOutlabel
        labelBotonCierre.textColor = .systemBlue
        labelBotonCierre.font = .boldSystemFont(ofSize: 24)
        labelBotonCierre.numberOfLines = 0
        labelBotonCierre.textAlignment = .center
        labelBotonCierre.adjustsFontSizeToFitWidth = true
        
        botonCierre.addSubview(labelBotonCierre)
        
        correoLabel = UILabel(frame: CGRect(x: width/10, y: height/2-height/18-height/12, width: 8*width/10, height: height/12))
        correoLabel.numberOfLines = 0
        correoLabel.text = Constants.enterEmail + ": "
        correoLabel.font = .boldSystemFont(ofSize: 30)
        correoLabel.textColor = .systemBlue
        correoLabel.adjustsFontSizeToFitWidth = true
        
        view.addSubview(correoLabel)
        
        correoValorLabel = UILabel(frame: CGRect(x: width/10, y: height/2-height/18, width: 8*width/10, height: height/4))
        correoValorLabel.font = .boldSystemFont(ofSize: 30)
        correoValorLabel.textColor = .systemBlue
        correoValorLabel.adjustsFontSizeToFitWidth = true
        
        view.addSubview(correoValorLabel)
    }
    
    //suscriptor para traer el nombre del usuario
    fileprivate func receiveName(){
        self.accountViewModel
            .reloadUserName
            .sink{ name in
                self.nombre.text = name
            }
            .store(in: &cancellables)
    }
    
    //suscriptor para traer el nombre del usuario
    fileprivate func receiveEmail(){
        self.accountViewModel
            .reloadUserEmail
            .sink{ email in
                self.correoValorLabel.text = email
            }
            .store(in: &cancellables)
    }
    
    @objc func cierreSesion(){
        let alerta = UIAlertController(title: Constants.logOutTitle, message: Constants.logOutMessage, preferredStyle: .alert)
        let aceptar = UIAlertAction(title: Constants.accept, style: .default) { _ in
            self.accountViewModel.cerrarSesion()
            self.dismiss(animated: true, completion: nil)
        }
        let cancelar = UIAlertAction(title: Constants.cancel, style: .default, handler: nil)
        alerta.addAction(aceptar)
        alerta.addAction(cancelar)
        present(alerta, animated: true, completion: nil)
    }
    

    

}
