//
//  AddContentViewModel.swift
//  AppLibrary-Challenge4
//
//  Created by Felipe Nery Guevara Guevara on 31/03/22.
//

import Foundation
import Combine
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage


class AddContentviewModel{
    
    var ref: DatabaseReference?
    
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
    
    private func finishPost(){
        automaticLogin = true
    }
    
    func subirPost(titulo: String, autor: String, descripcion: String, obra: String, imagen: UIImage){
        ref = Database.database().reference()
        if titulo != "" && autor != "" && descripcion != "" && obra != "" && imagen != UIImage(named: "defaultImage"){
            //Usar el storage para la imagen
            let storage = Storage.storage().reference()
            let nombreImagen = UUID()
            let directorio = storage.child("imagenesPosts/\(nombreImagen)")
            let metadata = StorageMetadata()
            metadata.contentType = "image/png"
            
            directorio.putData(imagen.pngData()!, metadata: metadata) { (data, error) in
                if error == nil {
                    print("se guardo imagen")
                }else{
                    if let error = error?.localizedDescription{
                        print("error en firebase al cargar imagen", error)
                    }else{
                        print("error de codigo")
                    }
                }
            }
            //Usar la base de datos para la publicacion y relacionar la imagen del storage
            guard let idPost = ref?.childByAutoId().key else { return  }
            guard let idUser = Auth.auth().currentUser?.uid else { return }
            let campos = ["titulo": titulo,
                          "autor": autor,
                          "descripcion": descripcion,
                          "obra": obra,
                          "imagenObra": String(describing: directorio),
                          "idUser": idUser,
                          "idPost": idPost]
            ref?.child("posts").child(idPost).setValue(campos)
            finishPost()
        }else{
            newAlert(message: Constants.errorFill)
        }
    }
    
}
