//
//  PokemonsAppUITests.swift
//  PokemonsAppUITests
//
//  Created by @drohobytskyy on 12/04/2022.
//

import XCTest

class PokemonsAppUITests: XCTestCase {
    
    let app = XCUIApplication()
    let sleepTime: UInt32 = 5

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testSelectPokemon() throws {
        self.app.launch()
        sleep(self.sleepTime)
        
        let firstPokemon = app.collectionViews.children(matching:.any).element(boundBy: 0)
        if firstPokemon.exists {
            firstPokemon.tap()
            sleep(self.sleepTime)
        }
    }
    
    func testSearchAndShowDetails() throws {
        self.app.launch()
        sleep(self.sleepTime)
        
        let searchBar = self.app.searchFields.element(boundBy: 0)
        if searchBar.exists {
            searchBar.tap()
            searchBar.typeText("charizard")
            sleep(self.sleepTime)
            
            let firstPokemon = app.collectionViews.children(matching:.any).element(boundBy: 0)
            if firstPokemon.exists {
                firstPokemon.tap()
                sleep(self.sleepTime)
            }
        }
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
