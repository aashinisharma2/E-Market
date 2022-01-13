//
//  NetworkManager.swift
//  E-Market
//
//  Created by Aashini on 10/01/22.
//

import UIKit

class NetworkManager: NSObject {

    enum URLError : Error {
        
        case URLISNIL
        case URLBadScheme
    }
    
    struct NetworkError : Error {
        
        var errorCode : String
        var errorType : String
    }
   
    static var shared = NetworkManager()
    
    private override init() {
        super.init()
        
    }
    
    private lazy var queue : OperationQueue = {
        
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 4
        return queue
    }()
    
    private lazy var session : URLSession = {
        
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: self.queue)
        return  session
    }()
    
    func getData(url : URL , completionHandler:@escaping(Data? , Error?)->Void) -> URLSessionTask {
        
        let sessionTask = self.session.dataTask(with: url) { (data, response, error) in
           completionHandler(data,error)
        }
        sessionTask.resume()
        return sessionTask
    }
    
    func postData(url: URL , param:[String:Any], completionHandler:@escaping(Data? , Error?)->Void) {
        
        print( param)
        let parameterDictionary = param
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let postData = try? JSONSerialization.data(withJSONObject: parameterDictionary)
        request.httpBody = postData
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                    completionHandler(data , error)
                } catch {
                    completionHandler(nil , error)

                    print(error)
                }
            }
        }.resume()
    }
    
    func submitOrder(urlString : String , param : [String:Any] ,completion: @escaping(Data? , Error?)->Void) {
        
        let urlString = urlString
        guard let url = URL(string: urlString) else { return }
        var request : URLRequest = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        print(param)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        do {
            let postData = try JSONSerialization.data(withJSONObject: param)
            request.httpBody = postData
        } catch {
            print(error.localizedDescription)
        }

        let dataTask = URLSession.shared.dataTask(with: request) { data,response,error in
            guard let data = data else { return }
            completion(data, error )
        }
        dataTask.resume()
    }
}
