//
//  FavoritesViewController.swift
//  MarvelCharacters
//
//  Created by Caio Cezar Lopes dos Santos on 08/02/20.
//  Copyright © 2020 MyExperiments. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var titleErrorLabel: UILabel!
    @IBOutlet weak var messageErrorLabel: UILabel!

    private let searchController = UISearchController(searchResultsController: nil)
    
    var presenter: FavoritesViewToPresenterProtocol?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.startLoadingFavorites()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        configureSearchController()
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
    
    private func showErrorView() {
        errorView.isHidden = false
        collectionView.isHidden = true
    }
    
    private func hideErrorView() {
        errorView.isHidden = true
        collectionView.isHidden = false
    }
    
    private func reloadCollection() {
        if let presenter = presenter, presenter.getFavorites().count > 0 {
            collectionView.reloadData()
            hideErrorView()
        } else {
            showErrorView()
        }
    }
}

//MARK: FavoritesPresenterToViewProtocol
extension FavoritesViewController: FavoritesPresenterToViewProtocol {
    func showFavorites() {
        reloadCollection()
    }
    
    func showError() {
        // TODO: Show errors
    }
}

//MARK: UICollectionView
extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.getFavorites().count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCollectionViewCell", for: indexPath) as! FavoriteCollectionViewCell
        
        cell.favorite = presenter?.getFavorites()[indexPath.row]
        cell.delegate = self
        
        // TODO: Remove reference of Alamofire from View layer. Is it correct to move this logic to Presenter and Interactor respectively?
        if let imageURL = presenter?.getFavorites()[indexPath.row].imageURL, imageURL != "" {
            Alamofire.request(imageURL).responseImage { [weak self] (response) in
                if response.error == nil, let image = response.value {
                    cell.thumbImageView.image = image
                }
            }
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

//MARK: UICollectionViewDelegateFlowLayout
extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 230)
    }
}

//MARK: FavoriteCollectionViewCellProtocol
extension FavoritesViewController: FavoriteCollectionViewCellProtocol {
    func removeFavorite(id: Int) {
        presenter?.removeFavorite(id: id)
        reloadCollection()
    }
}

//MARK: Search Bar
extension FavoritesViewController: UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        return
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter?.clearCurrentFilter()
        collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        collectionView.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {

    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchString = searchBar.text {
            presenter?.setCurrentFilter(nameStartsWith: searchString)
        }
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        
        searchController.searchBar.resignFirstResponder()
    }
}



