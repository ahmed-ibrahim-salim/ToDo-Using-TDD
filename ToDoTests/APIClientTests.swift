//
//  APIClientTests.swift
//  ToDoTests
//
//  Created by magdy khalifa on 21/09/2022.
//

import XCTest
@testable import ToDo

class APIClientTests: XCTestCase {
    var sut: APIClient!
    var mockURLSession: MockURLSession!
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = APIClient()
        mockURLSession = MockURLSession()
        sut.session = mockURLSession
    }
    
    override func tearDownWithError() throws {
        
    }
    
    func test_Login_UsesExpectedHost() {
        // given
        
        let completion = { (token: Token?, error: Error?) in}
        // when
        sut.loginUser(withName:"dasdom",
                      password: "1234",
                      completion: completion)
        // then
        XCTAssertEqual(mockURLSession.urlComponents?.host, "awesometodos.com")
    }
    func test_Login_UsesExpectedPath(){
        // given
        let completion = { (token: Token?, error: Error?) in}
        // when
        sut.loginUser(withName:"dasdom",
                      password: "1234",
                      completion: completion)
        // then
        XCTAssertEqual(mockURLSession.urlComponents?.path, "/login")
    }
    func test_Login_UsesExpectedQuery(){
        // given
        let completion = { (token: Token?, error: Error?) in}
        // when
        sut.loginUser(withName:"dasdöm",
                      password: "%&34",
                      completion: completion)
        // then
        XCTAssertEqual(mockURLSession.urlComponents?.percentEncodedQuery, "username=dasd%C3%B6m&password=%25%2634")
    }
}

extension APIClientTests{
    
    class MockURLSession: SessionProtocol{
        var url: URL?
        var urlComponents: URLComponents? {
            guard let url = url else {
                return nil
            }
            return URLComponents(url: url, resolvingAgainstBaseURL: true)
        }
        private let dataTask: MockTask?
        
        init(data: Data?, urlResponse: URLResponse?, responseError: Error?){
            self.dataTask = MockTask(data: data, urlResponse: urlResponse, responseError: responseError)
        }
        
        func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)-> URLSessionDataTask{
            self.url = url
            return URLSession.shared.dataTask(with: url)
        }
    }
    
    class MockTask: URLSessionDataTask{
        typealias CompletionHandler = (Data?, URLResponse?, Error?)-> Void
        private let data: Data?
        private let urlResponse: URLResponse?
        private let responseError: Error?
        var completionHandler: CompletionHandler?
        
        init(data: Data?, urlResponse: URLResponse?, responseError: Error?){
            self.data = data
            self.urlResponse = urlResponse
            self.responseError = responseError
        }
        override func resume() {
            DispatchQueue.main.async {
                self.completionHandler?(self.data,self.urlResponse, self.responseError)
            }
        }
    }
}
