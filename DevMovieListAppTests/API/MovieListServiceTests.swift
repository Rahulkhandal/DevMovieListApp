//
//  MovieListServiceTests.swift
//  DevMovieListAppTests
//
//  Created by Rahul on 18/06/24.
//

import Foundation
import XCTest
import DevNetworking

@testable import DevMovieListApp

final class MovieListServiceTests: XCTestCase {
    
    var sut: MovieListService?
    private let mockAPIClient = MockNetworkModule()
    
    override func setUp() {
        super.setUp()
        sut = MovieListService(networkModule: MockNetworkModule())
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func makeNetworkResponse(data: Data?, code: Int) -> NetworkResponse {
        var response = NetworkResponse()
        response.data = data
        response.n
        NetworkResponse(data: data!, networkResponse: HTTPURLResponse(url: URL(string: "https://rahul.com")!, statusCode: code, httpVersion: nil, headerFields: nil)!)
    }

    func test_fetch_products() {

        // Given A apiservice
        let sut = self.sut!

        // When fetch popular photo
        let expect = XCTestExpectation(description: "callback")
        let page = 1
        let successResponse = MovieResult.init(results: [], currentPage: 1, totalPages: 1)
        let encodedResponse = try? JSONEncoder().encode(successResponse)
        self.mockAPIClient.simulatedNetworkResponse = makeNetworkResponse(data: encodedResponse, code: 200)
        self.mockAPIClient.simulatedNetworkError = nil
        sut.fetchLatestMovieList(page: page) { result in
            switch result {
            case .success(let result):
                expect.fulfill()
                XCTAssert(result.results.isEmpty)
                
            case .failure:
                expect.fulfill()
                // As per our test it will not come here
            }
        }

        wait(for: [expect], timeout: 3.1)
    }
    
}
