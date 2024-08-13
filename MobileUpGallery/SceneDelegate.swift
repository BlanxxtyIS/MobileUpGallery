//
//  SceneDelegate.swift
//  MobileUpGallery
//
//  Created by Марат Хасанов on 13.08.2024.
//

import UIKit
import VKID

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var vkid: VKID?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        do {
            vkid = try VKID(
                config: Configuration(
                    appCredentials: AppCredentials(
                        clientId: "52140947",
                        clientSecret: "ex1X9dLYIPljaUxLe0eU"
                    )
                )
            )
        } catch {
            preconditionFailure("Failed to initialize VKID: \(error)")
        }
        
        let viewController = ViewController(vkid: vkid!)
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        URLContexts.forEach { ctx in
            vkid?.open(url: ctx.url)
        }
    }
}


