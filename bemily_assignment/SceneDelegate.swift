//
//  SceneDelegate.swift
//  bemily_assignment
//
//  Created by 김동혁 on 2022/09/26.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        window?.rootViewController = BemilyDetailViewController()
        window?.backgroundColor = .systemBackground
        window?.makeKeyAndVisible()
    }
}
