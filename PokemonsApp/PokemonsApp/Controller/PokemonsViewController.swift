//
//  ViewController.swift
//  PokemonsApp
//
//  Created by @drohobytskyy on 12/04/2022.
//

import UIKit

class PokemonsViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Instance vars
    private var viewModel: PokemonViewModelProtocol!
    private var pokemons = [Pokemon]()
    private var isFetching = false
    private var activityIndicator: UIActivityIndicatorView?
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    //MARK: - Private methods
    private func setupUI() {
        self.viewModel = PokemonViewModel()
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
        return self.pokemons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCollectionViewCell.identifier, for: indexPath) as! PokemonCollectionViewCell
        cell.configureCell(name: self.pokemons[indexPath.row].name, image: UIImage(systemName: ""))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if !self.viewModel.hasNextPage || self.isFetching {
            return
        }
        
        if indexPath.row + 1 == self.pokemons.count {
            self.fetchPkemons()
        }
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
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: (self.view.frame.size.width - 50), height: (self.view.frame.size.width - 50))
        
        self.collectionView.collectionViewLayout = layout
        
        self.collectionView.register(PokemonCollectionViewCell.self, forCellWithReuseIdentifier: PokemonCollectionViewCell.identifier)
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.frame = self.view.bounds
        
        self.view.addSubview(collectionView)
    }
}
