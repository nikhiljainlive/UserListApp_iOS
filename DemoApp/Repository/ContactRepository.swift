//
//  ContactModel.swift
//  DemoApp
//
//  Created by BridgeLabz on 24/05/19.
//  Copyright © 2019 Bridgelabz. All rights reserved.
//

import Foundation

class ContactRepository {
    let contactDao = ContactDao()

    func insert(with contact : Contact) -> Bool {
        return contactDao.insert(withContact: contact)
    }
    
    func update(withContactId contactId: Int, withContact contact: Contact) -> Bool {
        return contactDao.update(withContactId: contactId, withContact: contact)
    }
    
    func delete(withContactId contactId : Int) -> Bool {
        return contactDao.delete(withContactId: contactId)
    }
    
    func deleteAll() -> Bool {
        return contactDao.deleteAll()
    }
    
    func getContactList() -> [Contact]{
        return contactDao.listOfContacts()
    }
    
    func getContact(at index: Int) -> Contact {
        return contactDao.listOfContacts()[index]
    }
}



// test list

//    private var contactList = [Contact(contactId : 1, fullName: "Nikhil Jain", age: 22, email: "nikhiljain5195@gmail.com" ,phoneNumber: "8871152221"),
//                    Contact(contactId : 2, fullName: "Ajay Sharma", age: 35, email: "ajay123@yahoo.in" , phoneNumber: "8292728323"),
//                    Contact(contactId : 3, fullName: "Aditya Ram", age: 46, email: "adiram2342aim.com" , phoneNumber: "7367453455"),
//                    Contact(contactId : 4,fullName: "Nishith Sen", age: 91, email: "nishith098@aol.com" , phoneNumber: "2868642755"),
//                    Contact(contactId : 5,fullName: "Ashish Malhotra", age: 84, email: "ashishm121@gmail.com" , phoneNumber: "2686486475"),
//                    Contact(contactId : 6,fullName: "Vijay Kumar", age: 75, email: "vijay33@gmail.com" , phoneNumber: "7387487844")]
