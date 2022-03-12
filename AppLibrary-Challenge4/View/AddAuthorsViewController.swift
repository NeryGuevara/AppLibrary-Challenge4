//
//  AddAuthorsViewController.swift
//  AppLibrary-Challenge4
//
//  Created by Felipe Nery Guevara Guevara on 11/03/22.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class AddAuthorsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var ref: DatabaseReference?
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        view.backgroundColor = .systemBackground
        
        initUI()
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
            string: "Name",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        )
        
        view.addSubview(titulo)
        
        autor = UITextField(frame: CGRect(x: width/8, y: 3*height/12, width: 3*width/4, height: height/18))
        autor.format()
        autor.attributedPlaceholder = NSAttributedString(
            string: "Tems",
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
        
        imagen = UIImageView(frame: CGRect(x: width/8, y: 8*height/12, width: 5*height/36, height: 5*height/24))
        imagen.layer.borderColor = UIColor.systemBlue.cgColor
        imagen.layer.borderWidth = 1
        imagen.layer.cornerRadius = 5
        imagen.backgroundColor = .systemGray6
        imagen.isUserInteractionEnabled = true
        
        view.addSubview(imagen)
        
        botonSubirImagen = UIButton(frame: CGRect(x: width/2, y: 8*height/12, width: 3*width/8, height: height/18))
        botonSubirImagen.blueFormat()
        botonSubirImagen.addTarget(self, action: #selector(agregarImagen), for: .touchUpInside)
        
        view.addSubview(botonSubirImagen)
        
        labelSubirImagen = UILabel(frame: CGRect(x: width/16, y: 0, width: width/4, height: height/18))
        labelSubirImagen.font = .boldSystemFont(ofSize: 30)
        labelSubirImagen.text = Constants.uploadImage
        labelSubirImagen.textColor = .white
        labelSubirImagen.adjustsFontSizeToFitWidth = true
        
        botonSubirImagen.addSubview(labelSubirImagen)
        
        botonGuardado = UIButton(frame: CGRect(x: width/2, y: 18*height/24, width: 3*width/8, height: height/8))
        botonGuardado.backgroundColor = .orange
        botonGuardado.layer.cornerRadius = 10
        botonGuardado.addTarget(self, action: #selector(subirPublicacion), for: .touchUpInside)
        
        view.addSubview(botonGuardado)
        
        labelGuardado = UILabel(frame: CGRect(x: width/16, y: 0, width: width/4, height: height/10))
        labelGuardado.font = .boldSystemFont(ofSize: 30)
        labelGuardado.text = Constants.save
        labelGuardado.textColor = .white
        labelGuardado.adjustsFontSizeToFitWidth = true
        
        botonGuardado.addSubview(labelGuardado)
        
        
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        let imagenTomada = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        
        imagenContenido = redimensionarImagen(image: (imagenTomada ?? UIImage(named: "defaultImage"))!, targetSize: CGSize(width: 200.0, height: 300.0))
        
        imagen.image = imagenContenido
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    @objc func subirPublicacion(){
        if let titulo = titulo.text, let autor = autor.text, let descripcion = descripcion.text, let obra = obra.text, let imagen = imagen.image{
            if titulo != "" && autor != "" && descripcion != "" && obra != "" && imagen != UIImage(){
                //Usar el storage para la imagen
                let storage = Storage.storage().reference()
                let nombreImagen = UUID()
                let directorio = storage.child("imagenesPosts/\(nombreImagen)")
                let metadata = StorageMetadata()
                metadata.contentType = "image/png"
                
                directorio.putData(imagenContenido.pngData()!, metadata: metadata) { (data, error) in
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
                let campos = ["nombre": titulo,
                              "temas": autor,
                              "descripcion": descripcion,
                              "obras": obra,
                              "imagenAutor": String(describing: directorio),
                              "idUser": idUser,
                              "idPost": idPost]
                ref?.child("posts").child(idPost).setValue(campos)
                self.titulo.text = ""
                self.autor.text = ""
                self.descripcion.text = ""
                self.obra.text = ""
                self.imagen.image = UIImage()
                dismiss(animated: true, completion: nil)
            }else{
                let alert = UIAlertController(title: Constants.error, message: Constants.errorFill, preferredStyle: .alert)
                let aceptar = UIAlertAction(title: Constants.accept, style: .default, handler: nil)
                alert.addAction(aceptar)
                present(alert, animated: true, completion: nil)
            }
        }
    }
    

}
