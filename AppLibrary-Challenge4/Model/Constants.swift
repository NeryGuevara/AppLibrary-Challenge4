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
    static let enterPassword : String = "Password"
    static let enterPasswordConfirm : String = "Confirm password"
    static let login : String = "Login"
    static let register : String = "Are you new? Register here"
    static let back : String = "< Back"
    static let welcomeMessage : String = "You are just a few steps away from the ultimate experience"
    static let registerTitle : String = "Register your information"
    static let enterUserName : String = "User name"
    static let enterBook : String = "Name of your first book"
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
    static let errorInternal : String = "Network error, please check your connection."
    static let showPass : String = "Show password"
    static let showPasswords : String = "Show passwords"
    static let addNewBookTitle : String = "Add new book"
    static let errorBook : String = "Book not found"
    static let ourContent : String = "Our content"
    static let ourAuthors : String = "Our authors"
    static let home : String = "Home"
    static let authors : String = "Authors"
    static let account : String = "Account"
    static let search : String = "Search"
    static let alertNameIntro : String = "Please enter your username"
    static let alertNameBad : String = "The username entered is too short, please enter one with at least 4 characters."
    static let alertMailIntro : String = "Please enter a valid email address"
    static let alertPassBad : String = "Please enter a valid password, it must contain at least 8 characters including at least one lowercase letter, one uppercase letter, one number and one special character."
    static let alertPassBadIntro : String = "Passwords do not match, please verify it"
    static let thanksContent : String = "Thank you for your contribution"
    static let title : String = "Title"
    static let author : String = "Author"
    static let description : String = "Description:"
    static let work : String = "Work:"
    static let uploadImage : String = "Upload image"
    static let save : String = "Save content"
    static let errorFill : String = "Please fill in all fields"
}
