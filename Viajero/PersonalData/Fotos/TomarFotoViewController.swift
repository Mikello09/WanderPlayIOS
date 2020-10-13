//
//  TomarFotoViewController.swift
//  Viajero
//
//  Created by Mikel Lopez on 07/01/2020.
//  Copyright © 2020 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation


class TomarFotoViewController: BaseViewController{
    
    @IBOutlet var cameraPreview: UIView!
    @IBOutlet var capturedImage: UIImageView!
    @IBOutlet var cerrarBoton: UIButton!
    @IBOutlet var takePhotoBoton: UIButton!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var rotateCameraButton: UIButton!
    
    var captureSession: AVCaptureSession!
    var stillImageOutput: AVCapturePhotoOutput!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    
    var photoTaken:Bool = false
    var originalImage: UIImage?
    var filtroSeleccionado: String = "Original"
    
    var ciFiltersName: [String] = ["Original","CIPhotoEffectChrome", "CIPhotoEffectFade", "CIPhotoEffectInstant", "CIPhotoEffectNoir", "CIPhotoEffectProcess", "CIPhotoEffectTonal", "CIPhotoEffectTransfer", "CISepiaTone"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        takePhotoBoton.layer.borderWidth = 5
        takePhotoBoton.layer.borderColor = UIColor.white.cgColor
        
        setUpCamera()
        
        
    }
    
    func setUpCamera(){
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .high
        guard let backCamera = AVCaptureDevice.default(for: AVMediaType.video)
            else {
                print("Unable to access back camera!")
                return
        }
        do {
            let input = try AVCaptureDeviceInput(device: backCamera)
            stillImageOutput = AVCapturePhotoOutput()
            if captureSession.canAddInput(input) && captureSession.canAddOutput(stillImageOutput) {
                captureSession.addInput(input)
                captureSession.addOutput(stillImageOutput)
                setupLivePreview()
            }
        }
        catch let error  {
            print("Error Unable to initialize back camera:  \(error.localizedDescription)")
        }
    }
    
    func setupLivePreview() {
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        videoPreviewLayer.videoGravity = .resizeAspectFill
        videoPreviewLayer.connection?.videoOrientation = .portrait
        cameraPreview.layer.addSublayer(videoPreviewLayer)
        
        DispatchQueue.global(qos: .userInitiated).async { //[weak self] in
            self.captureSession.startRunning()
            DispatchQueue.main.async {
                self.videoPreviewLayer.frame = self.cameraPreview.bounds
            }
        }
    }
    
    @IBAction func takePhoto(_ sender: UIButton) {
        let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        stillImageOutput.capturePhoto(with: settings, delegate: self)

    }
    
    @IBAction func cerrarClicked(_ sender: UIButton) {
        if photoTaken {
            capturedImage.image = nil
            capturedImage.isHidden = true
            collectionView.isHidden = true
            setUpCamera()
            photoTaken = false
            cerrarBoton.setImage(UIImage(named: "close_white"), for: .normal)
            takePhotoBoton.isHidden = false
            rotateCameraButton.setImage(UIImage(named: "rotate_camera"), for: .normal)
        } else {
           self.navigationController?.popViewController(animated: false)
        }
    }
    
    @IBAction func rotateClicked(_ sender: UIButton) {
        if photoTaken {
            if let imagen = capturedImage.image{
                //UIImageWriteToSavedPhotosAlbum(imagen, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
            }
        } else {
            //Change camera source
            if let session = captureSession {
                //Remove existing input
                guard let currentCameraInput: AVCaptureInput = session.inputs.first else {
                    return
                }

                //Indicate that some changes will be made to the session
                session.beginConfiguration()
                session.removeInput(currentCameraInput)

                //Get new input
                var newCamera: AVCaptureDevice! = nil
                if let input = currentCameraInput as? AVCaptureDeviceInput {
                    if (input.device.position == .back) {
                        newCamera = cameraWithPosition(position: .front)
                    } else {
                        newCamera = cameraWithPosition(position: .back)
                    }
                }

                //Add input to session
                var err: NSError?
                var newVideoInput: AVCaptureDeviceInput!
                do {
                    newVideoInput = try AVCaptureDeviceInput(device: newCamera)
                } catch let err1 as NSError {
                    err = err1
                    newVideoInput = nil
                }

                if newVideoInput == nil || err != nil {
                    print("Error creating capture device input: \(err?.localizedDescription)")
                } else {
                    session.addInput(newVideoInput)
                }

                //Commit all the configuration changes at once
                session.commitConfiguration()
            }
        }
    }
    
    func cameraWithPosition(position: AVCaptureDevice.Position) -> AVCaptureDevice? {
        let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .unspecified)
        for device in discoverySession.devices {
            if device.position == position {
                return device
            }
        }

        return nil
    }
}

extension TomarFotoViewController: AVCapturePhotoCaptureDelegate{
    
    func imageCaptured(imageData: Data){
        photoTaken = true
        cerrarBoton.setImage(UIImage(named: "white_back"), for: .normal)
        takePhotoBoton.isHidden = true
        rotateCameraButton.setImage(UIImage(named: "download"), for: .normal)
        
        self.captureSession.stopRunning()
        capturedImage.isHidden = false
        
        let image = UIImage(data: imageData)
        originalImage = image
        capturedImage.image = image
        
        prepareFilterViews()
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Swift.Error?) {
        guard let imageData = photo.fileDataRepresentation() else { return }
        imageCaptured(imageData: imageData)
    }
}

extension TomarFotoViewController: FiltroFotoDelegate, UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ciFiltersName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FiltroFotoView", for: indexPath) as! FiltroFotoView
        cell.configure(delegate: self, filtroName: ciFiltersName[indexPath.row], originalImage: originalImage, seleccionado: ciFiltersName[indexPath.row] == self.filtroSeleccionado)
        return cell
    }
    
    func prepareFilterViews(){
        collectionView.isHidden = false
        collectionView.reloadData()
    }
    
    func onFiltroClicked(filtroName: String) {
        if let imagenOriginal = originalImage{
            self.filtroSeleccionado = filtroName
            if filtroName != "Original"{
                capturedImage.applyFilter(filtroName: filtroName, imagen: imagenOriginal)
            } else {
                capturedImage.image = imagenOriginal
            }
            collectionView.reloadData()
        }
    }
    
}
