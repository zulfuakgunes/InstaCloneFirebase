//
//  UploadViewController.swift
//  InstaCloneFirebase
//
//  Created by Zülfü Akgüneş on 17.10.2022.
//

import UIKit
import FirebaseStorage
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

class UploadViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var commentText: UITextField!
    

    @IBOutlet var actionButtonClick: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Recognizers
        
        imageView.isUserInteractionEnabled = true
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(imageTapRecognizer)
    }
    
    @objc func selectImage(){
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    func makeAlert(titleInput: String, messageInput:String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func actionButtonClick(_ sender: Any) {

        let uuid = UUID().uuidString
        
        
        let storage = Storage.storage()
        
        // Create a storage reference from our storage service
        let storageRef = storage.reference()
         
        let mediaFolder = storageRef.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5){
            
            let imageRef = mediaFolder.child(uuid)
            
            imageRef.putData(data, metadata: nil) { metadata, error in
                if error != nil{
                    self.makeAlert(titleInput: "Error",  messageInput: error?.localizedDescription ?? "Error")
                }else{
                    imageRef.downloadURL { url, error in
                        if error == nil{
                            let imageUrl = url?.absoluteString
                            
                            //DataBase
                            let firestoreDatabase = Firestore.firestore()
                            var firestoreReference: DocumentReference? = nil
                            let fireStorePosts = ["imageUrl":imageUrl!, "postedBy": Auth.auth().currentUser!.email!, "postComment" : self.commentText.text!, "date": FieldValue.serverTimestamp(), "likes" : 0] as [String: Any]
                            firestoreReference = firestoreDatabase.collection("Posts").addDocument(data: fireStorePosts, completion: { error in
                                if error != nil{
                                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                                }else{
                                    
                                    self.imageView.image = UIImage(named: "images")
                                    self.commentText.text = ""
                                    self.tabBarController?.selectedIndex = 0
                                    
                                }
                            })
                            
                        }
                    }
                }
            }
        }
    }
    
}
