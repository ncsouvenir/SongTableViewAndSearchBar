//
//  SongsViewController.swift
//  SongsTableViewSearchBar
//
//  Created by C4Q on 11/6/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class SongsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchResultsUpdating {
    
    var songArr: [Song] = []
    
//    @IBOutlet weak var searchBar: UISearchBar!
    let searchController = UISearchController(searchResultsController: nil)
    @IBOutlet weak var songsTableView: UITableView!

    //2
    var filteredSongArr: [Song] {
        //make sure there is a searchterm and it is not nil, otherwise retuen original array
        guard let searchTerm = searchTerm, searchTerm != "" else {
            return songArr
        }
        //make sure there are scoprTitles or return the original array
        guard let scopeTitles = self.searchController.searchBar.scopeButtonTitles else {
            return songArr
        }
        
        //What is this doing?
        let selectedIndex = self.searchController.searchBar.selectedScopeButtonIndex // which button has been pressed
        let filteringCriteria = scopeTitles[selectedIndex]
        switch filteringCriteria {
        case "song":
            //return the filtered array based on song
            return songArr.filter{(song) in
                song.name.lowercased().contains(searchTerm.lowercased())
            }
        case "artist":
                return songArr.filter{(song) in
                    song.artist.lowercased().contains(searchTerm.lowercased())
            }
        default:
            return songArr
        }
    }
    //1
    var searchTerm: String? {
        didSet{
            self.songsTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadSongData()
//        searchBar.delegate = self
        songsTableView.delegate = self
        songsTableView.dataSource = self
        
        
        //navigationItem.titleView = mySearchController.searchBar
        
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.scopeButtonTitles = ["song", "artist"]
        searchController.searchBar.delegate = self
        
    }
    //load data
    func loadSongData () {
        songArr = Song.loveSongs
    }
    
    //Mark: - Delegate Methods
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        return 0
    //    }
    //Mark: - Data Source Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //3.
        return filteredSongArr.count //songArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //dequee cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "Song Cell", for: indexPath)
        //3.
        let song = filteredSongArr[indexPath.row]//songArr[indexPath.row]
        cell.textLabel?.text = song.name
        cell.detailTextLabel?.text = song.artist
        return cell
    }
    
    //Mark: - Segue
    //Preparing segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        //where you are going and see if its infact where you are trying to go
        if let destination = segue.destination as? DetailedSongViewController{
            ///go to VC you are changing things to and 1. check for nil and 2. set up the properties
            //what you want to give to the DEVC:
            ///take your episode property and set it to whatever user has selected
            let selectedRow =  self.songsTableView.indexPathForSelectedRow!.row
            //let selectedSeason = self.gOTTableView.indexPathForSelectedRow!.section
            let selectedSong = self.songArr[selectedRow]//[selectedSeason]
            destination.song = selectedSong
        }
    }

    //Mark: - Search Bar Delegates
    //4.
    
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        self.searchTerm = searchBar.text?.lowercased()
//        print("The user presses search")
//        searchBar.resignFirstResponder()
//    }
    
//    //start typing in someones name, it starts filtering...live by live editing
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        print(searchText)
//        self.searchTerm = searchText
//    }
    
    //whenever you cick a button, reload data
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        songsTableView.reloadData()
    }
    
    // UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        self.searchTerm = searchController.searchBar.text

    }

    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
