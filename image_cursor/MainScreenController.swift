//
//  ViewController2.swift
//  image_cursor
//
//  Created by Apple on 2020/08/03.
//  Copyright © 2020 auaicn_organization. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import Alamofire

class MainScreenController: UIViewController, ARSCNViewDelegate {

    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
   }
    
    @IBOutlet weak var imageView: UIImageView!
    
    // let url = "http://192.249.19.243:0380/image/upload"
    let url = "http://192.249.19.243:0380/uploads/abc.jpeg"
    
    @IBAction func loadAction(_ sender: Any) {
        
        AF.download(url).responseData { response in
            if let data = response.value {
                let image = UIImage(data: data)
                self.imageView.image = image
            }
        }
    }
    
    @IBAction func insertButton(_ sender: Any) {
        let alert =  UIAlertController(title: "원하는 타이틀", message: "원하는 메세지", preferredStyle: .actionSheet)
        
        let library =  UIAlertAction(title: "사진앨범", style: .default) { (action) in self.openLibrary()
        }
        
        let camera =  UIAlertAction(title: "카메라", style: .default) { (action) in
            self.openCamera()
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(library)
        alert.addAction(camera)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    func openLibrary()
    {
        picker.sourceType = .photoLibrary
        present(picker, animated: false, completion: nil)

    }
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            picker.sourceType = .camera
            present(picker, animated: false, completion: nil)
        }
        else{
            print("Camera not available")
        }
    }
}

extension MainScreenController : UIImagePickerControllerDelegate,
UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }

        self.imageView.image = selectedImage

        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
