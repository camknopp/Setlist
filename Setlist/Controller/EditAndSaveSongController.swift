//
//  EditAndSaveSongController.swift
//  Setlist
//
//  Created by Cory Knopp on 4/13/20.
//  Copyright © 2020 Cory Knopp. All rights reserved.
//

import UIKit

class EditAndSaveSongController: UIViewController, UITextFieldDelegate {
    
    private var song: Song!
    
    init (song: Song) {
        super.init(nibName: nil, bundle: nil)
        self.song = song
    }
    
    // This is some weird method we need to implement in order to override init, just ignore it
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        song.loadByID() { success in
            if (success) {
                // Swift specific thing where only main thread can update UI
                DispatchQueue.main.async {
                    self.configureView()
                }
            } else {
                // handle error
            }
        }
    }
    
    func configureView() {
        let label = UILabel(frame: CGRect(x: 0, y: 20, width: view.frame.size.width, height: 40))
        label.center.x = view.frame.size.width / 2
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 25)
        label.text = "Edit and Save Song"
        self.view.addSubview(label)
        
        
        let songLabel = UILabel(frame: CGRect(x: 5, y: 75, width: 50, height: 40))
        songLabel.font = UIFont.systemFont(ofSize: 15)
        songLabel.text = "Name:"
        self.view.addSubview(songLabel)
        
        let songNameTextField =  UITextField(frame: CGRect(x: 55, y: 75, width: view.frame.size.width - 55, height: 40))
        songNameTextField.placeholder = "Enter song name..."
        songNameTextField.font = UIFont.systemFont(ofSize: 15)
        songNameTextField.borderStyle = UITextField.BorderStyle.roundedRect
        songNameTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        songNameTextField.text = song.getName()
        self.view.addSubview(songNameTextField)
        
        let artistLabel = UILabel(frame: CGRect(x: 5, y: 125, width: 50, height: 40))
        artistLabel.font = UIFont.systemFont(ofSize: 15)
        artistLabel.text = "Artist:"
        self.view.addSubview(artistLabel)
        
        let artistNameTextField =  UITextField(frame: CGRect(x: 55, y: 125, width: view.frame.size.width - 55, height: 40))
        artistNameTextField.placeholder = "Enter artist name..."
        artistNameTextField.font = UIFont.systemFont(ofSize: 15)
        artistNameTextField.borderStyle = UITextField.BorderStyle.roundedRect
        artistNameTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        artistNameTextField.text = song.getArtistName()
        self.view.addSubview(artistNameTextField)
        
        let lyricsLabel = UILabel(frame: CGRect(x: 5, y: 165, width: 50, height: 40))
        lyricsLabel.font = UIFont.systemFont(ofSize: 15)
        lyricsLabel.text = "Lyrics:"
        self.view.addSubview(lyricsLabel)
        
        let textView = UITextView(frame: CGRect(x: 20.0, y: 90.0, width: view.frame.size.width, height: view.frame.size.height / 2.5))
        textView.center = self.view.center
        textView.backgroundColor = UIColor.lightGray
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.textAlignment = NSTextAlignment.center
        textView.text = song.getLyrics()
        
        self.view.addSubview(textView)
        
        let stageReadyLabel = UILabel(frame: CGRect(x: 5, y: view.frame.size.height - 175, width: view.frame.size.width, height: 40))
        stageReadyLabel.font = UIFont.systemFont(ofSize: 15)
        stageReadyLabel.text = "Is this song stage ready?"
        self.view.addSubview(stageReadyLabel)
        
        let items = ["Work in Progress", "Stage Ready!"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.frame = CGRect(x: 0, y: view.frame.size.height - 125, width: view.frame.size.width - 20, height: 50)
        segmentedControl.center.x = view.frame.size.width / 2
        //segmentedControl.addTarget(self, action: #selector(segmentAction(_:)), for: .valueChanged)
        //segmentedControl.selectedSegmentIndex = 1
        self.view.addSubview(segmentedControl)

        let button = UIButton(frame: CGRect(x: 0, y: view.frame.size.height - 50, width: 100, height: 50))
        button.center.x = view.frame.size.width / 2
        button.setTitle("Save Song", for: .normal)
        button.backgroundColor = .lightGray
        //button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)

        self.view.addSubview(button)
    }
    
}
