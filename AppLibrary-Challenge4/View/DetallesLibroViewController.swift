//
//  DetallesLibroViewController.swift
//  AppBiblioteca - Desafio2
//
//  Created by Felipe Nery Guevara Guevara on 25/01/22.
//

import UIKit
import Combine

class DetallesLibroViewController: UIViewController {
    
    var post : Posts = Posts(titulo: "", autor: "", descripcion: "", obra: "", imagenObra: "", idUser: "", idPost: "")
    
    init(post: Posts){
        super.init(nibName: nil, bundle: nil)
        
        self.post = post
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var topImage = UIImageView()
    lazy var linea = UIView()
    lazy var botonRegreso = UIButton()
    lazy var labelRegresoButton: UILabel = UILabel()
    
    lazy var width = Constants.width
    lazy var heigth = Constants.height
    
    lazy var contenedorLibro = UIView()
    lazy var contenedorDescripcion = UIView()
    lazy var contenedorAutor = UIView()
    
    lazy var libroImagen = UIImageView()
    lazy var nombreLibro = UILabel()
    var nombreAutor = UILabel()
    var nombreCategoria = UILabel()
    
    var descripcionLibro = UILabel()
    var contenedorBotones = UIView()
    var botonDescripcion = UILabel()
    
    var labelSobreAutor = UILabel()
    var nombreAutorGrande = UILabel()
    var descripcionAutor = UILabel()
    var fotoAutor = UIImageView()
    
    let detallesLibroViewModel = DetallesLibroViewModel()
    private var cancellables: [AnyCancellable] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray5
        
        initUI()
        
        receiveImage()
        
    }
    
