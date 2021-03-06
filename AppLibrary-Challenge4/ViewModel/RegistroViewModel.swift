//
//  RegistroViewModel.swift
//  AppLibrary-Challenge4
//
//  Created by Felipe Nery Guevara Guevara on 11/03/22.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import Combine

class RegistroViewModel{
    
    var alerta : String = ""
    
    public var validationState = PassthroughSubject<String,Never>()//declarando publisher
    
    public var validationEnd = PassthroughSubject<Bool,Never>()//declarando publisher
    
    fileprivate var newAlertText: String {
        didSet{
            validationState.send(newAlertText)
        }
    }
    
    fileprivate var end: Bool {
        didSet{
            validationEnd.send(end)
        }
    }
    
    init() {
        self.newAlertText = ""
        self.end = false
    }
    
    private func newAlert(message: String){
        newAlertText = message
    }
    
    private func finishRegister(){
        end = true
    }
    
    public func getAlert(nombre: String, mail: String, contrasena: String, confirmacionContrasena: String){//funcion que se va a llamar desde nuestro ViewController
        var nombreIngresado = false
        var nombreValido = false
        var mailIngrasado = false
        var contrasenaValidaIngresada = false
        var confirmacionContrasenaIgrasada = false
        
        if nombre != ""{
            nombreIngresado = true
        }else{
            alerta = Constants.alertNameIntro
        }
        
        
        if nombre.count > 3{
            nombreValido = true
        }else{
            alerta = Constants.alertNameBad
        }
        
        //Validaciones para el formato del correo
        let regexMail = "^([a-z]|[A-Z])+(\\w|\\W)+@(([a-z]|[A-Z])+\\.([a-z]|[A-Z])+|([a-z]|[A-Z])+\\.([a-z]|[A-Z])+\\.([a-z]|[A-Z])+)$"
        if (mail.range(of: regexMail, options: .regularExpression, range: nil, locale: nil) != nil){
            mailIngrasado = true
        }else{
            alerta = Constants.alertMailIntro
        }
        
        if confirmacionContrasena == contrasena{
            confirmacionContrasenaIgrasada = true
        }else{
            alerta = Constants.alertPassBadIntro
        }
        
        //Validaciones para la contrase??a: Al menos una may??scula, al menos una min??scula, al menos un n??mero, al menos un car??cter especial y al menos 8 caracteres
        let regexContrasena = "^(?=.{8,}$)(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*\\W).*$"
        if (contrasena.range(of: regexContrasena, options: .regularExpression, range: nil, locale: nil) != nil) {
                contrasenaValidaIngresada = true
        }else{
            alerta = Constants.alertPassBad
        }
        
        //Si se cumplieron las validaciones de los datos proporcionados se env??a la petici??n del registro
        if nombreIngresado && nombreValido && mailIngrasado && contrasenaValidaIngresada && confirmacionContrasenaIgrasada{
            subirRegistro(nombre: nombre, correo: mail, pass: contrasena)
        }else{
            newAlert(message: alerta)
        }
    }
    
    private func subirRegistro(nombre: String, correo: String, pass: String){
        
        var ref: DatabaseReference?
        ref = Database.database().reference()
        
        Auth.auth().createUser(withEmail: correo, password: pass) { user, error in
            if user != nil{
                let campos = ["nombre": nombre, "email": correo, "id": Auth.auth().currentUser?.uid]
                ref?.child("users").child(Auth.auth().currentUser!.uid).setValue(campos)
                self.finishRegister()
            }else{
                if let error = error?.localizedDescription{
                    self.newAlert(message: error)
                }else{
                    self.newAlert(message: Constants.errorInternal)
                }
            }
        }
        
    }
        
}
    

