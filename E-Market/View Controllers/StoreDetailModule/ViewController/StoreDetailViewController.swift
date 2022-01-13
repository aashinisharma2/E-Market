//
//  StoreDetailViewController.swift
//  E-Market
//
//  Created by Aashini on 09/01/22.
//

import UIKit

protocol CartRouter {
    func routeToCartController()
}

class StoreDetailViewController: UIViewController{
    
    //MARK: IB Outlets
    @IBOutlet var storeProductsTabelView      : UITableView!
    @IBOutlet weak var storeInfoView          : UIView!
    @IBOutlet weak var storeNameLabel         : UILabel!
    @IBOutlet weak var ratingLabel            : UILabel!
    @IBOutlet weak var openingTimeLabel       : UILabel!
    @IBOutlet weak var closingTimeLabel       : UILabel!
    @IBOutlet weak var productsHeadingLabel   : UILabel!
    @IBOutlet weak var addToCartButton        : UIButton!
    
    //MARK: Properties
    var viewModel: StoreDetailViewModel = StoreDetailViewModel()
    private var refreshControl:UIRefreshControl!
    var dataStatus = false

    //MARK: View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
        registerCells()
        initRefreshControl()
        fetchData()
    }
    
    @objc func fetchData() {
        
        self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))

        viewModel.fecthData(completion: { [weak self] (status , message) in
            
            guard let self = self else { return }
            
            self.view.activityStopAnimating()
            
            if status ?? false {
                
                self.storeProductsTabelView.reloadData()
                self.viewModel.totalItemsInCard =  0
                self.populateStoreData()
                
            } else {
                UIAlertController.showError(withMessage: message , onViewController: self)
            }
            self.refreshControl.endRefreshing()
        })
    }
    
    @objc func cartButtonTapped() {
        self.routeToCartController()
    }
}

//MARK: IB Actions
extension StoreDetailViewController {
    
    @IBAction func addToCartTapped(_ sender: Any) {
        
        viewModel.addDataToCard()
        setUpCartIcon()
    }
}

//MARK: Private Functions
private extension StoreDetailViewController {
    
     func initialSetup() {
        
        navigationItem.title = StringConstant.storeDetail.value
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "cart"), style: .plain, target: self, action: #selector(cartButtonTapped))
        storeProductsTabelView.tableHeaderView = storeInfoView
    }
    
    func registerCells() {
        
        self.storeProductsTabelView.register(cell: ProductsTableViewCell.self)
    }
    
    func initRefreshControl(){
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: StringConstant.pullToRefresh.value)
        self.refreshControl.addTarget(self, action: #selector(fetchData), for: UIControl.Event.valueChanged)
        storeProductsTabelView.refreshControl = refreshControl
    }
    
    func onTapOfPlusMinus(isAdding: Bool , product: Product?,quantity:Int , id: Int = 0) {
        
        viewModel.products?[product?.id ?? 0].quantity = quantity
    }
    
    func populateStoreData() {
        
        guard let model = viewModel.store, let openingTime = model.openingTime, let closingTime = model.closingTime else {return}
        
        self.storeNameLabel.text = model.name
        self.ratingLabel.text = StringConstant.rating.value+": \(model.rating ?? 0.0)"
        self.openingTimeLabel.text = StringConstant.openingTime.value+": \(openingTime.changeDateStringFormat())"
        self.closingTimeLabel.text = StringConstant.closingTime.value+": \(closingTime.changeDateStringFormat())"
    }

    func setUpCartIcon() {
        
        viewModel.totalItemsInCard == 0 ? (navigationItem.rightBarButtonItem?.removeBadge()) :         (navigationItem.rightBarButtonItem?.addBadge(number: viewModel.totalItemsInCard))

    }
}

//MARK: TableViewDataSources Methods
extension StoreDetailViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (viewModel.products?.count) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let productCell : ProductsTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
        
        if let product = viewModel.products?[indexPath.row] {
            productCell.populateCellData(model: self.viewModel.populateData(_product: product))
        }
        
        productCell.quantityButton = { [weak self] ( isAdding) in
            
            guard let self = self else { return }
            
            self.onTapOfPlusMinus(isAdding: isAdding, product: self.viewModel.products?[indexPath.item],quantity: productCell.quantity )
        }
        
        return productCell
    }
}

//MARK: TableViewDelegate Methods
extension StoreDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if viewModel.products?[indexPath.row].quantity ?? 0 > 0 {
            
            self.viewModel.products?[indexPath.row].isSelected?.toggle()
            viewModel.updateItemCountInCart(isAdding: (self.viewModel.products?[indexPath.row].isSelected ?? false))
            self.storeProductsTabelView.reloadData()
        }
    }
}

extension  StoreDetailViewController : CartRouter {
    
    @objc func routeToCartController() {
        
        let storyboard = UIStoryboard(name: AppStoryboard.main.rawValue, bundle: nil)
        
        if let controller:OrderSummaryViewController = storyboard.instantiateVC() {
            
            viewModel.updateItem()
            controller.viewModel.products = viewModel.itemsIncard
            controller.viewModel.quantityManager = self
            controller.notifyStoryDetailScreen = { [weak self] in
                guard  let `self` = self else { return }
                self.viewModel.itemsIncard.removeAll()
                self.viewModel.totalItemsInCard = 0
                self.setUpCartIcon()
                self.fetchData()
            }
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}

extension StoreDetailViewController: OrderQuantityManager {
    
    /// IT will update product model quantity as per the param.
    /// - Parameters:
    ///   - id: product id for which product we want to update quantify
    ///   - quantiy: quantity for update.
    ///   Right now updating directly becaue id is same as index in array else we have to iterat over product and with if condition will update it
    
    func quantiyChanged(id: Int, quantiy: Int) {
        
        viewModel.products?[id].quantity = quantiy
    }
}
