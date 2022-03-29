//
//  RegistroViewController.swift
//  AppLibrary-Challenge4
//
//  Created by Felipe Nery Guevara Guevara on 01/03/22.
//

import UIKit
import Combine

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
    lazy var labelMostrarContrasena : UILabel = UILabel()
    lazy var mostrarContrasenaButton : UIButton = UIButton()
    
    let registerViewModel : RegistroViewModel = RegistroViewModel()
    
    private var cancellables: [AnyCancellable] = []

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        initUI()
        validation()
        validationFinish()
        
    }
    
    func initUI(){
        
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
        
        mensaje = UILabel(frame: CGRect(x: 25, y: height/6, width: width-50, height: height/9))
        mensaje.text = Constants.welcomeMessage
        mensaje.textColor = .systemBlue
        mensaje.font = .systemFont(ofSize: 40)
        mensaje.numberOfLines = 0
        mensaje.textAlignment = .left
        mensaje.adjustsFontSizeToFitWidth = true
        
        view.addSubview(mensaje)
        
        contenedor = UIView(frame: CGRect(x: 20, y: 5*height/18, width: width-40, height: 6*height/11))
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
        
        usuarioText = UITextField(frame: CGRect(x: (width-40)/20, y: 3*height/22, width: 18*(width-40)/20, height: height/18))
        usuarioText.format()
        usuarioText.attributedPlaceholder = NSAttributedString(
            string: Constants.enterUserName,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        )
        
        contenedor.addSubview(usuarioText)
        
        correoText = UITextField(frame: CGRect(x: (width-40)/20, y: 5*height/22, width: 18*(width-40)/20, height: height/18))
        correoText.format()
        correoText.attributedPlaceholder = NSAttributedString(
            string: Constants.enterEmail,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        )
        correoText.keyboardType = .emailAddress
        
        contenedor.addSubview(correoText)
        
        contrasenaText = UITextField(frame: CGRect(x: (width-40)/20, y: 7*height/22, width: 18*(width-40)/20, height: height/18))
        contrasenaText.format()
        contrasenaText.attributedPlaceholder = NSAttributedString(
            string: Constants.enterPassword,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        )
        contrasenaText.isSecureTextEntry = true
        
        contenedor.addSubview(contrasenaText)
        
        contrasenaTextConfirm = UITextField(frame: CGRect(x: (width-40)/20, y: 9*height/22, width: 18*(width-40)/20, height: height/18))
        contrasenaTextConfirm.format()
        contrasenaTextConfirm.attributedPlaceholder = NSAttributedString(
            string: Constants.enterPasswordConfirm,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        )
        contrasenaTextConfirm.isSecureTextEntry = true
        
        contenedor.addSubview(contrasenaTextConfirm)
        
        mostrarContrasenaButton = UIButton(frame: CGRect(x: 9*width/30 - 20, y: 9*height/22 + height/16, width: 12*width/30, height: height/30))
        mostrarContrasenaButton.backgroundColor = .clear
        mostrarContrasenaButton.layer.borderColor = UIColor.clear.cgColor
        mostrarContrasenaButton.addTarget(self, action: #selector(verPass), for: .allTouchEvents)
        contenedor.addSubview(mostrarContrasenaButton)
        
        labelMostrarContrasena = UILabel(frame: CGRect(x: 0, y: 0, width: 12*width/30, height: height/24))
        labelMostrarContrasena.text = Constants.showPasswords
        labelMostrarContrasena.textAlignment = .center
        labelMostrarContrasena.backgroundColor = .clear
        labelMostrarContrasena.textColor = .systemBlue
        labelMostrarContrasena.font = .boldSystemFont(ofSize: 30)
        labelMostrarContrasena.adjustsFontSizeToFitWidth = true
        
        mostrarContrasenaButton.addSubview(labelMostrarContrasena)
        
        
        botonRegistro = UIButton(frame: CGRect(x: width/10, y: 5*height/6, width: 8*width/10, height: height/18))
        botonRegistro.blueFormat()
        botonRegistro.addTarget(self, action: #selector(registroAction), for: .touchUpInside)
        
        view.addSubview(botonRegistro)
        
        labelBotonRegistro = UILabel(frame: CGRect(x: width/5, y: 0, width: 2*width/5, height: height/18))
        labelBotonRegistro.text = Constants.createAccount
        labelBotonRegistro.textColor = .white
        labelBotonRegistro.font = .boldSystemFont(ofSize: 50)
        labelBotonRegistro.adjustsFontSizeToFitWidth = true
        
        botonRegistro.addSubview(labelBotonRegistro)
        
        
    }
    
    //suscriptor para validar el registro
    fileprivate func validation(){
        self.registerViewModel
            .validationState
            .sink{ newAlertText in
                self.updateAlert(message: newAlertText)
            }
            .store(in: &cancellables)
    }
    
    //suscriptor para salir de la pantalla al terminar el proceso
    fileprivate func validationFinish(){
        self.registerViewModel
            .validationEnd
            .sink{ _ in
                self.dismiss(animated: true)
            }
            .store(in: &cancellables)
    }
    
    func updateAlert(message: String){
        let alert = UIAlertController(title: Constants.error, message: message, preferredStyle: .alert)
        let aceptar = UIAlertAction(title: Constants.accept, style: .default, handler: nil)
        alert.addAction(aceptar)
        self.present(alert, animated: true)
    }
    
    @objc func regresoAction(){
        self.dismiss(animated: true)
    }
    
    @objc func verPass(){
        contrasenaText.isSecureTextEntry.toggle()
        contrasenaTextConfirm.isSecureTextEntry.toggle()
    }
    
    @objc func registroAction(){
        if let nombre = usuarioText.text, let correo = correoText.text, let contrasena = contrasenaText.text, let confirmacionContrasena = contrasenaTextConfirm.text{
            registerViewModel.getAlert(nombre: nombre, mail: correo, contrasena: contrasena, confirmacionContrasena: confirmacionContrasena)
        }
    }
    
}

