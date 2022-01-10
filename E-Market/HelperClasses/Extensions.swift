//
//  Extensions.swift
//  E-Market
//
//  Created by Aashini on 09/01/22.
//

import Foundation
import UIKit

protocol ReuseIdentifier : class {
    
}

extension ReuseIdentifier where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

protocol NibLoadableView : class{
    
}

extension NibLoadableView where Self : UIView {
    static var nibName : String {
        return String(describing: self)
    }
}

extension UITableView {
    func register<T>(cell : T.Type) where T : ReuseIdentifier,T : UITableViewCell , T : NibLoadableView {
        register(UINib(nibName: T.nibName, bundle: nil), forCellReuseIdentifier: T.reuseIdentifier)
    }
    func dequeueReusableCell<T>(indexPath: IndexPath) -> T where T : UITableViewCell, T : ReuseIdentifier {
        guard  let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("\(type(of: self)) Could not dequeue cell with identifier \(T.reuseIdentifier)")
        }
        return cell
    }
}

extension UIStoryboard {
    func instantiateVC<T: UIViewController>() -> T? {
        // get a class name and demangle for classes in Swift
        if let name = NSStringFromClass(T.self).components(separatedBy: ".").last {
            return instantiateViewController(withIdentifier: name) as? T
        }
        return nil
    }
}
