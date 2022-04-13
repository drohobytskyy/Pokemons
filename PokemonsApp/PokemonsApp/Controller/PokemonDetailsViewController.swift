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
    private var pokemonImageView: UIImageView = UIImageView()
    private let headerViewHeight: CGFloat = 200.0

    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
    }
    
    //MARK: - Private methods
    private func setupUI() {
        self.title = (self.pokemonDetails?.name ?? "") + NSLocalizedString("pokemonDetailsView.title", comment: "")
        self.navigationController?.customAppStyle()
        
        self.configureTableView()
        self.pokemonImageView.contentMode = .scaleAspectFit
        self.pokemonImageView.clipsToBounds = true
    }
}

extension PokemonDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.headerViewHeight)
        self.pokemonImageView.frame = headerView.frame
        
        WebAPI.shared.getPokemonImage(from: self.pokemonDetails?.sprites.back_default ?? "") { (result) in
            switch result {
            case .failure:
                break
            case .success(let image):
                DispatchQueue.main.async {
                    self.pokemonImageView.image = image
                }
            }
        }
        
        headerView.addSubview(self.pokemonImageView)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.headerViewHeight
    }
}

extension PokemonDetailsViewController {
    func configureTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.separatorStyle = .none
    }
}
