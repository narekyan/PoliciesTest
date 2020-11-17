//
//  PoliciesTestTests.swift
//  PoliciesTestTests
//
//  Created by Narek on 11/17/20.
//

import XCTest
@testable import PoliciesTest

class PoliciesTestTests: XCTestCase {
    
    static let json = """
[{\
"type": "policy_created",\
"payload": {\
"timestamp": "2020-11-17T13:33:05.208Z",\
"policy_id": "dev_pol_0000003",\
"start_date": "2020-11-17T13:33:05.208Z",\
"end_date": "2020-11-17T14:33:05.208Z",\
"vehicle": {\
"prettyVrm": "MA77 GRO",\
"make": "Volkswagen",\
"model": "Polo",\
"variant": "SE 16V",\
"color": "Silver",\
"notes": "notes"\
}\
}\
}]
"""
    let policyEventStream = PolicyEventStream(MockNetworkFeature())

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        policyEventStream.fetch { }
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCars() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssert(self.policyEventStream.cars.count == 2)
        XCTAssert(self.policyEventStream.cars[1].count == 1)
        XCTAssert(self.policyEventStream.cars[1][0].vehicle.make == "Volkswagen")
    }

    func testPolicies() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let car = self.policyEventStream.cars[1][0]
        XCTAssert(car.policies?.count == 1)
        XCTAssert(car.policies?.first?.endDate() == "2020-11-17T14:33:05.208Z")
        XCTAssert(car.policies?.first?.duration() == 3600)
    }
    
    func testCarViewModel() throws {
        let car = self.policyEventStream.cars[1][0]
        let viewModel = CarViewModel(car)
        XCTAssert(viewModel.remaining == 0)
        XCTAssert(viewModel.policyState == .insure)
        XCTAssert(viewModel.vrm == "MA77 GRO")
    }
    
    func testPolicyViewModel() throws {
        let policy = self.policyEventStream.cars[1][0].policies![0]
        let viewModel = PolicyViewModel(policy)
        XCTAssert(viewModel.duration == "1 hours")
    }
}

class MockNetworkFeature: IPolicyEventStreamNetworkFeature {
    func getStream(completion: @escaping ([PolicyEvent]?, String?) -> Void) {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let events = try! jsonDecoder.decode([PolicyEvent].self, from: PoliciesTestTests.json.data(using: .utf8)!)
        completion(events, nil)
    }
}
