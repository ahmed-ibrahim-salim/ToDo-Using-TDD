//
//  APIClient.swift
//  ToDo
//
//  Created by magdy khalifa on 21/09/2022.
//

import Foundation

protocol SessionProtocol {
    func dataTask(
        with url: URL,
        completionHandler: @escaping
        (Data?, URLResponse?, Error?) -> Void)
    -> URLSessionDataTask
}

class APIClient{
    
    lazy var session: SessionProtocol = URLSession.shared
    
    func loginUser(withName username: String,
                   password: String,
                   completion: @escaping (Token?, Error?) -> Void) {
        
        let queryItems = [URLQueryItem(name: "username", value:                                username.percentEncoded),
                          URLQueryItem(name: "password", value: password.percentEncoded)]
        guard let url = URL(string: "https://awesometodos.com/login?\(queryItems[0])&\(queryItems[1])") else {
            fatalError()
        }
        
        _ = session.dataTask(with: url) { (data, response, error) in
        }
    }
}
extension String {
    
    var percentEncoded: String {
        
        let allowedCharacters = CharacterSet(
             charactersIn:
             "/%&=?$#+-~@<>|\\*,.()[]{}^!").inverted
        guard let encoded = self.addingPercentEncoding(withAllowedCharacters: allowedCharacters)else{fatalError()}
        return encoded
    }
}

class Token{}

extension URLSession: SessionProtocol{}
