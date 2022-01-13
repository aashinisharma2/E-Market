//
//  ProductsTableViewCell.swift
//  E-Market
//
//  Created by Aashini on 09/01/22.
//

import UIKit

class ProductsTableViewCell: UITableViewCell, ReuseIdentifier ,NibLoadableView {
    
    //MARK: IB Outlets
    @IBOutlet weak var productImageView     : UIImageView!
    @IBOutlet weak var productName          : UILabel!
    @IBOutlet weak var priceLabel           : UILabel!
    @IBOutlet weak var minusQuantityButton  : UIButton!
    @IBOutlet weak var quantityLabel        : UILabel!
    @IBOutlet weak var plusQuantityLabel    : UIButton!
    @IBOutlet weak var selectButton         : UIButton!
    
    //MARK: Properties
    var quantity = 0
    var quantityButton: ((Bool) -> ())? = nil
    var price : Int = 1
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //To show data after API response
    func populateCellData(model: Product) {
        
        price = model.price ?? 0
        productName.text = model.name
        quantity = model.quantity ?? 1
        quantityLabel.text = "\(quantity)"
        selectButton.isSelected = model.isSelected ?? false
        priceLabel.text = "\(model.price ?? 0)"
        productImageView.downloaded(from: model.imageUrl ?? "")
    }
}

//MARK: IB Actions
extension ProductsTableViewCell {
    
    @IBAction func selectButtonTapped(_ sender: UIButton) {
        
        sender.isSelected.toggle()
    }
    
    @IBAction func minusQuantityButtonTapped(_ sender: UIButton) {
        
        if quantity > 1 {
            price = price / quantity
            quantity -= 1
            price = price * quantity
            quantityLabel.text = String(quantity)
            if quantity != 0 {
                priceLabel.text = "\(price)"
            }
            guard let btnAction = quantityButton else {return }
            btnAction(false)
        }
    }
    
    @IBAction func plusQuantityButtonTapped(_ sender: UIButton) {
        
        if quantity < 10 {
            if quantity > 0 {
                price = price / quantity
            }
            quantity += 1
            price = price * quantity
            
            quantityLabel.text = String(quantity)
            if quantity != 0 {
                priceLabel.text = "\(price)"
            }
            guard let btnAction = quantityButton else {return }
            btnAction(true)
        }
    }
}
