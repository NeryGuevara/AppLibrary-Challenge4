//
//  DetallesLibroViewModel.swift
//  AppLibrary-Challenge4
//
//  Created by Felipe Nery Guevara Guevara on 31/03/22.
//

import Foundation
import Combine
import UIKit
import FirebaseStorage

class DetallesLibroViewModel{

    public var reloadImage = PassthroughSubject<UIImage,Never>()

    fileprivate var image: UIImage {
        didSet{
            reloadImage.send(image)
        }
    }

    init() {
        self.image = UIImage()
    }
    
    private func reloadNewImage(image: UIImage){
        self.image = image
    }
    
    func recibirImagen(url: String){
        let storageImagen = Storage.storage().reference(forURL: url)
        storageImagen.getData(maxSize: 1 * 1024 * 1024) { (data, error) in
            if let error = error?.localizedDescription {
                print("Fallo al descargar imagen:", error)
            }else{
                if let imagen = data {
                    self.reloadNewImage(image: UIImage(data: imagen) ?? UIImage())
                }
            }
        }
    }

}
