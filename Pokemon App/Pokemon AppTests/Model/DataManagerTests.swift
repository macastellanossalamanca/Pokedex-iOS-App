
import XCTest
import Pokemon_App

final class DataManagerTests: XCTestCase {
    
    var dataDelegateMock: DataManagerDelegateMock?
    var initialURL: String = ""
    
    override func setUp() {
        dataDelegateMock = DataManagerDelegateMock()
        initialURL = "https://pokeapi.co/api/v2/pokemon"
    }
    
    override func tearDown() {
        dataDelegateMock = nil
    }
    
    func testFetchPokemons() async throws {
        let expectation = XCTestExpectation(description: "Should have loaded info")
        dataDelegateMock?.dataManager.fetchPokemons(url: self.initialURL)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            if self.dataDelegateMock?.initialInfo != nil {
                expectation.fulfill()
            }
        })
        wait(for: [expectation], timeout: 3)
    }
    
    func testFetchPokemonsNextPagination() throws {
        let expectation1 = XCTestExpectation(description: "Should have loaded info")
        let expectation2 = XCTestExpectation(description: "Should have loaded next page of pokemons")
        var initialInfo: InitialPokedexInfo?
        dataDelegateMock?.dataManager.fetchPokemons(url: self.initialURL)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            if let safeURL = self.dataDelegateMock?.initialInfo?.next {
                initialInfo = self.dataDelegateMock?.initialInfo
                self.dataDelegateMock?.dataManager.fetchPokemons(url: safeURL)
                expectation1.fulfill()
            }
        })
        wait(for: [expectation1], timeout: 3)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            if self.dataDelegateMock?.initialInfo?.next != initialInfo?.next {
                expectation2.fulfill()
            }
        })
        wait(for: [expectation2], timeout: 3)
    }
    
    func testFetchPokemonsPreviousPagination() throws {
        let expectation1 = XCTestExpectation(description: "Should have loaded info")
        let expectation2 = XCTestExpectation(description: "Should have loaded previous page of pokemons")
        var initialInfo: InitialPokedexInfo?
        dataDelegateMock?.dataManager.fetchPokemons(url: self.initialURL)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            if let safeURL = self.dataDelegateMock?.initialInfo?.next {
                initialInfo = self.dataDelegateMock?.initialInfo
                self.dataDelegateMock?.dataManager.fetchPokemons(url: safeURL)
                expectation1.fulfill()
            }
        })
        wait(for: [expectation1], timeout: 3)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            if self.dataDelegateMock?.initialInfo?.next != initialInfo?.next {
                expectation2.fulfill()
            }
        })
        wait(for: [expectation2], timeout: 3)
    }
    
}
