//
//  ContenidoTableViewCell.swift
//  AppLibrary-Challenge4
//
//  Created by Felipe Nery Guevara Guevara on 11/03/22.
//

import UIKit
import FirebaseStorage

class ContenidoTableViewCell: UITableViewCell {

    var width = UIScreen.main.bounds.width
    var heigth = UIScreen.main.bounds.height
    
    var stringAutor = "Autor: "
    var stringCategoria = "Categoria: "
    
    var ownContent = UIView()
    
    var nombreLibro = UILabel()
    var autor = UILabel()
    var categoria = UILabel()
    
    var imagenLibro = UIImageView()
    var flechaDetalle = UIImageView()
    
    var post : Posts = Posts(titulo: "", autor: "", descripcion: "", obra: "", imagenObra: "", idUser: "", idPost: "")
    
    init(post : Posts){
        
        super.init(style: .default, reuseIdentifier: nil)
        
        self.post = post
        self.backgroundColor = .clear
        
        initUI()
        
    }
    
    func initUI(){
        
        ownContent = UIView(frame: CGRect(x: 10, y: 5, width: width - 20, height: heigth/7 - 10))
        ownContent.backgroundColor = .white
        ownContent.layer.cornerRadius = 8
        
        self.addSubview(ownContent)
        
        nombreLibro = UILabel(frame: CGRect(x: (width-20)/4, y: 0, width: 3*(width-20)/4, height: (heigth/7 - 10)/3))
        nombreLibro.text = post.titulo
        nombreLibro.textAlignment = .left
        nombreLibro.font = .boldSystemFont(ofSize: 18)
        
        ownContent.addSubview(nombreLibro)
        
        autor = UILabel(frame: CGRect(x: (width-20)/4, y: (heigth/7 - 10)/3, width: 5*(width-20)/8, height: (heigth/7 - 10)/3))
        stringAutor += post.autor ?? "Autor no encontrado"
        autor.text = stringAutor
        autor.textAlignment = .left
        
        ownContent.addSubview(autor)
        
        if let urlFotoPerfil = post.imagenObra {
            let storageImagen = Storage.storage().reference(forURL: urlFotoPerfil)
            storageImagen.getData(maxSize: 1 * 1024 * 1024) { (data, error) in
                if let error = error?.localizedDescription {
                    print("fallo al descargar imagen", error)
                }else{
                    if let imagen = data {
                        self.imagenLibro.image = UIImage(data: imagen)
                    }
                }
            }
        }
        
        
        imagenLibro = UIImageView(frame: CGRect(x: heigth/63 - 5, y: heigth/63 - 5, width: 2*heigth/27, height: heigth/9))
        //imagenLibro.image = UIImage(named: libro?.imagen ?? "default")
        imagenLibro.contentMode = .scaleAspectFit //Hace que la imagen se ajusten en sus proporciones
        
        ownContent.addSubview(imagenLibro)
        
        flechaDetalle = UIImageView(frame: CGRect(x: 7*(width-20)/8, y: ((heigth/7 - 10)-((width-20)/12))/2, width: (width-20)/12, height: (width-20)/12))
        flechaDetalle.image = UIImage(named: "Flecha")
        
        ownContent.addSubview(flechaDetalle)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
