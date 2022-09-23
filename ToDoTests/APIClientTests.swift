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
        mockURLSession = MockURLSession(data: nil, urlResponse: nil, responseError: nil)
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
    func test_Login_WhenSuccessful_CreatesToken() {
        // (\") backslah to include " in the string
        let jsonData = "{\"token\" : \"1234567890\"}".data(using: .utf8)
        mockURLSession = MockURLSession(data: jsonData, urlResponse: nil, responseError: nil)
        sut.session = mockURLSession
        
        let tokenExpectation = expectation(description: "Token expectation")
        var caughtToken: Token?
        sut.loginUser(withName: "Foo", password: "Bar"){ token, _ in
            caughtToken = token
            tokenExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1){ _ in
            XCTAssertEqual(caughtToken?.id, "1234567890")
        }
    }
    func test_Login_WhenJSONIsInvalid_ReturnsError() {
        mockURLSession = MockURLSession(data: Data(), urlResponse: nil, responseError: nil)
        sut.session = mockURLSession
        let errorExpectation = expectation(description: "Error expectation")
        
        var caughtError: Error?
        sut.loginUser(withName: "Foo", password: "Bar"){ (token, error) in
            caughtError = error
            errorExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1){
            _ in
            XCTAssertNotNil(caughtError)
            
        }
    }
    func test_Login_WhenDataIsNil_ReturnsError() {
        mockURLSession = MockURLSession(data: nil, urlResponse: nil, responseError: nil)
        sut.session = mockURLSession
        let errorExpectation = expectation(description: "Error expectation")
        
        var caughtError: Error?
        sut.loginUser(withName: "Foo", password: "Bar"){ (token, error) in
            caughtError = error
            errorExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1){
            _ in
            XCTAssertNotNil(caughtError)
            
        }
    }
    func test_Login_WhenResponseHasError_ReturnsError() {
        let error = NSError(domain: "Server Error", code: 123, userInfo: nil)
        let jsonData = "{\"token\" : \"1234\"}".data(using: .utf8)
        let mockSession = MockURLSession(data: jsonData, urlResponse: nil, responseError: error)
        sut.session = mockSession
        
        let errorExpectation = expectation(description: "Error")
        var catchedError: Error? = nil
        sut.loginUser(withName: "Foo", password: "Bar") { (token, error) in
          catchedError = error
          errorExpectation.fulfill()
        }
        waitForExpectations(timeout: 1) { (error) in
          XCTAssertNotNil(catchedError)
   }
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
        private let dataTask: MockTask
        
        init(data: Data?, urlResponse: URLResponse?, responseError: Error?){
            self.dataTask = MockTask(data: data, urlResponse: urlResponse, responseError: responseError)
        }
        
        func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)-> URLSessionDataTask{
            self.url = url
            dataTask.completionHandler = completionHandler
            return dataTask
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
