//
//  RegistroViewModel.swift
//  AppLibrary-Challenge4
//
//  Created by Felipe Nery Guevara Guevara on 11/03/22.
//

import Foundation

func validarCampos(nombre: String, mail: String, contrasena: String, confirmacionContrasena: String) -> String{
    //La validación para el registro empieza con todo en falso (Porque todos los textfields están vacío)
    
    var alerta = ""
    
    var nombreIngresado = false
    var nombreValido = false
    var mailIngrasado = false
    var contrasenaValidaIngresada = false
    var confirmacionContrasenaIgrasada = false
    //Estas validaciones son para la contraseña
    var seguridadMinuscula = false
    var seguridadMayuscula = false
    var seguridadNumero = false
    var seguridadEspecial = false
    var seguridadCount = false
    
    if nombre != ""{
        nombreIngresado = true
    }else{
        alerta = "Por favor, introduce tu nombre de usuario"
    }
    
    
    if nombre.count > 3{
        nombreValido = true
    }else{
        alerta = "El nombre de usuario ingrasado es demasiado corto, por favor ingresa uno con al menos 4 carácteres"
    }
    
    if mail != ""{
        mailIngrasado = true
    }else{
        alerta = "Por favor, ingresa tu correo electrónico"
    }
    
    
    
    for i in contrasena{
        switch i{
            case "a","b","c","d","e","f","g","h","i","j","k","l","m","n","ñ","o","p","q","r","s","t","u","v","w","x","y","z":
            seguridadMinuscula = true
            case "A","B","C","D","E","F","G","H","I","J","K","L","M","N","Ñ","O","P","Q","R","S","T","U","V","W","X","Y","Z":
            seguridadMayuscula = true
            case "1","2","3","4","5","6","7","8","9","0":
            seguridadNumero = true
            default:
            seguridadEspecial = true
        }
    }
    
    if contrasena.count >= 8{
        seguridadCount = true
    }
    if seguridadMinuscula && seguridadMayuscula && seguridadNumero && seguridadEspecial && seguridadCount{
            contrasenaValidaIngresada = true
    }else{
        alerta = "Por favor, introduce una contraseña válida, esta debe contener al menos 8 carácteres entre los cuales debe haber al menos una minúscula, una mayúscula, un número y un carácter especial"
    }
    
    if confirmacionContrasena == contrasena{
        confirmacionContrasenaIgrasada = true
    }else{
        alerta = "Las contraseñas no coinciden, verifícalo por favor"
    }
    
    if nombreIngresado && nombreValido && mailIngrasado && contrasenaValidaIngresada && confirmacionContrasenaIgrasada{
        return "OK"
    }else{
        return alerta
    }
}
