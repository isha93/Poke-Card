//
//  DotaviewmodelTest.swift
//  Poke-CardTests
//
//  Created by Mas Bagus on 01/06/24.
//
@testable import Poke_Card
import XCTest
@MainActor
final class DotaviewmodelTest: XCTestCase {
    var sut : DotaViewModel!
    var expectedResponse: [Poke_Card.DotaHeroesModelData]!
    var dotaServiceMock: DotaServicesMock!
    
    override func setUpWithError() throws {
        expectedResponse = [Poke_Card.DotaHeroesModelData(id: 1, name: "pikachu", localizedName: "pikachu", primaryAttr: .agi, attackType: .melee, roles: ["n"], legs: 2)]
        dotaServiceMock = DotaServicesMock(expatedResponse: expectedResponse)
        sut = DotaViewModel(dotaServices: dotaServiceMock)
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        sut = nil
        dotaServiceMock = nil
        expectedResponse = nil
        try super.tearDownWithError()
    }
    
    func test_getDota_success() async {
        do {
            await sut.getDota(name: "")
            XCTAssertEqual(sut.dotas.first?.name!, "pikachu")
        }
    }
    func test_getDota_failed() async {
        do {
            dotaServiceMock.result = .failed
            await sut.getDota(name: "")
        } catch let error as NetworkError{
            XCTAssertEqual(error.localizedDescription, "gaada internet cuk")
        }
    }
    

}
class DotaServicesMock: DotaServicesProtocol {
    var networker: any Poke_Card.NetworkerProtocol
    var expatedResponse : [Poke_Card.DotaHeroesModelData]?
    var result : Result
    init(networker: any Poke_Card.NetworkerProtocol = Networker() , expatedResponse: [Poke_Card.DotaHeroesModelData], result: Result = .success) {
        self.networker = networker
        self.expatedResponse = expatedResponse
        self.result = result
    }
    
    func getDotas(endPoint: Poke_Card.NetworkFactory) async throws -> [Poke_Card.DotaHeroesModelData] {
        switch result {
        case .success:
            return expatedResponse!
        case .failed:
            throw NetworkError.internetError(message: "gaada internet cuk")
        }
    }
}

enum Result {
    case success
    case failed
}
