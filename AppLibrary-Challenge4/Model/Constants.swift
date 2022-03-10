//
//  Constants.swift
//  AppLibrary-Challenge4
//
//  Created by Felipe Nery Guevara Guevara on 28/02/22.
//

import Foundation
import UIKit

/*Aquí irán todas los Strings que se muestren en la vista para tener un manejo màs eficiente de los mismo.
 Además ayudará a la traducción de la app a varios idiomas.
 */

struct Constants{
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
    static let welcome : String = "Welcome!"
    static let enterEmail : String = "Email"
    static let enterPassword : String = "Password"
    static let enterPasswordConfirm : String = "Confirm password"
    static let login : String = "Login"
    static let register : String = "Are you new? Register here"
    static let back : String = "< Back"
    static let welcomeMessage : String = "You are just a few steps away from the ultimate experience"
    static let registerTitle : String = "Register your information"
    static let enterUserName : String = "User name"
    static let createAccount : String = "Create account"
    static let hello : String = "Hello,"
    static let logOutlabel : String = "Aren't you? Log out"
    static let logOutTitle : String = "Log out"
    static let logOutMessage : String = "Are you sure you want to log out?"
    static let accept : String = "Accept"
    static let cancel : String = "Cancel"
    static let nameNotFound : String = "Name not found"
    static let error : String = "Error :("
    static let errorCount : String = "The data entered are invalid"
    static let errorInternal : String = "Internal error, we will work to fix it"
    static let showPass : String = "Show password"
    
}
