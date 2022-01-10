//
//  OrderSummaryViewController.swift
//  E-Market
//
//  Created by Aashini on 09/01/22.
//

import UIKit

class OrderSummaryViewController: UIViewController {
    
    //Mark: IB Outlets
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var productsTableView: UITableView!
    @IBOutlet weak var buyButton: UIButton!
    
    //Mark: Properties
    private let textView = UITextView(frame: CGRect.zero)
    
    //Mark: View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "bounds"{
            if let rect = (change?[NSKeyValueChangeKey.newKey] as? NSValue)?.cgRectValue {
                let margin: CGFloat = 8
                let xPos = rect.origin.x + margin
                let yPos = rect.origin.y + 54
                let width = rect.width - 2 * margin
                let height: CGFloat = 90
                
                textView.frame = CGRect.init(x: xPos, y: yPos, width: width, height: height)
            }
        }
    }
}

//Mark: Private Functions
private extension OrderSummaryViewController {
    
    func initialSetup() {
        
    }
    
    func registerCells() {
        
        self.productsTableView.register(cell: ProductsTableViewCell.self)
        
    }
    
    func showAlertWithTextView() {
        
        let alertController = UIAlertController(title: "Add Delivery Address \n\n\n\n\n", message: nil, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .default) { (action) in
            alertController.view.removeObserver(self, forKeyPath: "bounds")
        }
        alertController.addAction(cancelAction)
        
        let saveAction = UIAlertAction(title: "Submit", style: .default) { (action) in
            //            let enteredText = self.textView.text
            alertController.view.removeObserver(self, forKeyPath: "bounds")
        }
        alertController.addAction(saveAction)
        
        alertController.view.addObserver(self, forKeyPath: "bounds", options: NSKeyValueObservingOptions.new, context: nil)
        textView.backgroundColor = UIColor.white
        textView.textContainerInset = UIEdgeInsets.init(top: 8, left: 5, bottom: 8, right: 5)
        alertController.view.addSubview(self.textView)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}

//Mark: IB Actions
extension OrderSummaryViewController {
    
    @IBAction func buyButtonTapped(_ sender: UIButton) {
        self.showAlertWithTextView()
    }
}

//Mark: TableViewDataSources Methods
extension OrderSummaryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let productCell : ProductsTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
        return productCell
    }
}

//Mark: TableViewDelegate Methods
extension OrderSummaryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
    
}


