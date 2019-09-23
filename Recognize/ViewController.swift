//
//  ViewController.swift
//  Recognize
//
//  Created by Jake Garcia on 9/22/19.
//  Copyright © 2019 Jake Garcia. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController:UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var imageTakenView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
    }

    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        
        present(imagePicker, animated: true)
        
    }
    // MARK: - TODO
    
    // didFinishPickingMediaWithOptions

    // create func to detect what the chosen image is.
    
    // MARK: - Did Finish Pickinf Media
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let userEditedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            fatalError("Unable to get the edited image")
        }
        
        if let convertedImage = CIImage(image: userEditedImage) {
            detect(userImage: convertedImage)
        }
        
        imageTakenView.image = userEditedImage
        
        imagePicker.dismiss(animated: true, completion: nil)
        
        
    }
    
    func detect(userImage: CIImage) {
        
        guard let model = try? VNCoreMLModel(for: first_Image_Classifier().model) else {
            fatalError("Could not initialize vision model with given model.")
        }
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Unable to retrieve classification observations")
            }
            
            if let firstResult = results.first {
                print(firstResult.identifier)
                self.title = "It's a \(firstResult.identifier)"
            }
            
        }
        
        let handler = VNImageRequestHandler(ciImage: userImage)
        
        do {
            try! handler.perform([request])
        } catch {
            print("Error: \(error)")
        }
        
        
        
        
    }
    
}

