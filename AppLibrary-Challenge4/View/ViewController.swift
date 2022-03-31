//
//  ViewController.swift
//  AppLibrary-Challenge4
//
//  Created by Felipe Nery Guevara Guevara on 27/02/22.
//

import UIKit
import Combine

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
    lazy var labelMostrarContrasena : UILabel = UILabel()
    lazy var mostrarContrasenaButton : UIButton = UIButton()
    
    let viewModel : ViewModel = ViewModel()
    
    private var cancellables: [AnyCancellable] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Seleccionamos el backgroundColor como el color por defecto seleccionado en el iPhone
        view.backgroundColor = .systemBackground
        
        //Función que pondrá en pantalla los elementos de UIKit
        initUI()
        
        validation()
        validationLogin()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.sesionActiva()
        textCorreo.text = ""
        textContrasena.text = ""
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
        
        mostrarContrasenaButton = UIButton(frame: CGRect(x: width/3, y: 15*height/24 + height/16, width: width/3, height: height/30))
        mostrarContrasenaButton.backgroundColor = .clear
        mostrarContrasenaButton.layer.borderColor = UIColor.clear.cgColor
        mostrarContrasenaButton.addTarget(self, action: #selector(verPass), for: .allTouchEvents)
        view.addSubview(mostrarContrasenaButton)
        
        labelMostrarContrasena = UILabel(frame: CGRect(x: 0, y: 0, width: width/3, height: height/24))
        labelMostrarContrasena.text = Constants.showPass
        labelMostrarContrasena.textAlignment = .center
        labelMostrarContrasena.backgroundColor = .clear
        labelMostrarContrasena.textColor = .systemBlue
        labelMostrarContrasena.font = .boldSystemFont(ofSize: 30)
        labelMostrarContrasena.adjustsFontSizeToFitWidth = true
        
        mostrarContrasenaButton.addSubview(labelMostrarContrasena)
        
        
        loginButton = UIButton(frame: CGRect(x: width/10, y: 3*height/4, width: 8*width/10, height: height/16))
        loginButton.blueFormat()
        loginButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        
        view.addSubview(loginButton)
        
        labelLoginOfButton = UILabel(frame: CGRect(x: 19*width/60, y: 0, width: width/6, height: height/16))
        labelLoginOfButton.text = Constants.login
        labelLoginOfButton.textAlignment = .center
        labelLoginOfButton.backgroundColor = .clear
        labelLoginOfButton.textColor = .white
        labelLoginOfButton.font = .boldSystemFont(ofSize: 40)
        labelLoginOfButton.adjustsFontSizeToFitWidth = true
        
        loginButton.addSubview(labelLoginOfButton)
        
        registerButton = UIButton(frame: CGRect(x: width/8, y: 7*height/8, width: 3*width/4, height: height/16))
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
    
    //suscriptor para validar el registro
    fileprivate func validation(){
        self.viewModel
            .validationState
            .sink{ newAlertText in
                self.updateAlert(message: newAlertText)
            }
            .store(in: &cancellables)
    }
    
    //suscriptor para salir de la pantalla al terminar el proceso
    fileprivate func validationLogin(){
        self.viewModel
            .validationLogin
            .sink{ _ in
                self.loggingOccurred()
            }
            .store(in: &cancellables)
    }
    
    func updateAlert(message: String){
        let alert = UIAlertController(title: Constants.error, message: message, preferredStyle: .alert)
        let aceptar = UIAlertAction(title: Constants.accept, style: .default, handler: nil)
        alert.addAction(aceptar)
        self.present(alert, animated: true)
    }
    
    func loggingOccurred(){
        let tabBar = UITabBarController()
        let home = HomeViewController()
        home.title = Constants.home
        home.tabBarItem.image = UIImage(named: "home")
        let search = SearchViewController()
        search.title = Constants.search
        search.tabBarItem.image = UIImage(named: "buscar")
        let detalles = AccountViewController()
        detalles.title = Constants.account
        detalles.tabBarItem.image = UIImage(named: "account")
        UITabBar.appearance().backgroundColor = .systemGray6
        
        tabBar.setViewControllers([home, search, detalles], animated: true)
        tabBar.modalPresentationStyle = .fullScreen
        present(tabBar, animated: true)
    }
    
    @objc func verPass(){
        textContrasena.isSecureTextEntry.toggle()
    }
    
    @objc func loginAction(){
        if let correo = textCorreo.text, let pass = textContrasena.text{
            viewModel.iniciarSesion(correo: correo, pass: pass)
        }
    }
    
    @objc func registerAction(){
        let registro = RegistroViewController()
        registro.modalPresentationStyle = .fullScreen
        present(registro, animated: true, completion: nil)
    }

}




