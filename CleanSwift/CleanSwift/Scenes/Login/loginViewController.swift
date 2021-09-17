//
//  loginViewController.swift
//  CleanSwift
//
//  Created by Virtual Machine on 14/09/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol loginDisplayLogic: class{
  func displaySomething(viewModel: login.Login.ViewModel)
}

class loginViewController: UIViewController, loginDisplayLogic{
  var interactor: loginBusinessLogic?
  var router: (NSObjectProtocol & loginRoutingLogic & loginDataPassing)?

  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?){
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder){
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup(){
    let viewController = self
    let interactor = loginInteractor()
    let presenter = loginPresenter()
    let router = loginRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?){
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  // MARK: Do something
  
    @IBAction func loginButton(_ sender: UIButton) {
    
        doLogin()
    }
    
    //@IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var swtBiometric: UISwitch!
    @IBOutlet weak var swtEmail: UISwitch!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtError: UILabel!
    @IBOutlet weak var btnLogin: UIButton!
  
  func doLogin(){
    let request = login.Login.Request(login: txtUsername.text!, password: txtPassword.text!)
    interactor?.doLogin(request: request)
    
  }
  
  func displaySomething(viewModel: login.Login.ViewModel){
    btnLogin.setTitle(viewModel.user.cpf, for: .normal)
    DispatchQueue.main.async {
        self.router?.routeToStatement(segue: nil)
    }
  }
}
