//
//  AccountViewModel.swift
//  AppLibrary-Challenge4
//
//  Created by Felipe Nery Guevara Guevara on 31/03/22.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import Combine

class AccountViewModel{
    
    public var reloadUserName = PassthroughSubject<String,Never>()
    public var reloadUserEmail = PassthroughSubject<String,Never>()
    
    fileprivate var name: String {
        didSet{
            reloadUserName.send(name)
        }
    }
    
    fileprivate var email: String {
        didSet{
            reloadUserEmail.send(email)
        }
    }
    
    init() {
        self.name = ""
        self.email = ""
    }
    
    private func reloadName(name: String){
        self.name = name
    }
    
    private func reloadEmail(email: String){
        self.email = email
    }
    
    func recibirInfoPerfil(){
        var ref: DatabaseReference?
        ref = Database.database().reference()
        let userId = (Auth.auth().currentUser?.uid)!
        ref?.child("users").child(userId).observeSingleEvent(of: .value, with: { [self] (snatshop) in
            let value = snatshop.value as? NSDictionary
            let name = value?["nombre"] as? String ?? "ERROR"
            let email = value?["email"] as? String ?? "ERROR"
            self.reloadName(name: name)
            self.reloadEmail(email: email)
        })
    }
    
    func cerrarSesion(){
        try! Auth.auth().signOut()
    }
    
    
}
