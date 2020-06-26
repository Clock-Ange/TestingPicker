//
//  UserPicture.swift
//  Challenge4
//
//  Created by Stanislav Makhmoudov on 21.06.2020.
//  Copyright © 2020 GennadyMakhmudov. All rights reserved.
//

import UIKit

class UserPicture: NSObject, Codable {
    var userImageName: String
    var userLabel: String
    
    init(userImageName: String, userLabel: String) {
        self.userImageName = userImageName
        self.userLabel = userLabel
    }
    
    
}
