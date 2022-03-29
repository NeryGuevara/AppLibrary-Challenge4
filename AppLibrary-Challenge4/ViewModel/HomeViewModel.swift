//
//  HomeViewModel.swift
//  AppLibrary-Challenge4
//
//  Created by Felipe Nery Guevara Guevara on 28/03/22.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import Combine

class HomeViewModel{
    
    public var dataTableView = PassthroughSubject<[Posts],Never>()//declarando publisher
    public var reloadDataTableView = PassthroughSubject<Bool,Never>()//declarando publisher
    public var reloadUserName = PassthroughSubject<String,Never>()
    
    fileprivate var data: [Posts] {
        didSet{
            dataTableView.send(data)
        }
    }
    
    fileprivate var reload: Bool {
        didSet{
            reloadDataTableView.send(reload)
        }
    }
    
    fileprivate var name: String {
        didSet{
            reloadUserName.send(name)
        }
    }
    
    init() {
        self.data = []
        self.reload = false
        self.name = ""
    }
    
    private func newData(data: [Posts]){
        self.data = data
    }
    
    private func reloadData(){
        self.reload = true
    }
    
    private func reloadName(name: String){
        self.name = name
    }
    
    func selesctPosts(){
        
        var ref: DatabaseReference?
        
        ref = Database.database().reference()
        
        var postsList : [Posts] = []
        
        ref?.child("posts").observe(DataEventType.value) { (snapshot) in
            postsList.removeAll()
            for item in snapshot.children.allObjects as! [DataSnapshot] {
                let valores = item.value as? [String:AnyObject]
                let titulo = valores!["titulo"] as? String ?? ""
                let autor = valores!["autor"] as? String ?? ""
                let descripcion = valores!["descripcion"] as? String ?? ""
                let obra = valores!["obra"] as? String ?? ""
                let imagenObra = valores!["imagenObra"] as? String ?? ""
                let idUser = valores!["idUser"] as? String ?? ""
                let idPost = valores!["idPost"] as? String ?? ""
                
                let post = Posts(titulo: titulo, autor: autor, descripcion: descripcion, obra: obra, imagenObra: imagenObra, idUser: idUser, idPost: idPost)
                postsList.append(post)
                self.newData(data: postsList)
            }
            DispatchQueue.main.async {
                self.reloadData()
            }
        }
    }
    
    func recibirNombre(){
        var ref: DatabaseReference?
        ref = Database.database().reference()
        let userId = (Auth.auth().currentUser?.uid)!
        ref?.child("users").child(userId).observeSingleEvent(of: .value, with: { [self] (snatshop) in
            let value = snatshop.value as? NSDictionary
            let name = value?["nombre"] as? String ?? "Default"
            self.reloadName(name: name)
        })
    }
    
    func cerrarSesion(){
        try! Auth.auth().signOut()
    }
}
