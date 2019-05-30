//
//  SQLiteDatabase.swift
//  DemoApp
//
//  Created by BridgeLabz on 27/05/19.
//  Copyright © 2019 Bridgelabz. All rights reserved.
//

import Foundation
import SQLite3

let dbFileName = "app.sqlite"
let contactTableName = "contact_table"
let contact_column_1 = "contact_id"
let contact_column_2 = "name"
let contact_column_3 = "age"
let contact_column_4 = "email"
let contact_column_5 = "phone_number"

class SQLiteDatabaseHelper {
    private static var dbInstance : SQLiteDatabaseHelper?
    var sqliteDatabase : OpaquePointer?
    
    private init(){
        openDB()
        createTable()
    }
    
    private func openDB(){
        let filePathUrl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(dbFileName)
        
        if sqlite3_open(filePathUrl.path , &sqliteDatabase) != SQLITE_OK {
            print("error while opening SQLite database")
        } else {
            print("database opened at \(filePathUrl.path)")
        }
    }
    
    private func createTable(){
        let createContactTableQuery = "CREATE TABLE IF NOT EXISTS \(contactTableName) ( \(contact_column_1) INTEGER PRIMARY KEY AUTOINCREMENT, \(contact_column_2) TEXT NOT NULL, \(contact_column_3) INTEGER NOT NULL, \(contact_column_4) TEXT NOT NULL, \(contact_column_5) TEXT NOT NULL)"
        
        if sqlite3_exec(sqliteDatabase, createContactTableQuery, nil, nil, nil) != SQLITE_OK {
            print("error while creating table")
        } else {
            print("table created or being read")
        }
    }
    
    static func getInstance() -> SQLiteDatabaseHelper? {
        if(dbInstance == nil){
            dbInstance = SQLiteDatabaseHelper()
        }
        return dbInstance
    }
    
    func getDatabaseInstance() -> OpaquePointer? {
        return sqliteDatabase
    }
    
    private func closeDB() {
        if(sqliteDatabase != nil){
            sqlite3_close(sqliteDatabase)
            print("database closed")
        }
    }
    
    deinit {
        closeDB()
    }
}
