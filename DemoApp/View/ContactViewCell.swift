//
//  ContactViewCell.swift
//  DemoApp
//
//  Created by BridgeLabz on 23/05/19.
//  Copyright © 2019 Bridgelabz. All rights reserved.
//

import UIKit

class ContactViewCell: UITableViewCell {

    @IBOutlet weak var contactImage: UIImageView!
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var contactNumberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 10
       
        contactImage?.image = UIImage(named: "contact-img")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func bindCell(of contact : Contact){
        contactNameLabel.text = contact.fullName
        contactNumberLabel.text = contact.mobileNumber
    }

}
