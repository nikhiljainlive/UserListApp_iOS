//
//  ContactDetailViewController.swift
//  DemoApp
//
//  Created by BridgeLabz on 26/05/19.
//  Copyright © 2019 Bridgelabz. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {
    private let contactRepository = ContactRepository()
    var selectedContact : Contact?
    
    @IBOutlet private weak var contactImageView: UIImageView!
    @IBOutlet private weak var contactName: UILabel!
    @IBOutlet private weak var contactAge: UILabel!
    @IBOutlet private weak var contactNumberLabel: UILabel!
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var editButton: UIButton!
    @IBOutlet private weak var deleteButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        setUpTextFields()
        setUpButtons()
    }
    
    private func setUpTextFields(){
        contactImageView.image = UIImage(named: "contact-detail-image")
        contactName.text = selectedContact?.fullName
        contactAge.text = String(selectedContact!.age)
        contactNumberLabel.text = selectedContact?.mobileNumber
    }
    
    private func setUpButtons() {
        backButton.layer.cornerRadius = 4
        editButton.layer.cornerRadius = 4
        deleteButton.layer.cornerRadius = 4
    }
    
    @IBAction private func onEditTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "editContactSegue", sender: self)
    }
    
    @IBAction private func onDeleteTapped(_ sender: Any) {
        if contactRepository.delete(withContactId: (selectedContact?.contactId)!) {
            let deletedAlertController = AppUtil.getAlertWithAction(messageString: "Contact Deleted Successfully", actionTitle: "Ok", handler: { (action : UIAlertAction) -> Void in
                self.dismiss(animated: true, completion: nil)
            })
            present(deletedAlertController, animated: true, completion: nil)
        } else {
           let errorAlertController = AppUtil.getSimpleAlert(messageString: "Something went wrong!")
            
            present(errorAlertController, animated: true, completion: nil)
        }
    }
    
    @IBAction private func onBackTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override internal func performSegue(withIdentifier identifier: String, sender: Any?) {
        if identifier == "editContactSegue" {
            let editContactVC = storyboard?.instantiateViewController(withIdentifier: "addEditContactVC") as? addEditContactViewController
            editContactVC?.contactToEdit = selectedContact
            print(selectedContact?.contactId ?? "something went wrong with selected contact Id")
            present(editContactVC!, animated: true, completion: nil)
        }
    }
}
