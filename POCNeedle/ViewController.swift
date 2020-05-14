//
//  ViewController.swift
//  POCNeedle
//
//  Created by Felipe Correa on 5/14/20.
//  Copyright © 2020 Condor Labs S.A.S. All rights reserved.
//

import UIKit

struct User {
    let name: String
    let lastName: String
}

class UserControl {
    private(set) var userShown: Bool = false
    
    func setUserShown() {
        userShown = true
    }
    
    //Singleton 💥
    static let shared: UserControl = UserControl()
    
    private init() {
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func presentAction(_ sender: Any) {
        
        let user = User(name: "Testing", lastName: "User")
        
        let vc: UIViewController
        
        if UserControl.shared.userShown {
            vc = UserViewController(user: user, userControl: UserControl.shared)
        } else {
            vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "WelcomeUserDetailViewController")
            (vc as! WelcomeUserDetailViewController).user = user
        }
        let navigation = UINavigationController(rootViewController: vc)
        self.present(navigation, animated: true, completion: nil)
    }
}

class WelcomeUserDetailViewController: UIViewController {
    
    var user: User?
    
    override func viewDidLoad() {
       title = "Welcome User Detail"
    }
    
    @IBAction func showUserDetail(_ sender: Any) {
        guard let user = user else {
            fatalError("User not provided")
        }
        let userVC = UserViewController(user: user, userControl: UserControl.shared)
        self.navigationController?.pushViewController(userVC,
                                                      animated: true)
    }
}

class UserViewController: UIViewController {
    
    let user: User
    let userControl: UserControl
    
    init(user: User, userControl: UserControl) {
        self.user = user
        self.userControl = userControl
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        title = "User Detail"
        view.backgroundColor = .white
        setupUserInfoStack()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.userControl.setUserShown()
    }
    
    func setupUserInfoStack() {
        let stack = UIStackView()
        stack.alignment = .fill
        stack.axis = .vertical
        
        let label1 = UILabel()
        label1.text = "Name:  " + user.name
        
        let label2 = UILabel()
        label2.text = "Lastname:  " + user.lastName
        
        stack.addArrangedSubview(label1)
        stack.addArrangedSubview(label2)
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        
        stack.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}
