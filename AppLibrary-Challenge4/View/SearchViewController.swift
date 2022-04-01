//
//  SearchViewController.swift
//  AppLibrary-Challenge4
//
//  Created by Felipe Nery Guevara Guevara on 11/03/22.
//

import UIKit
import Combine

class SearchViewController: UIViewController{

    let width = Constants.width
    let height = Constants.height
    
    lazy var topImage : UIImageView = UIImageView()
    lazy var linea : UIView = UIView()
    lazy var hola : UILabel = UILabel()
    lazy var nombre : UILabel = UILabel()
    lazy var botonCierre: UIButton = UIButton()
    lazy var labelBotonCierre : UILabel = UILabel()
    
    lazy var tabla : UITableView = UITableView()
    
    let searchViewModel : SearchViewModel = SearchViewModel()
    
    private var cancellables: [AnyCancellable] = []
    
    let searchContoller = UISearchController(searchResultsController: nil)
    
    var filtroPost : [Posts] = []
    
    override func viewDidLoad() {
        
        view.backgroundColor = .systemBackground
        
        super.viewDidLoad()
        
        definesPresentationContext = true
        
        initUI()
        tabla.delegate = self
        tabla.dataSource = self
        searchContoller.searchResultsUpdater = self
        tabla.tableHeaderView = searchContoller.searchBar
        
        searchViewModel.selesctPosts()
        
        receiveName()
        newData()
        reloadData()
        
    }
    
    //suscriptor para traer la data del tablaView
    fileprivate func newData(){
        self.searchViewModel
            .dataTableView
            .sink{ newList in
                self.filtroPost = newList
            }
            .store(in: &cancellables)
    }
    
    //suscriptor para saber cuando recargar la data de la tableView
    fileprivate func reloadData(){
        self.searchViewModel
            .reloadDataTableView
            .sink{ _ in
                self.tabla.reloadData()
            }
            .store(in: &cancellables)
    }
    
    //suscriptor para traer el nombre del usuario
    fileprivate func receiveName(){
        self.searchViewModel
            .reloadUserName
            .sink{ name in
                self.nombre.text = name
            }
            .store(in: &cancellables)
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
        searchViewModel.recibirNombre()
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
        
        tabla = UITableView(frame: CGRect(x: 0, y: 9*height/30, width: width, height: 18*height/30))
        tabla.backgroundColor = .systemGray5
        tabla.layer.cornerRadius = 20
        view.addSubview(tabla)
        
    }
    
    @objc func cierreSesion(){
        let alerta = UIAlertController(title: Constants.logOutTitle, message: Constants.logOutMessage, preferredStyle: .alert)
        let aceptar = UIAlertAction(title: Constants.accept, style: .default) { _ in
            self.searchViewModel.cerrarSesion()
            self.dismiss(animated: true, completion: nil)
        }
        let cancelar = UIAlertAction(title: Constants.cancel, style: .default, handler: nil)
        alerta.addAction(aceptar)
        alerta.addAction(cancelar)
        present(alerta, animated: true, completion: nil)
    }
    
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, UISearchBarDelegate{
    
    func updateSearchResults(for searchController: UISearchController) {
        searchViewModel.filtroContenido(buscador: self.searchContoller.searchBar.text!)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchContoller.isActive && searchContoller.searchBar.text != "" {
            return filtroPost.count
        }
        return filtroPost.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = ContenidoTableViewCell(post: filtroPost[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return height/7
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Estoy en la sección \(indexPath.section) en la celda \(indexPath.row)")
        
        let post = filtroPost[indexPath.row]
        let vc = DetallesLibroViewController(post: post)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
    }
    
}
