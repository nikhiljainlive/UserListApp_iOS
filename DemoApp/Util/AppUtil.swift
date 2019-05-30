//
//  AppUtil.swift
//  DemoApp
//
//  Created by BridgeLabz on 28/05/19.
//  Copyright © 2019 Bridgelabz. All rights reserved.
//

import Foundation
import UIKit

public class AppUtil {
    
    public static func getSimpleAlert(messageString : String) -> UIAlertController{
        let alertController = UIAlertController(title: nil, message: messageString, preferredStyle: .alert)
        let alertAction = UIAlertAction.init(title: "Dismiss", style: .default, handler: nil)
        alertController.addAction(alertAction)
        
        return alertController
    }
    
    public static func getAlertWithAction(messageString : String, actionTitle : String, handler : @escaping (UIAlertAction) -> Void) -> UIAlertController {
        let alertController = UIAlertController(title: nil, message: messageString, preferredStyle: .actionSheet)
        let alertAction = UIAlertAction.init(title: actionTitle, style: .default, handler: handler)
        alertController.addAction(alertAction)
        
        return alertController
    }
    
    public static func clearTextField(uiTextField : UITextField?) {
        uiTextField?.text?.removeAll()
    }
}
