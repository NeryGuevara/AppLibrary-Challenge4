//
//  ViewModel.swift
//  AppLibrary-Challenge4
//
//  Created by Felipe Nery Guevara Guevara on 27/03/22.
//

import Foundation
import FirebaseAuth
import Combine

class ViewModel{
    
    public var validationState = PassthroughSubject<String,Never>()//declarando publisher
    
    public var validationLogin = PassthroughSubject<Bool,Never>()//declarando publisher
    
    fileprivate var newAlertText: String {
        didSet{
            validationState.send(newAlertText)
        }
    }
    
    fileprivate var automaticLogin: Bool {
        didSet{
            validationLogin.send(automaticLogin)
        }
    }
    
    init() {
        self.newAlertText = ""
        self.automaticLogin = false
    }
    
    private func newAlert(message: String){
        newAlertText = message
    }
    
    private func finishLogin(){
        automaticLogin = true
    }
    
    func iniciarSesion(correo: String, pass: String){
        Auth.auth().signIn(withEmail: correo, password: pass) { [self] user, error in
            if user != nil{
                finishLogin()
            }else{
                if let _ = error?.localizedDescription{
                    newAlert(message: Constants.errorCount)
                }else{
                    newAlert(message: Constants.errorInternal)
                }
            }
        }
    }
    
    func sesionActiva(){
        Auth.auth().addStateDidChangeListener { [self] user, error in
            if error != nil{
                finishLogin()
            }
        }
    }
    
}
