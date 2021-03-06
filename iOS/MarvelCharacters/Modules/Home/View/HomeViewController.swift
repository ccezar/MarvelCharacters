//
//  HomeViewController.swift
//  MarvelCharacters
//
//  Created by Caio Cezar Lopes dos Santos on 07/02/20.
//  Copyright © 2020 MyExperiments. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var titleErrorLabel: UILabel!
    @IBOutlet weak var messageErrorLabel: UILabel!
    @IBOutlet weak var retryErrorButton: UIButton!
    
    private let refreshControl = UIRefreshControl()
    private var startingScrollingOffset = CGPoint.zero
    private let searchController = UISearchController(searchResultsController: nil)
    
    var presenter: HomeViewToPresenterProtocol?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.updateCharactersFavoriteStatus()
        collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.startFetchingCharacters()
    
        collectionView.delegate = self
        collectionView.dataSource = self
        
        configureRefreshControl()
        configureSearchController()

        hideErrorView()
    }
    
    @IBAction func didTapRetryButton(_ sender: Any) {
        presenter?.startFetchingCharacters()
    }
    
    @objc private func refreshData(_ sender: Any) {
        presenter?.searchActive = false
        searchController.dismiss(animated: true, completion: nil)
        searchController.searchBar.text = ""
        presenter?.startFetchingCharacters()
    }
    
    private func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.searchBar.delegate = self
        
        searchController.hidesNavigationBarDuringPresentation = false
        //searchController.dimsBackgroundDuringPresentation = true
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search by characters name"
        searchController.searchBar.sizeToFit()
        
        searchController.searchBar.becomeFirstResponder()
        
        navigationItem.titleView = searchController.searchBar
    }
    
    private func configureRefreshControl() {
        if #available(iOS 10.0, *) {
            collectionView.refreshControl = refreshControl
        } else {
            collectionView.addSubview(refreshControl)
        }
        
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        refreshControl.attributedTitle = NSAttributedString(string: "Reloading Data ...", attributes: nil)
    }
    
    private func showErrorView(message: String, showRetry: Bool) {
        errorView.isHidden = false
        collectionView.isHidden = true
        
        messageErrorLabel.text = message
        retryErrorButton.isHidden = !showRetry
    }
    
    private func hideErrorView() {
        errorView.isHidden = true
        collectionView.isHidden = false
    }
}

//MARK: HomePresenterToViewProtocol
extension HomeViewController: HomePresenterToViewProtocol {
    func showErrorInternetConnection() {
        showErrorView(message: "Looks like there is no internet connection", showRetry: true)
    }
    
    func showCharacters() {
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
        
        if let presenter = presenter, presenter.getCharacters().count > 0 {
            collectionView.reloadData()
            hideErrorView()
        } else {
            showErrorView(message: "Looks like there is no characters to list. Did you want to try again?",
                          showRetry: true)
        }
    }
    
    func appendCharacters(characters: [Character]?) {
        collectionView.reloadData()
        hideErrorView()
    }
    
    func showError() {
        showErrorView(message: "An error has occurred, please try again.", showRetry: true)
    }
    
    func showErrorAppend() {
        let alert = UIAlertController(title: "Ops!",
                                      message: "An error has occurred in pagination, please try again.",
                                      preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    func showErrorRefresh() {
        showErrorView(message: "An error has occurred to refresh data, please try again.", showRetry: true)
    }
    
    func showErrorFilter() {
        showErrorView(message: "An error has occurred to filter data.", showRetry: false)
    }
}

//MARK: UICollectionView
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.getCharacters().count ?? 0
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
      startingScrollingOffset = scrollView.contentOffset
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let count = presenter?.getCharacters().count else {
            return
        }
        
        if (indexPath.row == count - 4) {
            presenter?.startLoadingCharactersNextPage()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCollectionViewCell", for: indexPath) as! CharacterCollectionViewCell
        
        guard let character = presenter?.getCharacters()[indexPath.row] else {
            return UICollectionViewCell()
        }
        
        cell.character = character
        cell.delegate = self

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let navigationController = self.navigationController, let character = presenter?.getCharacters()[indexPath.row] else {
            return
        }
        
        presenter?.showCharacterDetailController(character: character, navigationController: navigationController)
    }
}

//MARK: UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 230)
    }
}

//MARK: CharacterCollectionViewCellProtocol
extension HomeViewController: CharacterCollectionViewCellProtocol {
    func updateFavoriteStatus(character: Character) {
        presenter?.updateFavoriteStatus(character: character)
    }
}

//MARK: Search Bar
extension HomeViewController: UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        return
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter?.searchActive = false
        collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        collectionView.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        presenter?.searchActive = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchString = searchBar.text {
            presenter?.startFilteringCharacters(nameStartsWith: searchString)
            collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        }
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        if !(presenter?.searchActive ?? false) {
            presenter?.searchActive = true
        }
        
        searchController.searchBar.resignFirstResponder()
    }
}


