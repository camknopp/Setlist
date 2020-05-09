//
//  MenuOption.swift
//  Setlist
//
//  Created by Cory Knopp on 4/5/20.
//  Copyright © 2020 Cory Knopp. All rights reserved.
//

import UIKit

enum MenuOption: Int, CustomStringConvertible {
    
    case Songs
    case Setlists
    
    var description: String {
        switch self {
        case .Songs:
            return "Songs"
        case .Setlists:
            return "Setlists"
        }
    }
    
    // TODO: add relevant images here
    var image: UIImage {
        switch self {
        case .Songs:
            return UIImage(named: "plusIcon") ?? UIImage()
        case .Setlists:
            return UIImage(named: "plusIcon") ?? UIImage()
        }
    }
}
