//
//  ViewController.swift
//  AppLibrary-Challenge4
//
//  Created by Felipe Nery Guevara Guevara on 27/02/22.
//

import UIKit

class ViewController: UIViewController {
    
    //Definimos las dimensiones de la pantalla en un par de constantes para usar tamaños relativos.
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    
    //Declaración de los elementos a usar
    lazy var topImage : UIImageView = UIImageView()
    lazy var logo : UIImageView = UIImageView()
    lazy var bienvenida : UILabel = UILabel()
    lazy var textCorreo: UITextField = UITextField()
    lazy var textContrasena: UITextField = UITextField()
    lazy var login: UIButton = UIButton()
    lazy var register: UIButton = UIButton()
    
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
        bienvenida.font = .boldSystemFont(ofSize: 100)
        bienvenida.adjustsFontSizeToFitWidth = true
        bienvenida.textColor = .systemBlue
        bienvenida.textAlignment = .center
        
        view.addSubview(bienvenida)
        
        textCorreo = UITextField(frame: CGRect(x: width/8, y: 13*height/24, width: 3*width/4, height: height/18))
        textCorreo.textAlignment = .center
        textCorreo.attributedPlaceholder = NSAttributedString(
            string: Constants.enterEmail,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        )
        textCorreo.backgroundColor = .white
        textCorreo.layer.cornerRadius = 10
        textCorreo.layer.borderColor = UIColor.systemBlue.cgColor
        textCorreo.layer.borderWidth = 1
        textCorreo.keyboardType = .emailAddress
        
        view.addSubview(textCorreo)
        
        textContrasena = UITextField(frame: CGRect(x: width/8, y: 15*height/24, width: 3*width/4, height: height/18))
        textContrasena.backgroundColor = .white
        textContrasena.textAlignment = .center
        textContrasena.attributedPlaceholder = NSAttributedString(
            string: Constants.enterPassword,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        )
        
        textContrasena.layer.cornerRadius = 10
        textContrasena.layer.borderColor = UIColor.systemBlue.cgColor
        textContrasena.layer.borderWidth = 1
        
        textContrasena.isSecureTextEntry = true
        
        view.addSubview(textContrasena)
        
        login = UIButton(frame: CGRect(x: width/10, y: 17*height/24, width: 8*width/10, height: height/18))
        login.backgroundColor = .systemBlue
        login.setTitle(Constants.login, for: .normal)
        login.setTitleColor(.white, for: .normal)
        login.titleLabel?.font = .boldSystemFont(ofSize: 24)
        login.layer.cornerRadius = 10
        login.layer.borderColor = UIColor.systemBlue.cgColor
        login.layer.borderWidth = 1
        //login?.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        
        view.addSubview(login)
        
        register = UIButton(frame: CGRect(x: width/9, y: 19*height/24, width: 7*width/9, height: height/18))
        register.setTitle(Constants.register, for: .normal)
        register.setTitleColor(.systemBlue, for: .normal)
        register.layer.cornerRadius = 10
        register.layer.borderColor = UIColor.clear.cgColor
        register.layer.borderWidth = 1
        //register?.addTarget(self, action: #selector(registerAction), for: .touchUpInside)
        
        view.addSubview(register)
        
    }

}

