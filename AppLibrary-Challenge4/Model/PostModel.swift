//
//  PostModel.swift
//  AppLibrary-Challenge4
//
//  Created by Felipe Nery Guevara Guevara on 11/03/22.
//

import Foundation



class Posts {
    
    var titulo: String?
    var autor: String?
    var descripcion: String?
    var obra: String?
    var imagenObra: String?
    var idUser: String?
    var idPost: String?
    
    init(titulo: String?, autor: String?, descripcion: String?, obra: String?, imagenObra: String?, idUser: String?, idPost: String?){
        self.titulo = titulo
        self.autor = autor
        self.descripcion = descripcion
        self.obra = obra
        self.imagenObra = imagenObra
        self.idUser = idUser
        self.idPost = idPost
    }
    
}
