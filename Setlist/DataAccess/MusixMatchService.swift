//
//  MusixMatchService.swift
//  Setlist
//
//  Created by Cory Knopp on 4/11/20.
//  Copyright © 2020 Cory Knopp. All rights reserved.
//

import Foundation

class MusixMatchService {
    
    static let baseUrl = "https://api.musixmatch.com/ws/1.1/"
    static let apiKey = "fccc7f32e576d16171d19f5b3e705e26"
        
    // General search function that queries both artists and songs
    func search(searchText: String, completion: @escaping (_ json: Data)->()) -> () {
        let urlString = "https://api.musixmatch.com/ws/1.1/track.search&q_track_artist=" + searchText + "&page_size=50&s_artist_rating=asc&s_track_rating=asc&f_has_lyrics=1&apikey=fccc7f32e576d16171d19f5b3e705e26"
        if let url = URL(string: urlString)
        {
            URLSession.shared.dataTask(with: url)  { data, res, err in
                if let data = data {
                    completion(data)
                }
            }.resume()
        }
    }
    
    func loadSongLyrics(musixMatchSongID: Int, completion: @escaping (_ json: Data)->()) -> () {
        let urlString = "https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=" + String(musixMatchSongID) + "&apikey=fccc7f32e576d16171d19f5b3e705e26"
        if let url = URL(string: urlString)
        {
            URLSession.shared.dataTask(with: url)  { data, res, err in
                if let data = data {
                    completion(data)
                }
            }.resume()
        }
    }
}
