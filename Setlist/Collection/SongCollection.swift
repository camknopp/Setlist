//
//  SongCollection.swift
//  Setlist
//
//  Created by Cory Knopp on 4/12/20.
//  Copyright © 2020 Cory Knopp. All rights reserved.
//

import Foundation

class SongCollection {
    
    private let musixMatchService = MusixMatchService()
    private var songs:[Song] = []
    
    // This is a fucking nightmare but Swift is awful with JSON.
    // TODO: break up for readability. logic up to status code should be handled in service class
    func loadSongs(searchText: String, completion: @escaping (_ success: Bool)->()) -> () {
        songs = []
        musixMatchService.search(searchText: searchText) { json in
            if let songsJson = try? JSONSerialization.jsonObject(with: json) as? [String: Any] {
                if let message = songsJson["message"] as? [String: Any] {
                    if let header = message["header"] as? [String: Any] {
                        if header["status_code"] as! Int == 200 { // 200 is the success HTTP response code
                            if let body = message["body"] as? [String: Any] {
                                if let tracks = body["track_list"] as? [Any] {
                                    if tracks.count > 0 {
                                        for n in 0...tracks.count - 1 {
                                            if let track = tracks[n] as? [String: Any] {
                                                if let trackDetails = track["track"] as? [String: Any] {
                                                    if let trackName = trackDetails["track_name"] as? String {
                                                        if trackName.contains("Karaoke") || trackName.contains("karaoke")
                                                        {
                                                        let song = Song()
                                                        song.setName(name: trackName)
                                                        song.setMusixMatchSongID(id: trackDetails["track_id"] as! Int)
                                                        song.setArtistName(artist: trackDetails["artist_name"] as! String)
                                                        self.songs.append(song)
                                                        }
                                                    }
                                                }
                                            }
                                        }
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
    
    func getSongAtIndex(index: Int) -> Song! {
        if (index > getSongCount() - 1) {
            return nil
        }
        return songs[index]
    }
    
    func getSongCount() -> Int {
        return songs.count
    }
}
