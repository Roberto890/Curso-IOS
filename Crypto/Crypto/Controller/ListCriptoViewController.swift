//
//  ListCriptoViewController.swift
//  Crypto
//
//  Created by Virtual Machine on 28/09/21.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import UIKit

class ListCriptoViewController: UIViewController, ImageServiceDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var imageManager = ImageService()
    var coinImages: [ImageModel] = []
    
    override func viewDidLoad() {
        print("teste")
        
        imageManager.delegate = self
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CriptoCell", bundle: nil), forCellWithReuseIdentifier: "CriptoCellReuse")
        
        imageManager.getCoinImages()
    }
    
    func didSucessImage(_ coinManager: ImageService, imagesModel: [ImageModel]) {
        DispatchQueue.main.async {
            self.coinImages = imagesModel
            self.collectionView.reloadData()
        }
    }
    
    func didFailedWithError(error: Error) {
        print(error)
    }
    
}

extension ListCriptoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coinImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CriptoCellReuse", for: indexPath) as! CriptoCell
        
        let url = URL(string: coinImages[indexPath.row].coinImage)!
            let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, _, _) in
                if let data = data {
                    DispatchQueue.main.async {
                        cell.coinImage.image = UIImage(data: data)
                    }
                }
            }
            dataTask.resume()

        cell.coinLabel.text = coinImages[indexPath.row].criptoType
        return cell
    }
}
