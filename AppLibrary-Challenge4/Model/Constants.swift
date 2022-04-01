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
    
    static let welcome : String = NSLocalizedString("Welcome!", comment: "")
    static let enterEmail : String = NSLocalizedString("Email", comment: "")
    static let enterPassword : String = NSLocalizedString("Password", comment: "")
    static let enterPasswordConfirm : String = NSLocalizedString("Confirm password", comment: "")
    static let login : String = NSLocalizedString("Login", comment: "")
    static let register : String = NSLocalizedString("Are you new? Register here", comment: "")
    static let back : String = NSLocalizedString("< Back", comment: "")
    static let welcomeMessage : String = NSLocalizedString("You are just a few steps away from the ultimate experience", comment: "")
    static let registerTitle : String = NSLocalizedString("Register your information", comment: "")
    static let enterUserName : String = NSLocalizedString("User name", comment: "")
    static let enterBook : String = NSLocalizedString("Name of your first book", comment: "")
    static let createAccount : String = NSLocalizedString("Create account", comment: "")
    static let hello : String = NSLocalizedString("Hello,", comment: "")
    static let logOutlabel : String = NSLocalizedString("Aren't you? Log out", comment: "")
    static let logOutTitle : String = NSLocalizedString("Log out", comment: "")
    static let logOutMessage : String = NSLocalizedString("Are you sure you want to log out?", comment: "")
    static let accept : String = NSLocalizedString("Accept", comment: "")
    static let cancel : String = NSLocalizedString("Cancel", comment: "")
    static let nameNotFound : String = NSLocalizedString("Name not found", comment: "")
    static let error : String = NSLocalizedString("Error :(", comment: "")
    static let errorCount : String = NSLocalizedString("The data entered are invalid", comment: "")
    static let errorInternal : String = NSLocalizedString("Network error, please check your connection.", comment: "")
    static let showPass : String = NSLocalizedString("Show password", comment: "")
    static let showPasswords : String = NSLocalizedString("Show passwords", comment: "")
    static let addNewBookTitle : String = NSLocalizedString("Add new book", comment: "")
    static let errorBook : String = NSLocalizedString("Book not found", comment: "")
    static let ourContent : String = NSLocalizedString("Our content", comment: "")
    static let home : String = NSLocalizedString("Home", comment: "")
    static let authors : String = NSLocalizedString("Authors", comment: "")
    static let account : String = NSLocalizedString("Account", comment: "")
    static let search : String = NSLocalizedString("Search", comment: "")
    static let alertNameIntro : String = NSLocalizedString("Please enter your username", comment: "")
    static let alertNameBad : String = NSLocalizedString("The username entered is too short, please enter one with at least 4 characters.", comment: "")
    static let alertMailIntro : String = NSLocalizedString("Please enter a valid email address", comment: "")
    static let alertPassBad : String = NSLocalizedString("Please enter a valid password, it must contain at least 8 characters including at least one lowercase letter, one uppercase letter, one number and one special character.", comment: "")
    static let alertPassBadIntro : String = NSLocalizedString("Passwords do not match, please verify it", comment: "")
    static let thanksContent : String = NSLocalizedString("Thank you for your contribution", comment: "")
    static let title : String = NSLocalizedString("Title:", comment: "")
    static let author : String = NSLocalizedString("Author: ", comment: "")
    static let description : String = NSLocalizedString("Description:", comment: "")
    static let work : String = NSLocalizedString("The Work:", comment: "")
    static let uploadImage : String = NSLocalizedString("Upload image", comment: "")
    static let save : String = NSLocalizedString("Save content", comment: "")
    static let errorFill : String = NSLocalizedString("Please fill in all fields", comment: "")
    
}
