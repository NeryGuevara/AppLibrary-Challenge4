//
//  AddContentViewController.swift
//  AppLibrary-Challenge4
//
//  Created by Felipe Nery Guevara Guevara on 11/03/22.
//

import UIKit
import Combine

class AddContentViewController: UIViewController{
    
    let width = Constants.width
    let height = Constants.height
    
    lazy var imagenContenido : UIImage = UIImage()
    
    lazy var agradecimiento : UILabel = UILabel()
    lazy var titulo : UITextField = UITextField()
    lazy var autor : UITextField = UITextField()
    lazy var descripcionLabel : UILabel = UILabel()
    lazy var descripcion : UITextView = UITextView()
    lazy var obraLabel : UILabel = UILabel()
    lazy var obra : UITextView = UITextView()
    lazy var imagen : UIImageView = UIImageView()
    
    lazy var botonSubirImagen : UIButton = UIButton()
    lazy var labelSubirImagen : UILabel = UILabel()
    lazy var botonGuardado : UIButton = UIButton()
    lazy var labelGuardado : UILabel = UILabel()
    
    let addContentViewModel : AddContentviewModel = AddContentviewModel()
    
    private var cancellables: [AnyCancellable] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray6
        
        initUI()
        
        validation()
        validationPost()
    }
    
    func initUI(){
        agradecimiento = UILabel(frame: CGRect(x: width/10, y: height/12, width: 8*width/10, height: height/18))
        agradecimiento.text = Constants.thanksContent
        agradecimiento.font = .boldSystemFont(ofSize: 40)
        agradecimiento.adjustsFontSizeToFitWidth = true
        agradecimiento.backgroundColor = .clear
        agradecimiento.textColor = .orange
        
        view.addSubview(agradecimiento)
        
        titulo = UITextField(frame: CGRect(x: width/8, y: 2*height/12, width: 3*width/4, height: height/18))
        titulo.format()
        titulo.attributedPlaceholder = NSAttributedString(
            string: Constants.title,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        )
        
        view.addSubview(titulo)
        
        autor = UITextField(frame: CGRect(x: width/8, y: 3*height/12, width: 3*width/4, height: height/18))
        autor.format()
        autor.attributedPlaceholder = NSAttributedString(
            string: Constants.author,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        )
        
        view.addSubview(autor)
        
        descripcionLabel = UILabel(frame: CGRect(x: width/8, y: 4*height/12-5, width: width/3, height: height/28))
        descripcionLabel.font = .boldSystemFont(ofSize: 30)
        descripcionLabel.text = Constants.description
        descripcionLabel.textColor = .systemBlue
        descripcionLabel.adjustsFontSizeToFitWidth = true
        
        view.addSubview(descripcionLabel)
        
        descripcion = UITextView(frame: CGRect(x: width/8, y: 4*height/12+height/36, width: 3*width/4, height: height/9))
        descripcion.format()
        
        view.addSubview(descripcion)
        
        obraLabel = UILabel(frame: CGRect(x: width/8, y: 6*height/12-5, width: width/3, height: height/28))
        obraLabel.font = .boldSystemFont(ofSize: 30)
        obraLabel.text = Constants.work
        obraLabel.textColor = .systemBlue
        obraLabel.adjustsFontSizeToFitWidth = true
        
        view.addSubview(obraLabel)
        
        obra = UITextView(frame: CGRect(x: width/8, y: 6*height/12+height/36, width: 3*width/4, height: height/9))
        obra.format()
        
        view.addSubview(obra)
        
        imagen = UIImageView(frame: CGRect(x: width/8, y: 8*height/12, width: 3*width/8, height: 3*width/8))
        imagen.image = UIImage(named: "defaultImage")
        imagen.layer.borderColor = UIColor.systemBlue.cgColor
        imagen.layer.borderWidth = 1
        imagen.layer.cornerRadius = 5
        imagen.backgroundColor = .systemGray6
        imagen.isUserInteractionEnabled = true
        
        view.addSubview(imagen)
        
        botonSubirImagen = UIButton(frame: CGRect(x: width/2+width/16, y: 8*height/12, width: 5*width/16, height: height/18))
        botonSubirImagen.blueFormat()
        botonSubirImagen.addTarget(self, action: #selector(agregarImagen), for: .touchUpInside)
        
        view.addSubview(botonSubirImagen)
        
        labelSubirImagen = UILabel(frame: CGRect(x: width/32, y: 0, width: 8*width/32, height: height/18))
        labelSubirImagen.font = .boldSystemFont(ofSize: 24)
        labelSubirImagen.text = Constants.uploadImage
        labelSubirImagen.textColor = .white
        labelSubirImagen.adjustsFontSizeToFitWidth = true
        
        botonSubirImagen.addSubview(labelSubirImagen)
        
        botonGuardado = UIButton(frame: CGRect(x: width/2+width/16, y: 18*height/24, width: 5*width/16, height: height/12))
        botonGuardado.backgroundColor = .orange
        botonGuardado.layer.cornerRadius = 10
        botonGuardado.addTarget(self, action: #selector(subirPublicacion), for: .touchUpInside)
        
        view.addSubview(botonGuardado)
        
        labelGuardado = UILabel(frame: CGRect(x: width/32, y: 0, width: 8*width/32, height: height/12))
        labelGuardado.font = .boldSystemFont(ofSize: 24)
        labelGuardado.text = Constants.save
        labelGuardado.textColor = .white
        labelGuardado.adjustsFontSizeToFitWidth = true
        
        botonGuardado.addSubview(labelGuardado)
        
    }
    
    //suscriptor para validar el registro
    fileprivate func validation(){
        self.addContentViewModel
            .validationState
            .sink{ newAlertText in
                self.updateAlert(message: newAlertText)
            }
            .store(in: &cancellables)
    }
    
    //suscriptor para salir de la pantalla al terminar el proceso
    fileprivate func validationPost(){
        self.addContentViewModel
            .validationLogin
            .sink{ _ in
                self.loggingOccurred()
            }
            .store(in: &cancellables)
    }
    
    func updateAlert(message: String){
        let alert = UIAlertController(title: Constants.error, message: message, preferredStyle: .alert)
        let aceptar = UIAlertAction(title: Constants.accept, style: .default, handler: nil)
        alert.addAction(aceptar)
        self.present(alert, animated: true)
    }
    
    func loggingOccurred(){
        self.titulo.text = ""
        self.autor.text = ""
        self.descripcion.text = ""
        self.obra.text = ""
        self.imagen.image = UIImage(named: "defaultImage")
        dismiss(animated: true, completion: nil)
    }
    
    @objc func agregarImagen(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func redimensionarImagen(image: UIImage, targetSize: CGSize) -> UIImage{
        let size = image.size
        
        let widthRatio = targetSize.width / size.width
        let heigthRatio = targetSize.height / size.height
        
        var newSize: CGSize
        if widthRatio > heigthRatio {
            newSize = CGSize(width: size.width * heigthRatio, height: size.height * heigthRatio)
        }else{
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    @objc func subirPublicacion(){
        if let titulo = titulo.text, let autor = autor.text, let descripcion = descripcion.text, let obra = obra.text, let imagen = imagen.image{
            addContentViewModel.subirPost(titulo: titulo, autor: autor, descripcion: descripcion, obra: obra, imagen: imagen)
        }
    }
    

}

extension AddContentViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        let imagenTomada = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        
        imagenContenido = redimensionarImagen(image: (imagenTomada ?? UIImage(named: "defaultImage"))!, targetSize: CGSize(width: 200, height: 300))
        
        imagen.image = imagenContenido
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
}
