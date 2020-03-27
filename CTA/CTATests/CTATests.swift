//
//  CTATests.swift
//  CTATests
//
//  Created by casandra grullon on 3/23/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import XCTest
import Firebase
@testable import CTA

class CTATests: XCTestCase {
    
    func testArtAPI() {
        let searchQuery = "girl"
        let exp = XCTestExpectation(description: "Girl in a White Kimono")
        MuseumAPI.getCollections(search: searchQuery) { (result) in
            switch result {
            case .failure(let apiError):
                XCTFail("could not get back data \(apiError.localizedDescription)")
            case .success(let collection):
                XCTAssertEqual(collection.artObjects.first?.title, exp.description)
                exp.fulfill()
            }
        }
        wait(for: [exp], timeout: 5.0)
    }
    func testArtDetailAPI() {
        let objectNumber = "SK-A-3584"
        let exp = XCTestExpectation(description: "Girl in a White Kimono")
        MuseumAPI.getArtworkDetails(objectNumber: objectNumber) { (result) in
            switch result {
            case .failure(let apiError):
                XCTFail("could not get back data \(apiError.localizedDescription)")
            case .success(let artwork):
                XCTAssertEqual(artwork.artObject.title, exp.description)
                exp.fulfill()
            }
        }
        wait(for: [exp], timeout: 5.0)
    }
}

