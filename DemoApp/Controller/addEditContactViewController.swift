//
//  AddContactViewController.swift
//  DemoApp
//
//  Created by BridgeLabz on 28/05/19.
//  Copyright © 2019 Bridgelabz. All rights reserved.
//

import UIKit

class addEditContactViewController: UIViewController {
    private let contactRepository = ContactRepository()
    var contactToEdit : Contact?
    
    private var isEditMode: Bool {
        return contactToEdit != nil
    }
    
    @IBOutlet private weak var fullNameField: UITextField!
    @IBOutlet private weak var ageField: UITextField!
    @IBOutlet private weak var emailField: UITextField!
    @IBOutlet private weak var mobileNumberField: UITextField!
    @IBOutlet private weak var saveOrEditButton: UIButton!
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var viewHeading: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpHeading()
        setUpTextFields()
        setUpBackButton()
        setUpAddOrEditButton()
    }
    
    @IBAction func onSaveOrUpdateTapped(_ sender: Any) {
        let contactUpdated = getContactFromFields()
        if contactUpdated != nil {
            if !isEditMode {
                saveContact(contact: contactUpdated!)
            } else if isEditMode {
                updateContact(contact : contactUpdated!)
            }
        } else {
            let failureAlertController = AppUtil.getSimpleAlert(messageString: "Fields must have valid data!")
            present(failureAlertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func onBackTapped(_ sender: UIButton) {
        view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    private func getContactFromFields() -> Contact? {
        let fullName = fullNameField.text
        let age = Int(ageField.text!)
        let email = emailField.text
        let mobileNum = mobileNumberField.text
        
        if fullName != "", age != nil, email != "", mobileNum != "" {
            return Contact(contactId: 0, fullName: fullName!, age: age!, email: email!, mobileNumber: mobileNum!)
        }
        return nil
    }
    
    private func saveContact(contact newContact : Contact) {
        if contactRepository.insert(with: newContact) {
            let saveAlertController =  AppUtil.getSimpleAlert(messageString: "Contact saved succesfully")
            present(saveAlertController, animated: true, completion: nil)
            clearTextFields()
        } else {
            self.view.showToast(toastMessage: "Something went wrong!", duration: 1)
        }
    }
    
    private func updateContact(contact newContact : Contact) {
        if contactRepository.update(withContactId: (contactToEdit?.contactId)!, withContact: newContact) {
            let updateAlertController =  AppUtil.getSimpleAlert(messageString: "Contact updated succesfully")
            present(updateAlertController, animated: true, completion: nil)
        } else {
            self.view.showToast(toastMessage: "Something went wrong!", duration: 1)
        }
    }
    
    private func setUpHeading() {
        if isEditMode {
            viewHeading.text = "Edit Contact"
        } else {
            viewHeading.text = "Add Contact"
        }
    }
    
    private func setUpAddOrEditButton() {
        saveOrEditButton.layer.cornerRadius = 4
        if contactToEdit == nil {
            saveOrEditButton.setTitle("Save", for: .normal)
        } else {
            saveOrEditButton.setTitle("Update", for: .normal)
        }
    }
    
    private func setUpBackButton() {
        backButton.layer.cornerRadius = 4
    }
    
    private func setUpTextFields() {
        if contactToEdit != nil {
            fullNameField.text = contactToEdit?.fullName
            ageField.text = String(contactToEdit!.age)
            emailField.text = contactToEdit?.email
            mobileNumberField.text = contactToEdit?.mobileNumber
        }
    }
    
    private func clearTextFields() {
        AppUtil.clearTextField(uiTextField: fullNameField)
        AppUtil.clearTextField(uiTextField: ageField)
        AppUtil.clearTextField(uiTextField: emailField)
        AppUtil.clearTextField(uiTextField: mobileNumberField)
        
//        fullNameField.text?.removeAll()
//        ageField.text?.removeAll()
//        emailField.text?.removeAll()
//        mobileNumberField.text?.removeAll()
    }
}
