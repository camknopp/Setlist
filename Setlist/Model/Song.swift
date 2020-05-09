//
//  Song.swift
//  Setlist
//
//  Created by Cory Knopp on 4/12/20.
//  Copyright © 2020 Cory Knopp. All rights reserved.
//

import Foundation

class Song {
    
    private let musixMatchService = MusixMatchService()

    private var name: String!
    
    private var musixMatchSongID: Int!
    
    private var lyrics: String!
    
    private var artistName: String!
    
    func loadByID(completion: @escaping (_ success: Bool)->()) -> () {
        musixMatchService.loadSongLyrics(musixMatchSongID: getMusixMatchSongID()) { json in
            if let songsJson = try? JSONSerialization.jsonObject(with: json) as? [String: Any] {
                if let message = songsJson["message"] as? [String: Any] {
                    if let header = message["header"] as? [String: Any] {
                        if header["status_code"] as! Int == 200 { // 200 is the success HTTP response code
                            if let body = message["body"] as? [String: Any] {
                                if let lyrics = body["lyrics"] as? [String: Any] {
                                    if let lyricsBody = lyrics["lyrics_body"] as? String {
                                        self.setLyrics(lyrics: lyricsBody)
                                    }
                                    completion(true)
                                }
                            }
                        } else {
                            completion(false)
                        }
                    }
                }
            }
        }
    }

    func setName(name: String) -> () {
        self.name = name
    }
    
    func getName() -> String! {
        return name ?? ""
    }
    
    func setMusixMatchSongID(id: Int) -> () {
        self.musixMatchSongID = id
    }
    
    func getMusixMatchSongID() -> Int! {
        return musixMatchSongID
    }
    
    func setLyrics(lyrics: String) -> () {
        self.lyrics = lyrics
    }
       
    func getLyrics() -> String! {
        return lyrics ?? ""
    }
    
    func setArtistName(artist: String) -> () {
        self.artistName = artist
    }
       
    func getArtistName() -> String! {
        return artistName ?? ""
    }
}
