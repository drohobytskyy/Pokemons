//
//  PokemonDetailsTableViewCell.swift
//  PokemonsApp
//
//  Created by itsector on 14/04/2022.
//

import UIKit

class PokemonDetailsTableViewCell: UITableViewCell {
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var baseExperienceLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }
    
    private func setupUI() {
        self.idLabel.pokemonDetailsCellStyle()
        self.nameLabel.pokemonDetailsCellStyle()
        self.weightLabel.pokemonDetailsCellStyle()
        self.heightLabel.pokemonDetailsCellStyle()
        self.baseExperienceLabel.pokemonDetailsCellStyle()
        self.abilitiesLabel.pokemonDetailsCellStyle()
        self.abilitiesLabel.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func configureCell(pokemonDetails: PokemonDetails?) {
        guard let pokemon = pokemonDetails else { return }
        
        self.idLabel.text = NSLocalizedString("pokemonDetails.id", comment: "") + "\(Int(pokemon.id ?? 0))"
        self.nameLabel.text = NSLocalizedString("pokemonDetails.name", comment: "") + (pokemon.name ?? "")
        self.weightLabel.text = NSLocalizedString("pokemonDetails.weight", comment: "") + "\(Int(pokemon.weight ?? 0))"
        self.heightLabel.text = NSLocalizedString("pokemonDetails.heigt", comment: "") + "\(Int(pokemon.height ?? 0))"
        self.baseExperienceLabel.text = NSLocalizedString("pokemonDetails.baseExperience", comment: "") + "\(Int(pokemon.base_experience ?? 0))"
        
        let ablities = PokemonViewModel.getAbilities(pokemon: pokemon).joined(separator: ", ")
        self.abilitiesLabel.text = NSLocalizedString("pokemonDetails.abilities", comment: "") + ablities
    }
}
