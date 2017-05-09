//
//  CommonPageContent.swift
//  InfraTest
//
//  Created by Васильев Андрей on 09.05.17.
//  Copyright © 2017 Васильев Андрей. All rights reserved.
//

import Foundation

class CommonPageContent {
    let imageName: String
    let imageTitle: String
    
    init(imageName: String, imageTitle: String) {
        self.imageName = imageName
        self.imageTitle = imageTitle
    }
    
    convenience init() {
        self.init(imageName: "example", imageTitle: "Invalid Content!!!")
    }
}
