//
//  DetailedSongViewController.swift
//  SongsTableViewSearchBar
//
//  Created by C4Q on 11/6/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class DetailedSongViewController: UIViewController {
    
    @IBOutlet weak var backGroundImageView: UIImageView!
    @IBOutlet weak var loveImageView: UIImageView!
    @IBOutlet weak var songArtistLabel: UILabel!
    @IBOutlet weak var songNameLabel: UILabel!
    
    //before loaded: episodes are nil
    var song: Song? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ///Check to see if you have a movie
        //make sure you have an episode....if you do set up properties
        guard let song = song else {
            return
        }
        //set-up properties of what you want to appear in new VC
        songNameLabel.text = "\(song.name)"
        songArtistLabel.text = "\(song.artist)"
//        backGroundImageView.image = UIImage(named: backGroundImageView)
//        loveImageView.image = UIImage(named: loveImageView)
    }
}
