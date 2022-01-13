//
//  OrderSummaryViewController.swift
//  E-Market
//
//  Created by Aashini on 09/01/22.
//

import UIKit

class OrderSummaryViewController: UIViewController {
    
    //MARK: IB Outlets
    @IBOutlet weak var subtotalLabel      : UILabel!
    @IBOutlet weak var productsTableView  : UITableView!
    @IBOutlet weak var buyButton          : UIButton!
    
    //MARK: Properties
    private let textView = UITextView(frame: CGRect.zero)
    let viewModel = OrderSummaryViewModel()
    var notifyStoryDetailScreen:(() -> ())? = nil

    //MARK: View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
        registerCells()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == StringConstant.bounds.rawValue {
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

//MARK: IB Actions
extension OrderSummaryViewController {
    
    @IBAction func buyButtonTapped(_ sender: UIButton) {
        
        self.showAlertWithTextView()
    }
}

//MARK: Private Functions
private extension OrderSummaryViewController {
    
    func initialSetup() {
        
        viewModel.updateSubTotal()
        subtotalLabel.text = StringConstant.subTotal.value + " \(viewModel.subTotal)"
        buyButton.setTitle(StringConstant.proceedToBuy.rawValue, for: .normal)
    }
    
    func registerCells() {
        
        self.productsTableView.register(cell: ProductsTableViewCell.self)
    }
    
    func showAlertWithTextView() {
        
        let alertController = UIAlertController(title: StringConstant.addDeliveryDetails.value + "\n\n\n\n\n", message: nil, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction.init(title: StringConstant.cancel.value, style: .default) { (action) in
            alertController.view.removeObserver(self, forKeyPath: StringConstant.bounds.rawValue)
        }
        alertController.addAction(cancelAction)
        
        let saveAction = UIAlertAction(title: StringConstant.submit.value, style: .default) { (action) in
            //            let enteredText = self.textView.text
            self.buyTapped()
            alertController.view.removeObserver(self, forKeyPath: StringConstant.bounds.rawValue)
        }
        alertController.addAction(saveAction)
        
        alertController.view.addObserver(self, forKeyPath: StringConstant.bounds.rawValue, options: NSKeyValueObservingOptions.new, context: nil)
        textView.backgroundColor = UIColor.white
        textView.textContainerInset = UIEdgeInsets.init(top: 8, left: 5, bottom: 8, right: 5)
        alertController.view.addSubview(self.textView)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func onTapOfPlusMinus(isAdding:Bool , product: Product?,quantity:Int) {
        
        for count in 0..<viewModel.products.count{
            if viewModel.products[count].id == product?.id {
                viewModel.products[count].quantity = quantity
            }
        }
        
        isAdding ? (viewModel.subTotal += product?.price ?? 0) : (viewModel.subTotal -= product?.price ?? 0)
        
        subtotalLabel.text = StringConstant.subTotal.value + " \(viewModel.subTotal)"
        viewModel.quantityManager?.quantiyChanged(id: product?.id ?? 0, quantiy: quantity)
    }
    
    func buyTapped() {
        
        viewModel.address = textView.text
        
        self.view.activityStartAnimating(activityColor: UIColor.gray, backgroundColor: .clear)
        
        viewModel.hitPostOrderApi(completionHandler: { [weak self] (message) in
            
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                
                self.view.activityStopAnimating()
                if message != nil {
                    guard let notifyClosure = self.notifyStoryDetailScreen else { return }
                    notifyClosure()
                    self.navigationController?.popViewController(animated: true)
                    
                } else {
                    UIAlertController.showError(withMessage: message ?? "", onViewController: self)
                }
            }
        })
    }
}

//MARK: TableViewDataSources Methods
extension OrderSummaryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let productCell : ProductsTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
        
        productCell.selectButton.isHidden = true
        
        productCell.populateCellData(model:viewModel.populateData(_product: viewModel.products[indexPath.row]))
        
        productCell.quantityButton = { [weak self] (isAdding) in
            
            guard let self = self else { return }
            self.onTapOfPlusMinus(isAdding:isAdding ,product: self.viewModel.products[indexPath.item],quantity: productCell.quantity )
        }
        
        return productCell
    }
}

//MARK: TableViewDelegates Methods
extension OrderSummaryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
