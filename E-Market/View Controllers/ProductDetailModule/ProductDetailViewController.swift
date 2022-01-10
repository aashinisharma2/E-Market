//
//  ProductDetailViewController.swift
//  E-Market
//
//  Created by Aashini on 09/01/22.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    //Mark: IB Outlets
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var minusQuantityButton: UIButton!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var plusQuantityLabel: UIButton!
    @IBOutlet weak var goToCartButton: UIButton!
    @IBOutlet weak var addToCartButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

//Mark: IB Actions
extension ProductDetailViewController {
    
    @IBAction func minusQuantityButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func plusQuantityButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func goToCartButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func addToCartButtonTapped(_ sender: UIButton) {
        
    }
}

//Mark: Private Functions
private extension StoreDetailViewController {
    
}
