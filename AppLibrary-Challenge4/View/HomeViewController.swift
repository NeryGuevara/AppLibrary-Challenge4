//
//  LoginViewController.swift
//  AppLibrary-Challenge4
//
//  Created by Felipe Nery Guevara Guevara on 01/03/22.
//

import UIKit
import Combine

class HomeViewController: UIViewController{
    
    let width = Constants.width
    let height = Constants.height
    
    lazy var topImage : UIImageView = UIImageView()
    lazy var linea : UIView = UIView()
    lazy var hola : UILabel = UILabel()
    lazy var nombre : UILabel = UILabel()
    lazy var botonCierre: UIButton = UIButton()
    lazy var labelBotonCierre : UILabel = UILabel()
    lazy var contenedorLabel : UIView = UIView()
    lazy var misLibrosLabel : UILabel = UILabel()
    lazy var botonAdd : UIButton = UIButton()
    lazy var labelBotonAdd : UILabel = UILabel()
    
    lazy var librosTableView : UITableView = UITableView()
    
    let homeViewModel : HomeViewModel = HomeViewModel()
    var postsList : [Posts] = []
    
    private var cancellables: [AnyCancellable] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        initUI()
        
        librosTableView.delegate = self
        librosTableView.dataSource = self
        
        receiveName()
        newData()
        reloadData()
        
        homeViewModel.selesctPosts()
        
    }
    
    func initUI(){
        
        topImage = UIImageView(frame: CGRect(x: -20, y: -height/6, width: width*2, height: height/3))
        topImage.image = UIImage(named: "libros")
        
        view.addSubview(topImage)
        
        hola = UILabel(frame: CGRect(x: 20, y: height/15, width: width/5, height: 40))
        hola.text = Constants.hello
        hola.font = .boldSystemFont(ofSize: 40)
        hola.adjustsFontSizeToFitWidth = true
        hola.textColor = UIColor.orange
        hola.textAlignment = .left
        
        view.addSubview(hola)
        
        nombre = UILabel(frame: CGRect(x: 20, y: height/15 + 40, width: width-40, height: 42))
        homeViewModel.recibirNombre()
        nombre.font = .boldSystemFont(ofSize: 33)
        nombre.textColor = UIColor.systemBlue
        nombre.textAlignment = .left
        
        view.addSubview(nombre)
        
        linea = UIView(frame: CGRect(x: width/2 - 20, y: 42, width: width/2, height: height/200))
        linea.backgroundColor = .systemBlue
        
        nombre.addSubview(linea)
        
        botonCierre = UIButton(frame: CGRect(x: 17*width/24 - 20, y: height/36, width: 7*width/24, height: height/12))
        botonCierre.backgroundColor = .clear
        botonCierre.addTarget(self, action: #selector(cierreSesion), for: .touchUpInside)
        
        view.addSubview(botonCierre)
        
        labelBotonCierre = UILabel(frame: CGRect(x: 0, y: 0, width: 7*width/24, height: height/12))
        labelBotonCierre.text = Constants.logOutlabel
        labelBotonCierre.textColor = .systemBlue
        labelBotonCierre.font = .boldSystemFont(ofSize: 24)
        labelBotonCierre.numberOfLines = 0
        labelBotonCierre.textAlignment = .center
        labelBotonCierre.adjustsFontSizeToFitWidth = true
        
        botonCierre.addSubview(labelBotonCierre)
    
        librosTableView = UITableView(frame: CGRect(x: 0, y: 9*height/30, width: width, height: 18*height/30))
        librosTableView.backgroundColor = .systemGray5
        librosTableView.layer.cornerRadius = 20
        view.addSubview(librosTableView)
        
        contenedorLabel = UIView(frame: CGRect(x: width/6, y: 7*height/30, width: 2*width/3, height: height/20))
        contenedorLabel.layer.cornerRadius = 10
        contenedorLabel.backgroundColor = .systemBlue
        contenedorLabel.layer.borderColor = UIColor.systemBlue.cgColor
        view.addSubview(contenedorLabel)
        
        misLibrosLabel = UILabel(frame: CGRect(x: width/20, y: 0, width: 8*width/20, height: height/20))
        misLibrosLabel.text = Constants.ourContent
        misLibrosLabel.font = .boldSystemFont(ofSize: 40)
        misLibrosLabel.textColor = .white
        misLibrosLabel.adjustsFontSizeToFitWidth = true
        misLibrosLabel.textAlignment = .center
        
        contenedorLabel.addSubview(misLibrosLabel)
        
        botonAdd = UIButton(frame: CGRect(x: width/2, y: height/200, width: width/6 - width/20, height: height/20 - height/100))
        botonAdd.layer.borderWidth = 2
        botonAdd.layer.cornerRadius = 10
        botonAdd.layer.borderColor = UIColor.white.cgColor
        botonAdd.addTarget(self, action: #selector(tabButtonPushed), for: .touchUpInside)
        
        contenedorLabel.addSubview(botonAdd)
        
        labelBotonAdd = UILabel(frame: CGRect(x: 0, y: 0, width: width/6 - width/20, height:  height/20 - height/100))
        labelBotonAdd.font = .boldSystemFont(ofSize: 100)
        labelBotonAdd.adjustsFontSizeToFitWidth = true
        labelBotonAdd.text = "+"
        labelBotonAdd.textColor = .white
        labelBotonAdd.textAlignment = .center
        labelBotonAdd.backgroundColor = .clear
        
        botonAdd.addSubview(labelBotonAdd)
        
    }
    
    //suscriptor para traer la data del tablaView
    fileprivate func newData(){
        self.homeViewModel
            .dataTableView
            .sink{ newList in
                self.postsList = newList
            }
            .store(in: &cancellables)
    }
    
    //suscriptor para saber cuando recargar la data de la tableView
    fileprivate func reloadData(){
        self.homeViewModel
            .reloadDataTableView
            .sink{ _ in
                self.librosTableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    //suscriptor para traer el nombre del usuario
    fileprivate func receiveName(){
        self.homeViewModel
            .reloadUserName
            .sink{ name in
                self.nombre.text = name
            }
            .store(in: &cancellables)
    }
    
    @objc private func tabButtonPushed() {
        let vc : UIViewController = AddContentViewController()
        vc.modalPresentationStyle = .popover
        present(vc, animated: true, completion: nil)
    }
    
    @objc func cierreSesion(){
        let alerta = UIAlertController(title: Constants.logOutTitle, message: Constants.logOutMessage, preferredStyle: .alert)
        let aceptar = UIAlertAction(title: Constants.accept, style: .default) { _ in
            self.homeViewModel.cerrarSesion()
            self.dismiss(animated: true, completion: nil)
        }
        let cancelar = UIAlertAction(title: Constants.cancel, style: .default, handler: nil)
        alerta.addAction(aceptar)
        alerta.addAction(cancelar)
        present(alerta, animated: true, completion: nil)
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(postsList.count)
        return postsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = ContenidoTableViewCell(post: postsList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return height/7
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let post = postsList[indexPath.row]
        let vc = DetallesLibroViewController(post: post)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
    }
    
}
