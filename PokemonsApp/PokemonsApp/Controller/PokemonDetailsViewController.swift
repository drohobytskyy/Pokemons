//
//  PokemonDetailsViewController.swift
//  PokemonsApp
//
//  Created by @drohobytskyy on 13/04/2022.
//

import UIKit

class PokemonDetailsViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Instance vars
    var pokemonDetails: PokemonDetails?
    private let headerViewHeight: CGFloat = 150.0
    private let estimateRowHeight: CGFloat = 100.0

    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
    }
    
    //MARK: - Private methods
    private func setupUI() {
        self.title = NSLocalizedString("pokemonDetailsView.title", comment: "")        
        self.configureTableView()
    }
}

//MARK: - TableView delegate & datasource
extension PokemonDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PokemonDetailsTableViewCell.self), for: indexPath) as! PokemonDetailsTableViewCell
        
        cell.configureCell(pokemonDetails: self.pokemonDetails)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
        return self.estimateRowHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let pokemonImageView = UIImageView()
        pokemonImageView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.headerViewHeight)
        pokemonImageView.contentMode = .scaleAspectFit
        pokemonImageView.clipsToBounds = true
        
        WebAPI.shared.getPokemonImage(from: self.pokemonDetails?.sprites?.back_default ?? "") { (result) in
            switch result {
            case .failure:
                break
            case .success(let image):
                DispatchQueue.main.async {
                    pokemonImageView.image = image
                }
            }
        }
        
        return pokemonImageView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.headerViewHeight
    }
}

//MARK: - PokemonDetailsViewController additional methods
extension PokemonDetailsViewController {
    func configureTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib.init(nibName:String(describing:PokemonDetailsTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: PokemonDetailsTableViewCell.self))
        self.tableView.separatorStyle = .none
    }
}
