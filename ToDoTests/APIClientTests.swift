//
//  APIClientTests.swift
//  ToDoTests
//
//  Created by magdy khalifa on 21/09/2022.
//

import XCTest
@testable import ToDo

class APIClientTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
        
    }
    
    func test_Login_UsesExpectedHost() {
        // given
        let sut = APIClient()
        let mockURLSession = MockURLSession()
        sut.session = mockURLSession
        
        let completion = { (token: Token?, error: Error?) in}
        // when
        sut.loginUser(withName:"dasdom",
                      password: "1234",
                      completion: completion)
        guard let url = mockURLSession.url else{
            XCTFail()
            return
        }
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        // then
        XCTAssertEqual(urlComponents?.host, "awesometodos.com")
    }
    func test_Login_UsesExpectedPath(){
        
    }
}

extension APIClientTests{
    
    class MockURLSession: SessionProtocol{
        var url: URL?
        
        func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)-> URLSessionDataTask{
            self.url = url
            return URLSession.shared.dataTask(with: url)
            
        }
    }
}
