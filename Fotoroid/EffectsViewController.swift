//
//  EffectsViewController.swift
//  Fotoroid
//
//  Created by Abner Lima on 22/04/23.
//

import UIKit

class EffectsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var viLoading: UIView!
    @IBOutlet weak var ivPhoto: UIImageView!
    
    var image: UIImage!
    lazy var filterManager: FilterManager = {
        let filterManager = FilterManager(image: image)
        return filterManager
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        ivPhoto.image = image
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let filteredImage = filterManager.applyFilter(type: .comic)
        ivPhoto.image = filteredImage
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    

}