    func initUI(){
        topImage = UIImageView(frame: CGRect(x: -20, y: -heigth/6, width: width*2, height: heigth/3))
        topImage.image = UIImage(named: "libros")
        
        view.addSubview(topImage)
        
        botonRegreso = UIButton(frame: CGRect(x: 20, y: heigth/12, width: 9*width/40, height: heigth/12))
        botonRegreso.backgroundColor = .clear
        botonRegreso.addTarget(self, action: #selector(regresoAction), for: .touchUpInside)
        
        view.addSubview(botonRegreso)
        
        labelRegresoButton = UILabel(frame: CGRect(x: 0, y: 0, width: 9*width/40, height: heigth/12))
        labelRegresoButton.text = Constants.back
        labelRegresoButton.textColor = .systemBlue
        labelRegresoButton.font = .boldSystemFont(ofSize: 35)
        labelRegresoButton.adjustsFontSizeToFitWidth = true
        
        botonRegreso.addSubview(labelRegresoButton)
        
        linea = UIView(frame: CGRect(x: width/2, y: heigth/6, width: width/2, height: heigth/200))
        linea.backgroundColor = .systemBlue
        
        view.addSubview(linea)
        
        contenedorLibro = UIView(frame: CGRect(x: 20, y: heigth/6 + 15*heigth/114, width: width - 40, height: 15*heigth/114))
        contenedorLibro.backgroundColor = .white
        contenedorLibro.layer.cornerRadius = 15
        
        view.addSubview(contenedorLibro)
        
        libroImagen = UIImageView(frame: CGRect(x: 5*heigth/228, y: (-10)*heigth/228, width: 25*heigth/171, height: 25*heigth/171))
        
        if let urlImagen = post.imagenObra {
            detallesLibroViewModel.recibirImagen(url: urlImagen)
        }
        contenedorLibro.addSubview(libroImagen)
        
        nombreLibro = UILabel(frame: CGRect(x: 5*(width-40)/12, y: 0, width: 7*(width-40)/12 - 10, height: 5*heigth/114))
        nombreLibro.text = post.titulo
        nombreLibro.textAlignment = .center
        nombreLibro.textColor = .systemBlue
        nombreLibro.font = .boldSystemFont(ofSize: 25)
        nombreLibro.adjustsFontSizeToFitWidth = true
        
        contenedorLibro.addSubview(nombreLibro)
        
        nombreAutor = UILabel(frame: CGRect(x: 5*(width-40)/12, y: 5*heigth/114, width: 7*(width-40)/12 - 5, height: 5*heigth/114))
        var stringAutor = Constants.author
        stringAutor += post.autor ?? ""
        nombreAutor.text = stringAutor
        nombreAutor.numberOfLines = 0
        nombreAutor.textAlignment = .center
        nombreAutor.adjustsFontSizeToFitWidth = true
        
        contenedorLibro.addSubview(nombreAutor)
        
        contenedorDescripcion = UIView(frame: CGRect(x: 20, y: heigth/6 + 35*heigth/114, width: width - 40, height: 25*heigth/114))
        contenedorDescripcion.backgroundColor = .white
        contenedorDescripcion.layer.cornerRadius = 15
        
        view.addSubview(contenedorDescripcion)
        
        contenedorBotones = UIView(frame: CGRect(x: 0, y: 0, width: width - 40, height: (25*heigth/114)/4))
        contenedorBotones.backgroundColor = .white
        contenedorBotones.layer.cornerRadius = 10
        contenedorBotones.layer.borderColor = UIColor.white.cgColor
        contenedorBotones.layer.borderWidth = 8
        
        contenedorDescripcion.addSubview(contenedorBotones)
        
        botonDescripcion = UILabel(frame: CGRect(x: 0, y: 0, width: (width-40)/2, height: (25*heigth/114)/4))
        botonDescripcion.textAlignment = .center
        botonDescripcion.text = Constants.description
        botonDescripcion.font = .systemFont(ofSize: 16)
        botonDescripcion.textColor = .systemBlue
        botonDescripcion.layer.cornerRadius = 10
        botonDescripcion.layer.borderColor = UIColor.systemBlue.cgColor
        botonDescripcion.layer.borderWidth = 1
        
        contenedorBotones.addSubview(botonDescripcion)
        
        descripcionLibro = UILabel(frame: CGRect(x: 20, y: (25*heigth/114)/4, width: width-80, height: 3*(25*heigth/114)/4 - 10))
        descripcionLibro.text = post.descripcion
        descripcionLibro.font = .systemFont(ofSize: 18)
        descripcionLibro.numberOfLines = 0
        descripcionLibro.textAlignment = .center
        descripcionLibro.adjustsFontSizeToFitWidth = true
        
        contenedorDescripcion.addSubview(descripcionLibro)
        
        
        contenedorAutor = UIView(frame: CGRect(x: 20, y: heigth/6 + 65*heigth/114, width: width - 40, height: 25*heigth/114))
        contenedorAutor.backgroundColor = .white
        contenedorAutor.layer.cornerRadius = 15
        
        view.addSubview(contenedorAutor)
        
        labelSobreAutor = UILabel(frame: CGRect(x: 20, y: 10, width: 4*(width-40)/5, height: (25*heigth/114)/5))
        labelSobreAutor.text = Constants.work
        labelSobreAutor.font = .systemFont(ofSize: 20)
        labelSobreAutor.textColor = .systemBlue
        
        contenedorAutor.addSubview(labelSobreAutor)
        
        descripcionAutor = UILabel(frame: CGRect(x: 20, y: 2*(25*heigth/114)/5, width: width - 80, height: 3*(25*heigth/114)/5-10))
        descripcionAutor.text = post.obra
        descripcionAutor.font = .systemFont(ofSize: 18)
        descripcionAutor.numberOfLines = 0
        descripcionAutor.adjustsFontSizeToFitWidth = true
        
        contenedorAutor.addSubview(descripcionAutor)
        
        
        
    }
    
    //Suscriptor para recibir la imagen
    fileprivate func receiveImage(){
        self.detallesLibroViewModel
            .reloadImage
            .sink{ imagenNew in
                self.libroImagen.image = imagenNew
            }
            .store(in: &cancellables)
    }
    
    @objc func regresoAction(){
        self.dismiss(animated: true, completion: nil)
    }
    
}

