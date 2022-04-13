//
//  PokemonCollectionViewCell.swift
//  PokemonsApp
//
//  Created by @drohobytskyy on 12/04/2022.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    static let identifier = "PokemonCollectionViewCell"
    
    //MARK: - Instace vars
    private let pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .blue
        return imageView
    }()
    
    private let pokemonNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = .yellow
        return label
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(self.pokemonImageView)
        self.contentView.addSubview(self.pokemonNameLabel)
    
        self.contentView.clipsToBounds = true
        self.contentView.backgroundColor = .gray
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    //MARK: - Life cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.contentView.layer.cornerRadius = self.contentView.frame.width / 2
        
        self.pokemonImageView.frame = CGRect(x: 0, y: 0, width: self.contentView.frame.width, height: self.contentView.frame.height - 50)
        self.pokemonNameLabel.frame = CGRect(x: 0, y: self.pokemonImageView.frame.maxY, width: self.contentView.frame.width, height: 50)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.pokemonNameLabel.text = nil
        self.pokemonImageView.image = nil
    }
    
    //MARK: - Private methods
    public func configureCell(name: String, image: UIImage?) {
        self.pokemonNameLabel.text = name
        if let image = image {
            self.pokemonImageView.image = image
        }
    }
}
