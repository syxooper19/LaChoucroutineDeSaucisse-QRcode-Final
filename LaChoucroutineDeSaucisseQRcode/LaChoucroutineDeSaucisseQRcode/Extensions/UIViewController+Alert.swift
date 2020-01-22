//
//  UIViewController+Alert.swift
//  LaChoucroutineDeQRcode
//
//  Created by Bastien on 21/01/2020.
//  Copyright © 2020 Bastien. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    
    func presentAlert(withTitre titre: String, message : String) {
        let alertController = UIAlertController(title: titre, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
            print("Bouton OK")
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    func showToast(message : String, seconds: Double = 2.0) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        
        self.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
}
