//
//  UIViewControllerExtension.swift
//  CTA
//
//  Created by casandra grullon on 3/16/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    private static func resetWindow(rootVC: UIViewController) {
        guard let scene = UIApplication.shared.connectedScenes.first, let sceneDelegate = scene.delegate as? SceneDelegate,
            let window = sceneDelegate.window  else {
            fatalError("could not reset window root view controller")
        }
        window.rootViewController = rootVC
        
    }
    
    public static func showViewController(storyboardName: String, viewcontrollerID: String) {
        
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let newVC = storyboard.instantiateViewController(identifier: viewcontrollerID)
        
        resetWindow(rootVC: newVC)
    }
}
