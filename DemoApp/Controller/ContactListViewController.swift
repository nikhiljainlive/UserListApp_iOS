//
//  ContactViewController.swift
//  DemoApp
//
//  Created by BridgeLabz on 24/05/19.
//  Copyright © 2019 Bridgelabz. All rights reserved.
//

import UIKit

class ContactListViewController: UIViewController {
    
    @IBOutlet weak var contactTableView: UITableView!
    
    private let contactModel = ContactRepository()
    private var contactList = [Contact]()
    var selectedContact : Contact?
    
    override func viewWillAppear(_ animated: Bool) {
        contactList = contactModel.getContactList()
        contactTableView.reloadData()
    }
}

extension ContactListViewController : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactViewCell", for: indexPath) as! ContactViewCell
        cell.bindCell(of: contactList[indexPath.row])
        
        return cell
    }
    
    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        
        if identifier == "detailContactSegue" {
            let detailViewController = storyboard?.instantiateViewController(withIdentifier: "detailViewController") as? ContactDetailViewController
            
            detailViewController?.selectedContact = selectedContact
            let navigationController = self.navigationController
            navigationController?.present(detailViewController!, animated: true, completion: nil)
            
            print("segue performed")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedContact = contactList[indexPath.row]
        
        self.performSegue(withIdentifier: "detailContactSegue", sender: self)
        
        print("row selected at \(indexPath.row)")
    }
}
