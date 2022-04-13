//
//  ViewController.swift
//  PokemonsApp
//
//  Created by @drohobytskyy on 12/04/2022.
//

import UIKit

class PokemonsViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Instance vars
    private var viewModel: PokemonViewModelProtocol!
    private var pokemons = [PokemonDetails]()
    private var searcResults = [PokemonDetails]()
    private var isSearching: Bool = false
    private var isFetching = false
    private var activityIndicator: UIActivityIndicatorView?
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    //MARK: - Private methods
    private func setupUI() {
        self.title = NSLocalizedString("pokemonsView.title", comment: "")
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.viewModel = PokemonViewModel()
        self.configureSearchBar()
        self.configureCollectionView()
        self.createActivityIndicator()
        
        self.viewModel.pokemons = { [weak self] pokemons in
            self?.pokemons.append(contentsOf: pokemons)
            DispatchQueue.main.async {
                self?.isFetching = false
                self?.showActivity(show: false)
                self?.collectionView.reloadData()
            }
        }
        
        self.fetchPkemons()
    }
    
    private func fetchPkemons() {
        self.isFetching = true
        self.showActivity(show: true)
        self.viewModel.offset = self.pokemons.count
        self.viewModel.fetchPokemons()
    }
}

//MARK: - Collection delegate & datasource
extension PokemonsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearching {
            return self.searcResults.count
        }
        return self.pokemons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PokemonCollectionViewCell.self), for: indexPath) as! PokemonCollectionViewCell
        
        if isSearching {
            cell.configureCell(name: self.searcResults[indexPath.row].name, imageURL: self.pokemons[indexPath.row].sprites.front_default ?? "")
        } else {
            cell.configureCell(name: self.pokemons[indexPath.row].name, imageURL: self.pokemons[indexPath.row].sprites.front_default ?? "")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if !self.viewModel.hasNextPage || self.isFetching || self.isSearching {
            return
        }
        
        if indexPath.row + 1 == self.pokemons.count {
            self.fetchPkemons()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: String(describing: PokemonDetailsViewController.self)) as? PokemonDetailsViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension PokemonsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.isSearching = true
        
        if searchText.isEmpty {
            self.searcResults = self.pokemons
        } else {
            self.searcResults = PokemonViewModel.serach(by: searchText, pokemons: self.pokemons)
        }
        
        self.collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        self.searchBar.text = ""
        self.isSearching = false
        self.searcResults = []
        self.collectionView.reloadData()
    }
}

//MARK: - PokemonsViewController additional methods
extension PokemonsViewController {
    func createActivityIndicator() {
        self.activityIndicator = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.large)
        self.activityIndicator?.alpha = 0
        self.activityIndicator?.center = self.view.center
        guard let activityIndicator = activityIndicator else { return }
        self.view.addSubview(activityIndicator)
    }
    
    func showActivity(show: Bool) {
        guard let activityIndicator = self.activityIndicator else { return }
        
        if show {
            activityIndicator.alpha = 1.0
            activityIndicator.startAnimating()
        } else {
            activityIndicator.alpha = 0
            activityIndicator.stopAnimating()
        }
    }
    
    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        layout.itemSize = CGSize(width: (self.view.frame.size.width / 1.5), height: (self.view.frame.size.width / 1.5))
        
        self.collectionView.collectionViewLayout = layout
        
        self.collectionView.register(PokemonCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: PokemonCollectionViewCell.self))
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.frame = self.view.bounds
        
        self.view.addSubview(collectionView)
    }
    
    func configureSearchBar() {
        self.searchBar.delegate = self
        self.searchBar.searchBarStyle = .minimal
        self.searchBar.showsCancelButton = true
        searchBar.placeholder = NSLocalizedString("pokemonsView.searchBar.placeholder", comment: "")
    }
}
