//
//  ViewController.swift
//  Recognize
//
//  Created by Jake Garcia on 9/22/19.
//  Copyright © 2019 Jake Garcia. All rights reserved.
//

import UIKit

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
    
    
    
}

