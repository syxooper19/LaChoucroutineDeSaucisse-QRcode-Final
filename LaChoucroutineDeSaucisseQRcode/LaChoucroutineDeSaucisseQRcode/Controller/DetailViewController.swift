//
//  DetailViewController.swift
//  LaChoucroutineDeQRcode
//
//  Created by Bastien on 21/01/2020.
//  Copyright © 2020 Bastien. All rights reserved.
//
import UIKit
import WebKit


class DetailViewController: UIViewController, WKUIDelegate {


    
    @IBOutlet weak var urlLabel: UILabel!
        
    var qrData: QRcode?

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        urlLabel.text = qrData?.code
        
        //Copier le contenu du QR Code dans le presse papier
        UIPasteboard.general.string = urlLabel.text
        showToast(message : "Texte copié dans le presse papier")

        //Création de l'URL + chargement dans la WebView
        let myURL = URL(string: qrData?.code ?? "")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }

    
    //Le bouton permet d'ouvrir le lien dans Safari
    @IBAction func openInWebAction(_ sender: Any) {
        if let url = URL(string: qrData?.code ?? ""), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:])
        } else {
            showToast(message : "URL Invalide")
        }
    }
    
    
    


}
