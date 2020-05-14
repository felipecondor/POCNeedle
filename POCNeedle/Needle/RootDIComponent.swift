//
//  RootDIComponent.swift
//  POCNeedle
//
//  Created by Felipe Correa on 5/14/20.
//  Copyright © 2020 Condor Labs S.A.S. All rights reserved.
//

import Foundation
import NeedleFoundation

final class RootDIComponent: BootstrapComponent {
    var user: User {
        return shared { User(name: "Using Needle", lastName: "Rocks!") }
    }
    
    var userControl: UserControl {
        return shared { UserControl() }
    }
    
    var oneTitle: String {
        return shared { "Holi" }
    }
    
    var rootViewController: ViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ViewController") as! ViewController
        vc.userControl = userControl
        vc.welcomeVC = welcomeComponent
        vc.userController = userComponent
        
        return vc
    }
    
    var welcomeComponent: WelcomeComponent {
        return WelcomeComponent(parent: self)
    }
    
    var userComponent: UserComponent {
        return UserComponent(parent: self)
    }
}

protocol WelcomeViewControllerBuilder {
    var welcomeViewController: WelcomeUserDetailViewController { get }
}

final class WelcomeComponent: Component<EmptyDependency>, WelcomeViewControllerBuilder {
    var welcomeViewController: WelcomeUserDetailViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "WelcomeUserDetailViewController") as! WelcomeUserDetailViewController
        vc.userControllerBuilder = userDetailComponent
        return vc
    }
    
    var userDetailComponent: UserComponent {
        return UserComponent(parent: self)
    }
}

// MARK: - UserDetail

protocol UserDetailViewControllerBuilder {
    var userDetailViewController: UserViewController { get }
}

protocol UserDependecy: Dependency {
    var user: User { get }
    var userControl: UserControl { get }
    var oneTitle: String { get }
}

final class UserComponent: Component<UserDependecy>, UserDetailViewControllerBuilder {
    var userDetailViewController: UserViewController {
        return UserViewController(user: dependency.user, userControl: dependency.userControl)
    }
}
