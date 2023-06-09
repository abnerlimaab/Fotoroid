//
//  FinalViewController.swift
//  Fotoroid
//
//  Created by Abner Lima on 22/04/23.
//

import UIKit
import Photos

enum AlertType {
    case notAuthorized
    case savedWithSuccess
}

class FinalViewController: UIViewController {
    
    @IBOutlet weak var ivPhoto: UIImageView!
    var image: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()

        ivPhoto.image = image
        ivPhoto.layer.borderWidth = 10
        ivPhoto.layer.borderColor = UIColor.white.cgColor
    }
    
    func saveToAlbum() {
        PHPhotoLibrary.shared().performChanges({
            let creationRequest = PHAssetChangeRequest.creationRequestForAsset(from: self.image)
            let addAssetRequest = PHAssetCollectionChangeRequest()
            addAssetRequest.addAssets([creationRequest.placeholderForCreatedAsset] as! NSArray)
            
        }) { (success, error) in
            if !success {
                print(error!.localizedDescription)
            } else {
                self.presentAlert(to: .savedWithSuccess)
            }
        }
    }
    
    func presentAlert(to type: AlertType) {
        let alert: UIAlertController
        
        switch type {
        case .savedWithSuccess:
            alert = UIAlertController(title: "Imagem salva!", message: "Sua imagem foi salva no Álbum de fotos", preferredStyle: .alert)
        case .notAuthorized:
            alert = UIAlertController(title: "ERRO", message: "Você precisa autorizar o acesso ao Álbum para poder salvar sua foto", preferredStyle: .alert)
        }
    
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    @IBAction func save(_ sender: UIButton) {
        PHPhotoLibrary.requestAuthorization { status in
            switch status {
            case .authorized:
                self.saveToAlbum()
            default:
                self.presentAlert(to: .notAuthorized)
            }
        }
    }
    
    @IBAction func restart(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
}
