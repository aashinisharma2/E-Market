//
//  BaseRequestUseCase.swift
//  Ecommerce
//
//  Created by Aashini Sharma on 10/01/22.
//

import UIKit


class BaseRequestUseCase <T> {
    
    func initialize()  {
        fatalError("This is an Abstract Base class, Method should be override")
        
    }
    func getDataFromServerUsingGet(url : URL, completionHandler:@escaping(T? , Error?) -> Void) -> URLSessionTask{
        
        return NetworkManager.shared.getData(url:url) { (data, error) in
            if let error = error  {
                DispatchQueue.main.async {
                    completionHandler(nil , error)
                }
            }else{
                guard let unwrappedData = data else {
                    DispatchQueue.main.async {
                        completionHandler(nil,nil);
                    }
                    return
                }
                do {
                    let response = try self.decode(data: unwrappedData)
                    DispatchQueue.main.async {
                        completionHandler(response,nil)
                    }
                }
                catch {
                    DispatchQueue.main.async {
                        completionHandler(nil,error)
                    }
                }
            }
            
        }
        
    }
    
    func decode(data : Data)throws -> T {
        fatalError("This is an Abstract Base class, Method should be override")
    }
}
