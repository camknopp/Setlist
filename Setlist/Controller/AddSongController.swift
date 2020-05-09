//
//  AddSongController.swift
//  Setlist
//
//  Created by Cory Knopp on 4/11/20.
//  Copyright © 2020 Cory Knopp. All rights reserved.
//

import UIKit

private let reuseIdentifier = "SongRow"
private let defaultTableHeightOffset:CGFloat = 50

class AddSongController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
   private var songsTable: UITableView!
   private var songs = SongCollection()
   lazy var searchBar:UISearchBar = UISearchBar()
    
   override func viewDidLoad() {
        super.viewDidLoad()
    
        configureSearchBar()
        configureTable()
    }
    
    func configureSearchBar() {
        searchBar.placeholder = "Search for a song..."
        searchBar.sizeToFit()
        searchBar.delegate = self
        
        view.addSubview(searchBar)
        navigationItem.titleView = searchBar
    }
    
    func configureTable() {
        // TODO: should prob make this dynamic so it doesnt look goofy on other devices, something like:
        // UIApplication.shared.statusBarFrame.size.height + (self.navigationController?.navigationBar.frame.height ?? 0.0)
        let barHeight: CGFloat = defaultTableHeightOffset
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height

        songsTable = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        
        songsTable.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        songsTable.dataSource = self
        songsTable.delegate = self
    
        view.addSubview(songsTable)
    }
        
    // Fires when use clicks enter
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        let searchText = searchBar.text ?? ""
        if (containsNonWhiteSpaceChars(text: searchText)) {
            songs.loadSongs(searchText: searchText) { success in
                if (success) {
                    // Swift specific thing where only main thread can update UI
                    DispatchQueue.main.async{
                        self.configureTable()
                    }
                } else {
                    // TODO: handle error
                }
            }
        }
    }
    
    // TODO: if Swift has extension methods make this string extension method
    func containsNonWhiteSpaceChars(text: String) -> Bool {
        let whitespaceSet = CharacterSet.whitespaces
        return !text.trimmingCharacters(in: whitespaceSet).isEmpty
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let song = songs.getSongAtIndex(index: indexPath.row) else { return }
        let saveSongController = EditAndSaveSongController(song: song)
        present(saveSongController, animated: true, completion: nil)
   }

   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.getSongCount()
   }

   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath as IndexPath)
        guard let song = songs.getSongAtIndex(index: indexPath.row) else {
            return cell
        }
    
        // TODO: make the artist part of the text a lighter color
        let labelText = song.getName() + " - by " + song.getArtistName()
    
        cell.textLabel!.text = "\(labelText as String)"
        return cell
   }

}
