//
//  ViewController.swift
//  PokemonsApp
//
//  Created by @drohobytskyy on 12/04/2022.
//

import UIKit

class PokemonsViewController: UIViewController {
    private var viewModel: PokemonViewModelProtocol!
    private var pokemons = [Pokemon]()
    private var isFetching = false
    private var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    private func setupUI() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: (self.view.frame.size.width - 50), height: (self.view.frame.size.width - 50))
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        guard let collectionView = self.collectionView else {
            return
        }
        
        collectionView.register(PokemonCollectionViewCell.self, forCellWithReuseIdentifier: PokemonCollectionViewCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.frame = self.view.bounds
        
        self.view.addSubview(collectionView)
        
        self.viewModel = PokemonViewModel()
        
        self.viewModel.pokemons = { [weak self] pokemons in
            self?.pokemons.append(contentsOf: pokemons)
            DispatchQueue.main.async {
                self?.isFetching = false
                self?.collectionView?.reloadData()
            }
        }
        
        self.fetchPkemons()
    }
    
    private func fetchPkemons() {
        self.isFetching = true
        self.viewModel.offset = self.pokemons.count
        self.viewModel.fetchPokemons()
    }
}

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

