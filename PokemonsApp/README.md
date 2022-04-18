# Pokemons App

* IOS app, gets data from external API and presents collection of pokemons

## Main goals

* Present a list of Pokemons composed by name and image on the main screen
* On item selection redirect to details screen
* On details screen preset pokemon with at least 7 properties
* Use pagination
* Functional programming
* Dependency Injection
* Unit Testing
* UI Testing
* Adapt UI to mobile orientation changes

## Tools

* IDE: xCode 13
* Language: Swift
* Web API: https://pokeapi.co/

## Architecture

* MVVM

## Structure

### WebAPI

* WebAPI: Responsible to fetch data from API 

### Extensions

* UtilityExtensions: contains generic customizations for UIKit elements

### Model

* PokemonModel: struct that contains pokemon data parsed from API

### View

* PokemonCollectionViewCell: layout for pokemon item used in PokemonViewController
* PokemonDetailsTableViewCell: layout for pokemon item used in PokemonDetailsViewController

### ViewModel

* PokemonViewModel: class responsible to sync data between API and PokemonViewController

### Controller

* PokemonViewController: makes interaction between PokemonModel and PokemonCollectionViewCell to build user interface
* PokemonDetailsViewController: displays pokemon details

### Resources

* Localizable file

### Unit tests

* Unit tests for PokemonViewModel methods

### UI tests

* General UI tests





