//
//  ListCriptoViewController.swift
//  Crypto
//
//  Created by Virtual Machine on 28/09/21.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import UIKit

//protocol ListCriptoViewControllerDelegate {
//    func callSegueFromCell(data txtLabel: String)
//}

class ListCriptoViewController: UIViewController, ImageServiceDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var allCoinImages: [ImageModel] = []
    var imageManager = ImageService()
    var coinImages: [ImageModel] = []
    
    override func viewDidLoad() {
        print("teste")
        
        searchBar.delegate = self
        imageManager.delegate = self
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CriptoCell", bundle: nil), forCellWithReuseIdentifier: "CriptoCellReuse")
        
        imageManager.getCoinImages()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    func didSucessImage(_ coinManager: ImageService, imagesModel: [ImageModel]) {
        DispatchQueue.main.async {
            self.allCoinImages = imagesModel
            self.coinImages = imagesModel
            self.collectionView.reloadData()
        }
    }
    
    func didFailedWithError(error: Error) {
        print(error)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "coinDetailsSegue" {
            if let row = sender as? Int {
                let destinationVC = segue.destination as! CoinViewController
                destinationVC.coinValues = coinImages[row]
            }
        }
    }
    
}

extension ListCriptoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coinImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CriptoCellReuse", for: indexPath) as! CriptoCell

        let urlImage = coinImages[indexPath.row].coinImage
        imageManager.loadImage(urlImage: urlImage, completionHandler: { result in
            DispatchQueue.main.async {
                cell.coinImage.image = result
            }
            
        })
        
        cell.coinLabel.text = coinImages[indexPath.row].criptoType
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "coinDetailsSegue", sender: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let size = CGSize(width: (collectionView.frame.size.width / 2), height: 128)

        return size
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        coinImages = allCoinImages
        if searchText != "" {
            
            let filterCoinImages: [ImageModel] = coinImages
            let filteredCoinList = filterCoinImages.filter{$0.criptoType.localizedCaseInsensitiveContains(searchText)}
            
            coinImages = filteredCoinList
        }
            
        collectionView.reloadData()
    }
    
}
