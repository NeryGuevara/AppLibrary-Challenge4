//
//  ViewController.swift
//  AppLibrary-Challenge4
//
//  Created by Felipe Nery Guevara Guevara on 27/02/22.
//

import UIKit

class ViewController: UIViewController {
    
    //Definimos las dimensiones de la pantalla en un par de constantes para usar tamaños relativos.
    let width = Constants.width
    let height = Constants.height
    
    
    //Declaración de los elementos a usar
    lazy var topImage : UIImageView = UIImageView()
    lazy var logo : UIImageView = UIImageView()
    lazy var bienvenida : UILabel = UILabel()
    lazy var textCorreo: UITextField = UITextField()
    lazy var textContrasena: UITextField = UITextField()
    lazy var labelLoginOfButton : UILabel = UILabel()
    lazy var loginButton: UIButton = UIButton()
    lazy var labelRegisterOfButton : UILabel = UILabel()
    lazy var registerButton: UIButton = UIButton()
    
    var alerta : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        //Seleccionamos el backgroundColor como el color por defecto seleccionado en el iPhone
        view.backgroundColor = .systemBackground
        //Función que pondrá en pantalla los elementos de UIKit
        initUI()
    }
    
    func initUI(){
        
        topImage = UIImageView(frame: CGRect(x: -20, y: 0, width: width*2, height: height/3))
        topImage.image = UIImage(named: "libros")
        
        view.addSubview(topImage)
        
        logo = UIImageView(frame: CGRect(x: width/4, y: height/6, width: height/4, height: height/4))
        logo.image = UIImage(named: "logo")
        
        view.addSubview(logo)
        
        bienvenida = UILabel(frame: CGRect(x: width/4, y: 11*height/24, width: width/2, height: height/12))
        bienvenida.text = Constants.welcome
        bienvenida.font = .boldSystemFont(ofSize: 50)
        bienvenida.adjustsFontSizeToFitWidth = true
        bienvenida.textColor = .systemBlue
        bienvenida.textAlignment = .center
        
        view.addSubview(bienvenida)
        
        textCorreo = UITextField(frame: CGRect(x: width/8, y: 13*height/24, width: 3*width/4, height: height/18))
        textCorreo.format()
        textCorreo.attributedPlaceholder = NSAttributedString(
            string: Constants.enterEmail,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        )
        textCorreo.keyboardType = .emailAddress
        view.addSubview(textCorreo)
        
        textContrasena = UITextField(frame: CGRect(x: width/8, y: 15*height/24, width: 3*width/4, height: height/18))
        textContrasena.format()
        textContrasena.attributedPlaceholder = NSAttributedString(
            string: Constants.enterPassword,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        )
        textContrasena.isSecureTextEntry = true
        
        view.addSubview(textContrasena)
        
        loginButton = UIButton(frame: CGRect(x: width/10, y: 17*height/24, width: 8*width/10, height: height/18))
        loginButton.blueFormat()
        loginButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        
        view.addSubview(loginButton)
        
        labelLoginOfButton = UILabel(frame: CGRect(x: 6.5*width/20, y: 0, width: 3*width/20, height: height/18))
        labelLoginOfButton.text = Constants.login
        labelLoginOfButton.textAlignment = .center
        labelLoginOfButton.backgroundColor = .clear
        labelLoginOfButton.textColor = .white
        labelLoginOfButton.font = .boldSystemFont(ofSize: 40)
        labelLoginOfButton.adjustsFontSizeToFitWidth = true
        
        loginButton.addSubview(labelLoginOfButton)
        
        registerButton = UIButton(frame: CGRect(x: width/8, y: 19*height/24, width: 3*width/4, height: height/18))
        registerButton.backgroundColor = .clear
        registerButton.layer.borderColor = UIColor.clear.cgColor
        registerButton.addTarget(self, action: #selector(registerAction), for: .touchUpInside)
        
        view.addSubview(registerButton)
        
        labelRegisterOfButton = UILabel(frame: CGRect(x: 0, y: 0, width: 3*width/4, height: height/18))
        labelRegisterOfButton.text = Constants.register
        labelRegisterOfButton.textAlignment = .center
        labelRegisterOfButton.backgroundColor = .clear
        labelRegisterOfButton.textColor = .systemBlue
        labelRegisterOfButton.font = .boldSystemFont(ofSize: 30)
        labelRegisterOfButton.adjustsFontSizeToFitWidth = true
        
        registerButton.addSubview(labelRegisterOfButton)
    }
    
    @objc func loginAction(){
        let login = HomeViewController()
        login.modalPresentationStyle = .fullScreen
        present(login, animated: true, completion: nil)
    }
    
    @objc func registerAction(){
        let registro = RegistroViewController()
        registro.modalPresentationStyle = .fullScreen
        present(registro, animated: true, completion: nil)
    }

}



