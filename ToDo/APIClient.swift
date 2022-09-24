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
    func uploadTask(with: URLRequest, from: Data?, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionUploadTask
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
        
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            guard error == nil else{
                completion(nil, WebServicesError.responseError)
                return
            }
            
            guard let data = data else {
                completion(nil, WebServicesError.DataEmptyError)
                return
            }
            do{
                let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String : String]
                
                let token: Token?
                if let tokenString = dict?["token"]{
                    token = Token(id: tokenString)
                }else{
                    token = nil
                }
                completion(token, nil)
            }catch(let error){
                completion(nil, error)
            }
            
        }
        dataTask.resume()
        
    }
    
    func getAllToDoItems(completion: @escaping ( [String : Any]?, Error? )-> Void ){
        
        guard let url = URL(string: "https://awesometodos.com/alltodoitems") else {
            fatalError()
        }
        let dataTask = session.dataTask(with: url){ (data, response, error) in
            guard error == nil else{
                completion(nil, WebServicesError.responseError)
                return
            }
            guard let data = data else {
                completion(nil, WebServicesError.DataEmptyError)
                return
            }
            do{
                let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String:String]
                
                completion(dict, nil)
            }catch(let error){
                completion(nil, error)
            }
        }
        dataTask.resume()
    }
    func addToDoItemToServer(data: Data,completion: @escaping ( [String : Any]?, Error? )-> Void ){
        
        guard let url = URL(string: "https://awesometodos.com/") else {
            fatalError()
        }
        let urlRequest = URLRequest(url: url)
        let dataTask = session.uploadTask(with: urlRequest, from: data) { (data, response, error) in
            guard error == nil else{
                completion(nil, WebServicesError.responseError)
                return
            }
            guard let data = data else {
                completion(nil, WebServicesError.DataEmptyError)
                return
            }
            do{
                let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String:String]
                
                completion(dict, nil)
            }catch(let error){
                completion(nil, error)
            }
        }
        dataTask.resume()
    }
}
enum WebServicesError: Error{
    case DataEmptyError
    case responseError
}
class Token{
    let id: String
    
    init(id: String){
        self.id = id
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
extension URLSession: SessionProtocol{}
