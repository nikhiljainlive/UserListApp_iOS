//
//  ContactDaoProtocol.swift
//  DemoApp
//
//  Created by BridgeLabz on 27/05/19.
//  Copyright © 2019 Bridgelabz. All rights reserved.
//

import Foundation

protocol ContactDaoProtocol {
    func insert(withContact contact : Contact) -> Bool
    func update(withContactId contactId : Int, withContact contact : Contact) -> Bool
    func delete(withContactId contactId : Int) -> Bool
    func deleteAll() -> Bool
    func listOfContacts() -> [Contact]
}
