//
//  ViewControllerAppreciation.swift
//  minf*ness
//
//  Created by Adam Tollin on 2016-11-15.
//  Copyright © 2016 Adam Tollin. All rights reserved.
//

import UIKit
import AVFoundation

struct shade{
    let info     : String!
    let response : String!
    let type     : Int!
}



class ViewControllerAppreciation: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, AVCapturePhotoCaptureDelegate {
    
    @IBOutlet var btnSave: UIBarButtonItem!
    
    
    var shadeArray = [shade]()
    
    @IBOutlet var lblShade: UILabel!
    
    @IBOutlet var cameraView: UIView!
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var blurEffect: UIVisualEffectView!
  
    @IBOutlet var btnTakePhoto: UIButton!
    
    @IBOutlet var alertView: UIView!
    
    @IBOutlet var btnDismiss: UIButton!
    
    
    var captureSession       : AVCaptureSession?
    var sessionOutput        : AVCapturePhotoOutput?
    var sessionOutputSetting : AVCapturePhotoSettings?
    var previewLayer         : AVCaptureVideoPreviewLayer?
    var frontCamera          : Bool = true
    
    var photoTaken = Bool()
    var randomNum : Int!
    
    @IBAction func takephoto(_ sender: Any) {
        if photoTaken == false
        {
            //self.imageView.isHidden = false
            photoTaken = true
            btnTakePhoto.isHidden = true
            alertView.isHidden = false
            
            
            btnTakePhoto.setTitle("Retake", for: .normal)
            didPressTakePhoto()
            
            randomNum = Int(arc4random_uniform(UInt32(shadeArray.count)))
            
            lblShade.text = shadeArray[randomNum].info
            btnDismiss.setTitle(shadeArray[randomNum].response, for: .normal)
            btnDismiss.isHidden = true
            if(shadeArray[randomNum].type == 1){
                blurEffect.isHidden = false
            }
           
            
            
            //photoTakenAlert()
         
        }
        else {
            self.imageView.isHidden = true
            photoTaken = false
            btnTakePhoto.setTitle("", for: .normal)
            alertView.isHidden = true
            blurEffect.isHidden = true
            btnSave.isEnabled = false
        }
        
    }
    @IBAction func dismissAlert(_ sender: Any) {
        
        if(shadeArray[randomNum].type == 2){
            self.imageView.isHidden = true
            photoTaken = false
            
            btnTakePhoto.setTitle("", for: .normal)
            alertView.isHidden = true
            blurEffect.isHidden = true
        }
        else{
            btnSave.isEnabled = true
        }
        btnDismiss.setTitle("", for: .normal)
        alertView.isHidden = true
        btnDismiss.isHidden = true
        btnTakePhoto.isHidden = false
    }
    
    func didPressTakePhoto(){
        if let videoConnection = sessionOutput?.connection(withMediaType: AVMediaTypeVideo){
            videoConnection.videoOrientation = AVCaptureVideoOrientation.portrait
            
            let settings            = AVCapturePhotoSettings()
            let previewPixelType    = settings.availablePreviewPhotoPixelFormatTypes.first!
            let previewFormat       = [kCVPixelBufferPixelFormatTypeKey as String: previewPixelType,
                                       kCVPixelBufferWidthKey           as String: 160,
                                       kCVPixelBufferHeightKey          as String: 160,
                                      ]
            settings.previewPhotoFormat = previewFormat
            sessionOutput?.capturePhoto(with: settings, delegate: self)
            
            
        }
    }
    
