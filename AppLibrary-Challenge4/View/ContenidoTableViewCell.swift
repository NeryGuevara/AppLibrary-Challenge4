//
//  ContenidoTableViewCell.swift
//  AppLibrary-Challenge4
//
//  Created by Felipe Nery Guevara Guevara on 11/03/22.
//

import UIKit
import Combine

class ContenidoTableViewCell: UITableViewCell {

    var width = UIScreen.main.bounds.width
    var heigth = UIScreen.main.bounds.height
    
    var stringAutor = Constants.author
    
    var ownContent = UIView()
    
    var nombreLibro = UILabel()
    var autor = UILabel()
    var categoria = UILabel()
    
    var imagenLibro = UIImageView()
    var flechaDetalle = UIImageView()
    
    let contenidoTableViewCellViewModel = ContenidoTableViewCellViewModel()
    private var cancellables: [AnyCancellable] = []
    
    var post : Posts = Posts(titulo: "", autor: "", descripcion: "", obra: "", imagenObra: "", idUser: "", idPost: "")
    
    init(post : Posts){
        
        super.init(style: .default, reuseIdentifier: nil)
        
        self.post = post
        self.backgroundColor = .clear
        
        initUI()
        receiveImage()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        stringAutor += post.autor ?? "ERROR"
        autor.text = stringAutor
        autor.textAlignment = .left
        
        ownContent.addSubview(autor)
        
        if let urlImagen = post.imagenObra {
            contenidoTableViewCellViewModel.recibirImagen(url: urlImagen)
        }
        
        imagenLibro = UIImageView(frame: CGRect(x: heigth/63 - 5, y: heigth/63 - 5, width: heigth/9, height: heigth/9))
        ownContent.addSubview(imagenLibro)
        
        flechaDetalle = UIImageView(frame: CGRect(x: 7*(width-20)/8, y: ((heigth/7 - 10)-((width-20)/12))/2, width: (width-20)/12, height: (width-20)/12))
        flechaDetalle.image = UIImage(named: "flecha")
        
        ownContent.addSubview(flechaDetalle)
        
    }
    
    //Suscriptor para recibir la imagen
    fileprivate func receiveImage(){
        self.contenidoTableViewCellViewModel
            .reloadImage
            .sink{ imagenNew in
                self.imagenLibro.image = imagenNew
            }
            .store(in: &cancellables)
    }

}
