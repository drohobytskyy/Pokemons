//
//  PokemonCollectionViewCell.swift
//  PokemonsApp
//
//  Created by @drohobytskyy on 12/04/2022.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    static let identifier = "PokemonCollectionViewCell"
    
    private let pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let pokemonNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(pokemonImageView)
        self.contentView.addSubview(pokemonNameLabel)
        self.contentView.clipsToBounds = true
        self.contentView.backgroundColor = .gray
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.contentView.layer.cornerRadius = self.contentView.frame.width / 2
        
        self.pokemonNameLabel.frame = CGRect(x: 5, y: self.contentView.frame.height - 50, width: self.contentView.frame.width - 10, height: 50)
        self.pokemonImageView.frame = CGRect(x: 0, y: 0, width: self.contentView.frame.width, height: self.contentView.frame.height - 50)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.pokemonNameLabel.text = nil
        self.pokemonImageView.image = nil
    }
    
    public func configureCell(name: String, image: UIImage?) {
        self.pokemonNameLabel.text = name
        if let image = image {
            self.pokemonImageView.image = image
        }
    }
}
