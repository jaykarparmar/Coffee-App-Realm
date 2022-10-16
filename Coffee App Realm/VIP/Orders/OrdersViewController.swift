//
//  OrdersViewController.swift
//  Coffee App Realm
//
//  Created by Jaykar Parmar on 16/10/22.
//

import UIKit

protocol OrdersViewControllerProtocol: AnyObject {
    
}

class OrdersViewController: UIViewController {
    
    @IBOutlet weak var tblOrders: UITableView!
    
    var presenter : OrdersPresenter?
    var arrOrders = [CoffeeOrder]()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = OrdersInteractor()
        let presenter = OrdersPresenter()
        
        //View Controller will communicate with only presenter
        viewController.presenter = presenter
        
        //Presenter will communicate with Interector and Viewcontroller
        presenter.viewController = viewController
        presenter.interactor = interactor
        
        //Interactor will communicate with only presenter.
        interactor.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setDetails()
    }
    
    func setupView() {
        self.tblOrders.register(UINib(nibName: "OrdersTableViewCell", bundle: nil), forCellReuseIdentifier: "OrdersTableViewCell")
        self.tblOrders.delegate = self
        self.tblOrders.dataSource = self
    }
    
    func setDetails() {
        self.arrOrders = self.presenter?.getOrdersFromRealm() ?? []
        DispatchQueue.main.async {
            self.tblOrders.reloadData()
        }
    }
    
    func deleteOrder(indexPath: IndexPath!) -> Void {
        self.presenter?.deleteOrder(order: self.arrOrders[indexPath.row], completion: {
            self.arrOrders.remove(at: indexPath.row)
            self.tblOrders.deleteRows(at: [indexPath], with: .fade)
        })
    }
    
    
    func moveToAddUpdateView(isEdit: Bool, order: CoffeeOrder? = nil) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc : AddUpdateOrdersViewController = mainStoryboard.instantiateViewController(withIdentifier: "AddUpdateOrdersViewController") as! AddUpdateOrdersViewController
        vc.isOrderEdit = isEdit
        vc.myOrder = order
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func actionAdd(_ sender: Any) {
        self.moveToAddUpdateView(isEdit: false)
    }
    
    @IBAction func actionLogout(_ sender: Any) {
        self.presenter?.removeRealm(completion: {
            kAppDelegate.callLoginScreen()
        })
    }
    

}

extension OrdersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrOrders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : OrdersTableViewCell = tableView.dequeueReusableCell(withIdentifier: "OrdersTableViewCell", for: indexPath) as! OrdersTableViewCell
        let data = self.arrOrders[indexPath.row]
        cell.lblCoffeeType.text = data.coffeeType
        cell.lblCoffeeSize.text = data.coffeeSize
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.deleteOrder(indexPath: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.moveToAddUpdateView(isEdit: true, order: self.arrOrders[indexPath.row])
    }

}

extension OrdersViewController: OrdersViewControllerProtocol {
    
}
