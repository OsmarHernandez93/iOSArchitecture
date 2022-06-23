//
//  SearchViewController.swift
//  iOSArchitecture
//
//  Created by Osmar Hernandez on 22/06/22.
//

import AVKit
import UIKit
import Combine

class SearchViewController: UIViewController {

    private var viewModel: SearchSongViewModel!
    private var subscriptions = Set<AnyCancellable>()
    
    private var playerViewController = AVPlayerViewController()
    
    private var tableFooterView: UIView {
        let tableFooterView = UIView()
        tableFooterView.backgroundColor = .black
        return tableFooterView
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = .systemGray5
        tableView.delegate = self
        tableView.dataSource = self
        tableView.insetsContentViewsToSafeArea = true
        tableView.contentInsetAdjustmentBehavior = .automatic
        tableView.tableFooterView = tableFooterView
        return tableView
    }()
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search by song or artist"
        return searchController
    }()
    
    convenience init(viewModel: SearchSongViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Welcome!"
        navigationItem.searchController = searchController
        view.addSubview(tableView)
        
        viewModel
            .$songResults
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }.store(in: &subscriptions)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func playDownload(_ song: Song) {
        present(playerViewController, animated: true) { [weak playerViewController] in
            if let url = URL(string: song.previewUrl) {
                playerViewController?.player = AVPlayer(url: url)
                playerViewController?.player?.play()
            }
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchTerm = searchBar.text ?? ""
        searchController.dismiss(animated: true) { [weak viewModel] in
            viewModel?.songInput = searchTerm
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.songInput = ""
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let song = viewModel.songResults[indexPath.row]
        cell.textLabel?.text = song.name
        cell.detailTextLabel?.text = song.artist
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let song = viewModel.songResults[indexPath.row]
        playDownload(song)
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.songResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let subtitleCell = tableView.dequeueReusableCell(withIdentifier: "subtitleCell") else {
            return UITableViewCell(style: .subtitle, reuseIdentifier: "subtitleCell")
        }
        return subtitleCell
    }
}
