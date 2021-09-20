//
//  ResultViewController.swift
//  Tipsy
//
//  Created by Virtual Machine on 20/09/21.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController{
    
    @IBOutlet weak var LblTotal: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    
    var billValue: String = ""
    var billMessage: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LblTotal.text = billValue
        lblMessage.text = billMessage
    }
    
    @IBAction func btnRecalculate(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
