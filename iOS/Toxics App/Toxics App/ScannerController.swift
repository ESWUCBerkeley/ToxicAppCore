//
//  ScannerController.swift
//  Toxics App
//
//  Created by Legeng Liu on 3/30/17.
//  Copyright © 2017 test. All rights reserved.
//

import UIKit
import AVFoundation

class ScannerController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    var scannedBarcode: String?
    var captureSession = AVCaptureSession()
    var captureDevice: AVCaptureDevice?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    let supportedCodeTypes = [AVMetadataObjectTypeUPCECode,
                            AVMetadataObjectTypeEAN13Code,
                              AVMetadataObjectTypeQRCode]
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var bar: UIView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.isStatusBarHidden = true
        captureNewSession()
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: Barcode Scanner methods
    
    // bulk of the AVFoundation work below
    func captureNewSession() {
        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        if captureDevice != nil {
            do {
                try captureSession.addInput(AVCaptureDeviceInput(device: captureDevice))
                
                let captureMetadataOutput = AVCaptureMetadataOutput()
                captureSession.addOutput(captureMetadataOutput)
                
                captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                captureMetadataOutput.metadataObjectTypes = supportedCodeTypes
                
                if let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession) {
                    previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
                    previewLayer.frame = view.layer.bounds
                    view.layer.addSublayer(previewLayer)
                }
                
                captureSession.startRunning()
                view.bringSubview(toFront: messageLabel)
                view.bringSubview(toFront: bar)
                
            } catch {
                print("error: \(error.localizedDescription)")
            }
        }
    }
    
    

    
    // MARK: AVCaptureMetadataOutputObjectsDelegate methods
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        
        if metadataObjects == nil || metadataObjects.count == 0 {
            messageLabel.text = "No barcode detected."
            return
        }
        
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if metadataObj.stringValue != nil {
            scannedBarcode = metadataObj.stringValue
            messageLabel.text = scannedBarcode
            
            let alertController = UIAlertController.init(title: "Barcode Scanned", message: "Barcode: \(String(describing: scannedBarcode))", preferredStyle: .alert)
            let openAction = UIAlertAction(title: "Barcode Scanned", style: .default, handler: {(action) in
                self.performSegue(withIdentifier: "scannerToInfo", sender: nil)
            })
            
            alertController.addAction(openAction)
            self.present(alertController, animated: true, completion: nil)
            captureSession.stopRunning()
            
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? InfoViewController {
            dest.barcode = scannedBarcode
        }
    }
    

}
