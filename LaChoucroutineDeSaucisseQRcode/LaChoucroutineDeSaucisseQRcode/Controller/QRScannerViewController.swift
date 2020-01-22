//
//  QRScannerViewController.swift
//  LaChoucroutineDeQRcode
//
//  Created by Bastien on 21/01/2020.
//  Copyright © 2020 Bastien. All rights reserved.
//

import UIKit

class QRScannerViewController: UIViewController {
    
    @IBOutlet weak var scannerView: QRScannerView! {
        didSet {
            scannerView.delegate = self
        }
    }
    
    //Bouton permettant de stopper / demarrer le flux video
    @IBOutlet weak var scanButton: UIButton! {
        didSet {
            scanButton.setTitle("STOP", for: .normal)
        }
    }
    

    var qrData: QRcode? = nil {
        didSet {
            if qrData != nil {
                self.performSegue(withIdentifier: "detailSeuge", sender: self)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
 
    //Apparition de la vue : début du scan vidéo
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if !scannerView.isRunning {
            scannerView.debutScan()
        }
    }
    
    //Disparition de la view : stop le scan
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if !scannerView.isRunning {
            scannerView.stopScan()
            scannerView.alreadyScannedOnce = false //permet de re-scanner quand on reviendra sur la view
        }
    }

    //Au clic sur le bouton
    @IBAction func scanButtonAction(_ sender: UIButton) {
        scannerView.isRunning ? scannerView.stopScan() : scannerView.debutScan()
        let buttonTitle = scannerView.isRunning ? "STOP" : "SCAN"
        sender.setTitle(buttonTitle, for: .normal)
    }
    
    //Permet de sauvegarder l'image dans la gallerie
    func writeImage(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            //Erreur
            presentAlert(withTitre: "erreur", message: "Tu t'es trompé de saucisse pour la choucroutine !")
            print(error)
        } else {
            //Sauvegarde de la photo effectuée
            presentAlert(withTitre: "Vive la choucroutine de saucisse !", message: "Choucroutine sauvegardée dans la galerie photo")
        }
    }
}

extension QRScannerViewController: QRScannerViewDelegate {
    
    //Permet la bascule du texte sur le bouton (scan / stop)
    func qrScanningDidStop() {
        let buttonTitle = scannerView.isRunning ? "STOP" : "SCAN"
        scanButton.setTitle(buttonTitle, for: .normal)
    }
    
    //Erreur dans le scan
    func qrScanningDidFail() {
        presentAlert(withTitre: "Error", message: "Echec du scan. Place ta choucroute autrement et réessaye frérot !")
    }
    
    //Scan réussi : affichage du contenu du QR Code + stockage de l'image
    func qrScanningSucceededWithCode(_ str: String?, andPhoto photo: UIImage?) {

        self.qrData = QRcode(code: str)
        if let photo = photo {
            writeImage(image: photo)
        }
    }
}


extension QRScannerViewController {
    //Segue pour passer à la vue 'detail'
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSeuge", let viewController = segue.destination as? DetailViewController {
            viewController.qrData = self.qrData
        }
    }
}

