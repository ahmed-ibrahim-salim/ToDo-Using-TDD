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
        guard let url = URL(string: "https://awesometodos.com") else {
            fatalError()
        }
        _ = session.dataTask(with: url) { (data, response, error) in
        }
    }
}

class Token{}

extension URLSession: SessionProtocol{}
