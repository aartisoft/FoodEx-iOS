//
//  SetingsVC.swift
//  FoodEx
//
//  Created by korsour on 5/3/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import UIKit

class SettingsVC: KeyboardVC, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    static var shared: SettingsVC? = nil
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var photoIV: UIImageView!
    
    @IBOutlet weak var streetWeekdaysTF: UITextField!
    @IBOutlet weak var houseWeekdaysTF: UITextField!
    @IBOutlet weak var flatWeekdaysTF: UITextField!
    @IBOutlet weak var packageWeekdaysButton: UIButton!
    @IBOutlet weak var noteWeekdaysTF: UITextField!
    @IBOutlet var timeWeekdaysTF: UITextField!
    
    @IBOutlet weak var streetWeekendsTF: UITextField!
    @IBOutlet weak var houseWeekendsTF: UITextField!
    @IBOutlet weak var flatWeekendsTF: UITextField!
    @IBOutlet weak var packageWeekendsButton: UIButton!
    @IBOutlet weak var noteWeekendsTF: UITextField!
    @IBOutlet var timeWeekendsTF: UITextField!
    
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var middleNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    
    @IBOutlet weak var birthdayButton: UIButton!
    @IBOutlet weak var genderButton: UIButton!
    @IBOutlet weak var growthButton: UIButton!
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    
    let tapRec = UITapGestureRecognizer()
    
    var imagePicker = UIImagePickerController()
    
    var weekdaysCurrentPackageId: Delivery.PackageType = .Bag
    var weekendsCurrentPackageId: Delivery.PackageType = .Bag
    
    var isPhotoChanged: Bool = false
    var isEditingData = false
    
    var draftGender: Int = -1
    
    func setDraftGender(id: Int) {
        draftGender = id
        genderButton.setTitle(UserData.getGenderName(id: id), for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SettingsVC.shared = self
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
        
        
        let textFields = getAllTextFields(fromView: contentView)
        textFields.forEach({viewsToDismissKeyboard.append($0)})
        
        tapRec.addTarget(self, action: "onPhotoClick")
        photoIV.addGestureRecognizer(tapRec)
        
        setUpPhotoIV()
    }
    
    func setUpPhotoIV() {
        photoIV.layer.borderWidth = 1
        photoIV.layer.masksToBounds = true
        photoIV.layer.borderColor = UIColor.black.cgColor
        photoIV.layer.cornerRadius = photoIV.frame.height/2
//        photoIV.clipsToBounds = true
    }
    
    @objc func onPhotoClick() {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photoIV.image = image
            isPhotoChanged = true
        }
        
        picker.dismiss(animated: true, completion: nil);
    }
    
    @objc func back(sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
        isEditingData = false
    }

    
    override func viewWillAppear(_ animated: Bool) {
        if !isEditingData {
            showMyData()
            showSaveButton()
            isEditingData = true
        }
    }
    
    @IBAction func onChangePackClicked(_ sender: Any) {
        let alert = UIAlertController(title: "Which is more convinient for you?", message: "Choose one of types of the delivery package.", preferredStyle: .actionSheet)
        
        let button = sender as! UIButton
        var isOpenedWeekdaysPackage: Bool? = nil
        
        let onClickClosure = { (action: UIAlertAction!) -> Void in
            
            // TODO: Refactor it
            switch action.title {
                case "Package":
                    button.titleLabel?.text = "Package"
                    if isOpenedWeekdaysPackage! {
                        self.weekdaysCurrentPackageId = Delivery.PackageType(rawValue: 0)!
                    } else {
                        self.weekendsCurrentPackageId = Delivery.PackageType(rawValue: 0)!
                    }
                    break
                case "Bag":
                    button.titleLabel?.text = "Bag"
                    if isOpenedWeekdaysPackage! {
                        self.weekdaysCurrentPackageId = Delivery.PackageType(rawValue: 1)!
                    } else {
                        self.weekendsCurrentPackageId = Delivery.PackageType(rawValue: 1)!
                    }
                    break
                case "Cart":
                    button.titleLabel?.text = "Cart"
                    if isOpenedWeekdaysPackage! {
                        self.weekdaysCurrentPackageId = Delivery.PackageType(rawValue: 2)!
                    } else {
                        self.weekendsCurrentPackageId = Delivery.PackageType(rawValue: 2)!
                    }
                    break
                default:
                    break
            }
        }
        
        alert.addAction(UIAlertAction(title: "Package", style: .default, handler: onClickClosure))
        alert.addAction(UIAlertAction(title: "Bag", style: .default, handler: onClickClosure))
        alert.addAction(UIAlertAction(title: "Cart", style: .default, handler: onClickClosure))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        if button.tag == 1 {
            // weekdays
            isOpenedWeekdaysPackage = true
        } else if button.tag == 2 {
            isOpenedWeekdaysPackage = false
        } else {
            fatalError()
        }
        
        self.present(alert, animated: true)
    }
    
    func getAllTextFields(fromView view: UIView)-> [UITextField] {
        return view.subviews.flatMap { (view) -> [UITextField]? in
            if view is UITextField {
                return [(view as! UITextField)]
            } else {
                return getAllTextFields(fromView: view)
            }
            }.flatMap({$0})
    }
    
    func showMyData() {
        streetWeekdaysTF.text = UserData.my.weekdaysDelivery?.address.street
        houseWeekdaysTF.text = UserData.my.weekdaysDelivery?.address.house
        flatWeekdaysTF.text = UserData.my.weekdaysDelivery?.address.flat
        packageWeekdaysButton.titleLabel!.text = UserData.my.weekdaysDelivery?.type.str
        noteWeekdaysTF.text = UserData.my.weekdaysDelivery?.note
        
        streetWeekendsTF.text = UserData.my.weekendsDelivery?.address.street
        houseWeekendsTF.text = UserData.my.weekendsDelivery?.address.house
        flatWeekendsTF.text = UserData.my.weekendsDelivery?.address.flat
        packageWeekendsButton.titleLabel!.text = UserData.my.weekendsDelivery?.type.str
        noteWeekendsTF.text = UserData.my.weekendsDelivery?.note
        
        firstNameTF.text = UserData.my.name?.first
        middleNameTF.text = UserData.my.name?.middle
        lastNameTF.text = UserData.my.name?.last
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy"
        
        let birthdayString = formatter.string(from: UserData.my.birthday!)
        
        birthdayButton.setTitle(birthdayString, for: .normal)
        genderButton.setTitle(UserData.my.getGenderName(), for: .normal)
        growthButton.setTitle(UserData.my.growth?.getString(), for: .normal)
        
        emailTF.text = UserData.my.contact?.email
        phoneTF.text = UserData.my.contact?.phones[0]
    }
    
    func showSaveButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveClicked))
    }
    
    @objc func saveClicked() {
//        if !allFieldsFilled() {
//            return
//        }
        
//        UserData.my.birthday =
        UserData.my.contact = Contact(email: emailTF.text!, phones: [phoneTF.text!])
        //continue here please ok?
        if draftGender != -1 {
            UserData.my.gender = draftGender
        }
//        UserData.my.growth =
        UserData.my.name = Name(first: firstNameTF.text!, middle: middleNameTF.text!, last: lastNameTF.text!)
        UserData.my.weekdaysDelivery = Delivery(time: timeWeekdaysTF.text!, address: Address(street: streetWeekdaysTF.text!, house: houseWeekdaysTF.text!, flat: flatWeekdaysTF.text!), type: weekdaysCurrentPackageId, note: noteWeekdaysTF.text!)
        UserData.my.weekendsDelivery = Delivery(time: timeWeekendsTF.text!, address: Address(street: streetWeekendsTF.text!, house: houseWeekendsTF.text!, flat: flatWeekendsTF.text!), type: weekendsCurrentPackageId, note: noteWeekendsTF.text!)
        
        FireFunctions.callFunction(.updateCustomerInfo, UserData.my.dict)
        
        if isPhotoChanged {
            FireStorage.uploadUserPhoto(photo: photoIV.image!)
            isPhotoChanged = false
        }
        
        isEditingData = false
        
        UI.showPage(source: self, page: .Profile)
    }
    
    func allFieldsFilled() -> Bool {
       return streetWeekdaysTF.text != nil
        && houseWeekdaysTF.text != nil
        && flatWeekdaysTF.text != nil
        && noteWeekdaysTF.text != nil
        && timeWeekdaysTF.text != nil
        && streetWeekendsTF.text != nil
        && houseWeekendsTF.text != nil
        && flatWeekendsTF.text != nil
        && noteWeekendsTF.text != nil
        && timeWeekendsTF.text != nil
        && firstNameTF.text != nil
        && middleNameTF.text != nil
        && lastNameTF.text != nil
        && phoneTF.text != nil
    }
    
    
    
    @IBAction func showChangingGender(_ sender: Any) {
        UI.showPage(source: self, page: .SetGender)
        SetGenderVC.shared?.enableEditingMode()
    }
}
