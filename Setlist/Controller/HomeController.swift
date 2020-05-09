//
//  HomeController.swift
//  Setlist
//
//  Created by Cory Knopp on 4/5/20.
//  Copyright © 2020 Cory Knopp. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    var delegate: HomeControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configureNavigationBar()
    }
    
    @objc func handleMenuToggle() {
        delegate?.handleMenuToggle(forMenuOption: nil)
    }
    
    @objc func addSong() {
        delegate?.addSong()
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .darkGray
        navigationController?.navigationBar.barStyle = .black
        
        let buttonWidth = CGFloat(30)
        let buttonHeight = CGFloat(30)

        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "menuIcon"), for: .normal)
        button.addTarget(self, action: #selector(handleMenuToggle), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        button.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        
        let addSongButton = UIButton(type: .custom)
        addSongButton.setImage(UIImage(named: "plusIcon"), for: .normal)
        addSongButton.addTarget(self, action: #selector(addSong), for: .touchUpInside)
        addSongButton.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        addSongButton.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addSongButton)
        
        navigationItem.title = "Sup Dawg"
    }
}