    func photoTakenAlert(){
        let alertController = UIAlertController(title: "Retake?", message: "Sorry my dear but, that picture will sashay away", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default , handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.previewLayer?.frame = self.cameraView.bounds
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shadeArray = [shade(info: "Oh dear, your are beautiful and by you I mean your peronality!", response: "Thank You",type: 0 ),
                      shade(info: "Honey, Have you heard of a invention called make-up? I think that would make wounders! ",response: "Thank You", type: 0  ),
                      shade(info: "Choices!? You made a choice today when you walk out the door, think about that", response: "I Will", type: 0 ),
                      shade(info: "Wow you look perfect today. You realy makes me shine",response: "Thank You", type: 0 ),
                      shade(info: "You are really something extra! It's facination how your mother can love that face", response: "Okay",type: 0 ),
                      shade(info: "I fixed your picture for you! I think it lookes great now, you're welcome", response: "Thank You", type: 1 ),
                      shade(info: "Mirror mirror on the wall who's the fairest of them all? Next question.. ", response: "Okay", type: 0 ),
                      shade(info: "Mirror mirror on the wall who's the fairest of them all? The person next to you looks like a good candidate ", response: "Okay", type: 0 ),
                      shade(info: "You have really.. round eyes", response: "Thank You", type: 0 ),
                      shade(info: "I think your face looks very.. symmetric ", response: "Thank You", type: 0 ),
                      shade(info: "Oh dear I think we'll do a retake, yes thats's a good idea", response: "Let's do it", type: 2 ),
                      shade(info: "You are like the sun, you makes everyone else shine ", response: "Thank You", type: 0 ),
                      shade(info: "I think your face looks very.. symmetric ", response: "Thank You", type: 0 ),
                      shade(info: "I believe in second chanses, you need one so lets do a retake ", response: "Thanks", type: 2 ),
                      shade(info: "That picture will not give you any likes, Retake ", response: "You're right!", type: 2 )]
        
        btnTakePhoto.layer.cornerRadius = btnTakePhoto.frame.size.width/2
        //btnTakePhoto.layer.borderColor = UIColor(red: 0.56, green: 0.91, blue: 0.4, alpha: 1.0).cgColor
        btnTakePhoto.layer.borderColor = UIColor.white.cgColor
        btnTakePhoto.layer.borderWidth = 5
        
       
        
        alertView.layer.cornerRadius = alertView.frame.size.width/2
        alertView.layer.borderColor  = UIColor.white.cgColor
        alertView.layer.borderWidth  = 5
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.ChangeCamera(_:)))
        tap.numberOfTapsRequired = 2
        self.cameraView.addGestureRecognizer(tap)
        
        let tapdismiss = UITapGestureRecognizer(target: self, action: #selector(self.dismissAlert(_:)))
        tapdismiss.numberOfTapsRequired = 1
        self.alertView.addGestureRecognizer(tapdismiss)
        
        let twofinger = UITapGestureRecognizer(target: self, action: #selector(self.takephoto(_:)))
        twofinger.numberOfTouchesRequired = 2
        self.cameraView.addGestureRecognizer(twofinger)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ChangeCamera(_ sender: Any) {
        
        if frontCamera == true{
            frontCamera = false
        }
        else{
            frontCamera = true
        }
        captureSession?.stopRunning()
        reloadCamera()
    }
    
    
    
    
    
    @IBAction func SaveImage(_ sender: Any) {
        UIImageWriteToSavedPhotosAlbum(imageView.image!, nil, nil, nil)
        btnSave.isEnabled = false 
    
    }
    
    func reloadCamera(){
        var cam : AVCaptureDevicePosition!
       
        
        if frontCamera == true{
            cam = AVCaptureDevicePosition.front
            
        }
        else{
            cam = AVCaptureDevicePosition.back
        }
        
        captureSession = AVCaptureSession();
        sessionOutput = AVCapturePhotoOutput();
        sessionOutputSetting = AVCapturePhotoSettings(format:[AVVideoCodecKey:AVVideoCodecJPEG]);
        previewLayer = AVCaptureVideoPreviewLayer();
        let deviceDiscoverySession = AVCaptureDeviceDiscoverySession(deviceTypes: [AVCaptureDeviceType.builtInDuoCamera, AVCaptureDeviceType.builtInTelephotoCamera,AVCaptureDeviceType.builtInWideAngleCamera], mediaType: AVMediaTypeVideo, position: AVCaptureDevicePosition.unspecified)
        for device in (deviceDiscoverySession?.devices)! {
            //if(device.position == AVCaptureDevicePosition.front){
            if(device.position == cam){
                do{
                    let input = try AVCaptureDeviceInput(device: device)
                    if(captureSession?.canAddInput(input))!{
                        captureSession?.addInput(input);
                        
                        if(captureSession?.canAddOutput(sessionOutput))!{
                            captureSession?.addOutput(sessionOutput)
                            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                            previewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
                            previewLayer?.connection.videoOrientation = AVCaptureVideoOrientation.portrait
                            previewLayer?.removeFromSuperlayer()
                            self.cameraView.layer.addSublayer(previewLayer!)
                            cameraView.frame = self.view.bounds
                            self.previewLayer?.frame = self.cameraView.bounds
                            
                            captureSession?.startRunning()
                            
                        }
                    }
                }
                catch{
                    print("exception!");
                }
            }
            
            
            
            
            
        }

    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadCamera()
     
        
    }
    func capture(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingPhotoSampleBuffer photoSampleBuffer: CMSampleBuffer?, previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        
        if let error = error {
            print(error.localizedDescription)
        }
        
        if let sampleBuffer = photoSampleBuffer, let previewBuffer = previewPhotoSampleBuffer, let dataImage = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: sampleBuffer, previewPhotoSampleBuffer: previewBuffer) {
        
            self.imageView.image = UIImage(data: dataImage)
            if(frontCamera == true){
                self.imageView.transform = CGAffineTransform(scaleX: -1, y: 1)
            }
            self.imageView.isHidden = false
            
        } else {
            
        }
        
    }
}



