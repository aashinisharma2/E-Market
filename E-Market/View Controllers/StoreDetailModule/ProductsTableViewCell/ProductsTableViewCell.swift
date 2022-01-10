//
//  ProductsTableViewCell.swift
//  E-Market
//
//  Created by Aashini Sharma on 09/01/22.
//

import UIKit

class ProductsTableViewCell: UITableViewCell, ReuseIdentifier ,NibLoadableView {
    
    //Mark: IB Outlets
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var minusQuantityButton: UIButton!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var plusQuantityLabel: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func minusQuantityButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func plusQuantityButtonTapped(_ sender: UIButton) {
        
    }

    func updateInterface(title:String?,price : Int?){
        productName.text = title
        priceLabel.text = "\(price ?? 0)"
    }

}
