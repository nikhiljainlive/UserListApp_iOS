//
//  ContactDao.swift
//  DemoApp
//
//  Created by BridgeLabz on 27/05/19.
//  Copyright © 2019 Bridgelabz. All rights reserved.
//

import Foundation
import SQLite3

class ContactDao : ContactDaoProtocol {
    
    private var sqliteDbHelper : SQLiteDatabaseHelper?
    private var dbInstance : OpaquePointer?
    private var preparedStatement : OpaquePointer?
    
    init() {
        sqliteDbHelper = SQLiteDatabaseHelper.getInstance()
        dbInstance = sqliteDbHelper?.getDatabaseInstance()
    }
    
    func insert(withContact contact: Contact) -> Bool {
        
        let insertQuery = """
        INSERT INTO \(contactTableName)
        ( \(contact_column_2) , \(contact_column_3), \(contact_column_4), \(contact_column_5)
        )
        VALUES ( '\(contact.fullName)', \(contact.age), '\(contact.email)', '\(contact.mobileNumber)'
        )
        """
        
        if sqlite3_prepare(dbInstance, insertQuery, -1, &preparedStatement, nil) != SQLITE_OK {
            print("error in binding insert query")
        }
        
        let isInserted = sqlite3_step(preparedStatement) == SQLITE_DONE
        sqlite3_finalize(preparedStatement)
        
        return isInserted
    }
    
    func update(withContactId contactId: Int, withContact contact: Contact) -> Bool {
        let updateQuery = """
        UPDATE \(contactTableName)
        SET \(contact_column_2) = '\(contact.fullName)',
        \(contact_column_3) = \(contact.age),
        \(contact_column_4) = '\(contact.email)',
        \(contact_column_5) = '\(contact.mobileNumber)'
        WHERE \(contact_column_1) = \(contactId)
        """
        
        if sqlite3_prepare(dbInstance, updateQuery, -1, &preparedStatement, nil) != SQLITE_OK {
            print("error in binding update query")
        }
        
        let isUpdated = sqlite3_step(preparedStatement) == SQLITE_DONE
        sqlite3_finalize(preparedStatement)
        
        return isUpdated
    }
    
    func delete(withContactId contactId: Int) -> Bool {
        let deleteQuery = """
        DELETE FROM \(contactTableName)
        WHERE \(contact_column_1) = \(contactId)
        """
        
        if sqlite3_prepare(dbInstance, deleteQuery, -1, &preparedStatement, nil) != SQLITE_OK {
            print("error in binding delete query")
        }
        
        let isDeleted = sqlite3_step(preparedStatement) == SQLITE_DONE
        sqlite3_finalize(preparedStatement)
        
        return isDeleted
    }
    
    func deleteAll() -> Bool {
        let deleteAllQuery = "DELETE FROM \(contactTableName)"
        
        if sqlite3_prepare(dbInstance, deleteAllQuery, -1, &preparedStatement, nil) != SQLITE_OK {
            print("error in binding delete all query")
        }
        let areAllDeleted = sqlite3_step(preparedStatement) == SQLITE_DONE
        sqlite3_finalize(preparedStatement)
        
        return areAllDeleted
    }
    
    
    func listOfContacts() -> [Contact] {
        var contactList = [Contact]()
        
        let selectAllQuery = "SELECT * FROM \(contactTableName)"
        if sqlite3_prepare(dbInstance, selectAllQuery, -1, &preparedStatement, nil) == SQLITE_OK {
            while sqlite3_step(preparedStatement) == SQLITE_ROW {
                let contactId = Int(sqlite3_column_int(preparedStatement, 0))
                let contactFullName = String(cString : sqlite3_column_text(preparedStatement, 1))
                let contactAge = Int(sqlite3_column_int(preparedStatement, 2))
                let contactEmail = String(cString : sqlite3_column_text(preparedStatement, 3))
                let contactMobileNumber = String(cString : sqlite3_column_text(preparedStatement, 4))
                
                let foundContact = Contact(contactId: contactId, fullName: String(contactFullName), age: contactAge, email: contactEmail, mobileNumber: contactMobileNumber)
                contactList.append(foundContact)
            }
        } else {
            print("error in binding select query")
        }
        
        sqlite3_finalize(preparedStatement)
        
        for contact in contactList {
            print(contact.description())
        }
        
        return contactList
    }
}

//        let insertQuery = "INSERT INTO \(contactTableName) ( \(contact_column_2) , \(contact_column_3), \(contact_column_4), \(contact_column_5) ) VALUES ('\(contact.fullName)', \(contact.age), '\(contact.email)', '\(contact.phoneNumber)');"



//        let insertQuery = "INSERT INTO \(contactTableName) ( \(contact_column_2) , \(contact_column_3), \(contact_column_4), \(contact_column_5) ) VALUES (?, ?, ?, ?)"


//        let bindText = { (position : Int, text : String) -> Void in
//            if sqlite3_bind_text(self.preparedStatement, 1, text , -1, nil) != SQLITE_OK {
//                print("error in binding \(text))")
//            }
//        }
//
//        let bindInt = { (position : Int32, value : Int32) -> Void in
//            if sqlite3_bind_int(self.preparedStatement, position, value)  != SQLITE_OK {
//                print("error in binding \(value))")
//            }
//        }


//        bindText(1, contact.fullName)
//        bindInt(2, Int32(contact.age))
//        bindText(3, contact.email)
//        bindText(4, contact.phoneNumber)


//        func bindText(position : Int ,text : String){
//            if sqlite3_bind_text(preparedStatement, 1, text , -1, nil) != SQLITE_OK {
//                print("error in binding \(text))")
//            }
//        }

//        func bindInt(position : Int32 , value : Int32){
//            if sqlite3_bind_int(preparedStatement, position, value)  != SQLITE_OK {
//                print("error in binding \(value))")
//            }
//

//        if sqlite3_bind_text(preparedStatement, 1, contact.fullName , -1, nil) != SQLITE_OK {
//            print("error in binding full name")
//        }

//        if sqlite3_bind_int(preparedStatement, 2, Int32(contact.age))  != SQLITE_OK {
//            print("error in binding age")
//        }

//        if sqlite3_bind_text(preparedStatement, 3, contact.email , -1, nil) != SQLITE_OK {
//            print("error in binding email")
//        }
//        if sqlite3_bind_text(preparedStatement, 4, contact.phoneNumber, -1, nil) != SQLITE_OK {
//            print("error in binding phoneNumber")
//        }
