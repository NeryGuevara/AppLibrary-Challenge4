//
//  RegistroViewController.swift
//  AppLibrary-Challenge4
//
//  Created by Felipe Nery Guevara Guevara on 01/03/22.
//

import UIKit

class RegistroViewController: UIViewController {

    let width = Constants.width
    let height = Constants.height
    
    lazy var topImage: UIImageView = UIImageView()
    lazy var labelRegresoButton: UILabel = UILabel()
    lazy var botonRegreso: UIButton = UIButton()
    lazy var mensaje: UILabel = UILabel()
    lazy var contenedor: UIView = UIView()
    lazy var titulo: UILabel = UILabel()
    lazy var usuarioText: UITextField = UITextField()
    lazy var correoText: UITextField = UITextField()
    lazy var contrasenaText: UITextField = UITextField()
    lazy var contrasenaTextConfirm: UITextField = UITextField()
    lazy var labelBotonRegistro: UILabel = UILabel()
    lazy var botonRegistro: UIButton = UIButton()
    
    var alerta : String = ""

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        initUI()
        
    }
    
    func initUI(){
        
        topImage = UIImageView(frame: CGRect(x: -20, y: -height/6, width: width*2, height: height/3))
        topImage.image = UIImage(named: "libros")
        
        view.addSubview(topImage)
        
        botonRegreso = UIButton(frame: CGRect(x: 20, y: height/12, width: 9*width/40, height: height/12))
        botonRegreso.backgroundColor = .clear
        botonRegreso.setTitleColor(.systemBlue, for: .normal)
        botonRegreso.addTarget(self, action: #selector(regresoAction), for: .touchUpInside)
        
        view.addSubview(botonRegreso)
        
        labelRegresoButton = UILabel(frame: CGRect(x: 0, y: 0, width: 9*width/40, height: height/12))
        labelRegresoButton.text = Constants.back
        labelRegresoButton.textColor = .systemBlue
        labelRegresoButton.font = .boldSystemFont(ofSize: 35)
        labelRegresoButton.adjustsFontSizeToFitWidth = true
        
        botonRegreso.addSubview(labelRegresoButton)
        
        mensaje = UILabel(frame: CGRect(x: 25, y: height/6, width: width-50, height: height/9))
        mensaje.text = Constants.welcomeMessage
        mensaje.textColor = .systemBlue
        mensaje.font = .systemFont(ofSize: 40)
        mensaje.numberOfLines = 0
        mensaje.textAlignment = .left
        mensaje.adjustsFontSizeToFitWidth = true
        
        view.addSubview(mensaje)
        
        contenedor = UIView(frame: CGRect(x: 20, y: 5*height/18, width: width-40, height: height/2))
        contenedor.backgroundColor = .systemGray3
        contenedor.layer.cornerRadius = 20
        
        view.addSubview(contenedor)
        
        titulo = UILabel(frame: CGRect(x: (width-40)/16, y: height/22, width: 14*(width-40)/16, height: height/22))
        titulo.text = Constants.registerTitle
        titulo.textColor = .systemBlue
        titulo.font = .boldSystemFont(ofSize: 40)
        titulo.textAlignment = .center
        titulo.adjustsFontSizeToFitWidth = true
        
        contenedor.addSubview(titulo)
        
        usuarioText = UITextField(frame: CGRect(x: (width-40)/20, y: 3*height/22, width: 18*(width-40)/20, height: height/22))
        usuarioText.format()
        usuarioText.attributedPlaceholder = NSAttributedString(
            string: Constants.enterUserName,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        )
        
        contenedor.addSubview(usuarioText)
        
        correoText = UITextField(frame: CGRect(x: (width-40)/20, y: 5*height/22, width: 18*(width-40)/20, height: height/22))
        correoText.format()
        correoText.attributedPlaceholder = NSAttributedString(
            string: Constants.enterEmail,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        )
        correoText.keyboardType = .emailAddress
        
        contenedor.addSubview(correoText)
        
        contrasenaText = UITextField(frame: CGRect(x: (width-40)/20, y: 7*height/22, width: 18*(width-40)/20, height: height/22))
        contrasenaText.format()
        contrasenaText.attributedPlaceholder = NSAttributedString(
            string: Constants.enterPassword,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        )
        contrasenaText.isSecureTextEntry = true
        
        contenedor.addSubview(contrasenaText)
        
        contrasenaTextConfirm = UITextField(frame: CGRect(x: (width-40)/20, y: 9*height/22, width: 18*(width-40)/20, height: height/22))
        contrasenaTextConfirm.format()
        contrasenaTextConfirm.attributedPlaceholder = NSAttributedString(
            string: Constants.enterPasswordConfirm,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        )
        contrasenaTextConfirm.isSecureTextEntry = true
        
        contenedor.addSubview(contrasenaTextConfirm)
        
        botonRegistro = UIButton(frame: CGRect(x: width/10, y: 29*height/36, width: 8*width/10, height: height/18))
        botonRegistro.blueFormat()
        //botonRegistro?.addTarget(self, action: #selector(registroAction), for: .touchUpInside)
        
        view.addSubview(botonRegistro)
        
        labelBotonRegistro = UILabel(frame: CGRect(x: width/5, y: 0, width: 2*width/5, height: height/18))
        labelBotonRegistro.text = Constants.createAccount
        labelBotonRegistro.textColor = .white
        labelBotonRegistro.font = .boldSystemFont(ofSize: 50)
        labelBotonRegistro.adjustsFontSizeToFitWidth = true
        
        botonRegistro.addSubview(labelBotonRegistro)
        
        
    }
    
    @objc func regresoAction(){
        self.dismiss(animated: true, completion: nil)
    }
    
    

    

}