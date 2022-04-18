//
//  PokemonCollectionViewCell.swift
//  PokemonsApp
//
//  Created by @drohobytskyy on 12/04/2022.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Instace vars
    private let pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .primaryColor()
        return imageView
    }()
    
    private let pokemonNameLabel: UILabel = {
        let label = UILabel()
        label.pokemonCollectionCellNameLabelStyle()
        return label
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    //MARK: - Life cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.updateFrames()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.pokemonNameLabel.text = nil
        self.pokemonImageView.image = nil
    }
    
    //MARK: - Private methods
    private func setupUI() {
        self.contentView.addSubview(self.pokemonImageView)
        self.contentView.addSubview(self.pokemonNameLabel)
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = UIColor.primaryColor().cgColor
        self.contentView.clipsToBounds = true
    }
    
    private func updateFrames() {
        self.contentView.layer.cornerRadius = self.contentView.frame.width / 2
        self.pokemonImageView.frame = CGRect(x: 0, y: 0, width: self.contentView.frame.width, height: self.contentView.frame.height - 50)
        self.pokemonNameLabel.frame = CGRect(x: 0, y: self.pokemonImageView.frame.maxY, width: self.contentView.frame.width, height: 50)
    }
    
    //MARK: - Public methods
    public func configureCell(name: String, imageURL: String) {
        self.pokemonNameLabel.text = name
        WebAPI.shared.getPokemonImage(from: imageURL) { (result) in
            switch result {
            case .failure:
                break
            case .success(let image):
                DispatchQueue.main.async {
                    self.pokemonImageView.image = image
                }
            }
        }
    }
}
