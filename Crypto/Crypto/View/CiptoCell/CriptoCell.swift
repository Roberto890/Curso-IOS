//
//  CollectionViewCell.swift
//  Crypto
//
//  Created by Virtual Machine on 28/09/21.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import UIKit

class CriptoCell: UICollectionViewCell {

    @IBOutlet weak var coinImage: UIImageView!
    @IBOutlet weak var coinLabel: UILabel!
    
//    var delegate: ListCriptoViewControllerDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

//    @IBAction func PressedCoin(_ sender: UIButton) {
//        let mydata = coinLabel.text!
//        if(self.delegate != nil){
//            self.delegate.callSegueFromCell(data: mydata)
//        }
//    }
    
}
