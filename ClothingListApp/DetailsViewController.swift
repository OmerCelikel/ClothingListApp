//
//  DetailsViewController.swift
//  ClothingListApp
//
//  Created by Ömer Oğuz Çelikel on 2.12.2021.
//

import UIKit
import CoreData
class DetailsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var sizeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        
        // user can interact with image (will click)
        imageView.isUserInteractionEnabled = true
        let imageGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseYourProduct))
        imageView.addGestureRecognizer(imageGestureRecognizer)
    }
    
    // will pick photo from gallary
    @objc func chooseYourProduct(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    //function is for after pick media
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.editedImage] as? UIImage
        //closses picker
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func closeKeyboard(){
        view.endEditing(true)
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        // can find AppDelegate for save
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let clothes = NSEntityDescription.insertNewObject(forEntityName: "Clothes", into: context)
        
        clothes.setValue(nameTextField.text!, forKey: "name")
        clothes.setValue(sizeTextField.text!, forKey: "size")
        
        if let price = Int(priceTextField.text!){
            clothes.setValue(price, forKey: "price")
        }
        
        //universal unique id
        clothes.setValue(UUID(), forKey: "id")
        
        let data = imageView.image!.jpegData(compressionQuality: 0.5)
        
        clothes .setValue(data, forKey: "image")
        do{
            try context.save()
            print("saved")
        }catch{
            print("there is a ERROR")
        }
        
    }
    
    

}
