//
//  Protocols.swift
//  Setlist
//
//  Created by Cory Knopp on 4/5/20.
//  Copyright © 2020 Cory Knopp. All rights reserved.
//

protocol HomeControllerDelegate {
    func handleMenuToggle(forMenuOption menuOption: MenuOption?)
    func addSong()
}
