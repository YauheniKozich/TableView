//
//  ViewController.swift
//  TableView
//
//  Created by Yauheni Kozich on 15.05.21.
//

import UIKit

class SecondVC: UIViewController {
    
    let tableView = UITableView()
    var coutries: [Country] = []
    
   weak var delegate: MainVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Select a country"
        coutries = fetchData()
        configureTableView()
        
    }
    
    
   private func configureTableView(){
        view.addSubview(tableView)
        setTableViewDelegate()
        tableView.rowHeight = 80
        tableView.register(MainCellTableViewCell.self, forCellReuseIdentifier: Cells.countryCell)
        tableView.pin(to: view)
        
    }
    func setTableViewDelegate() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}

extension SecondVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coutries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.countryCell) as! MainCellTableViewCell
        let country = coutries[indexPath.row]
        cell.set(country: country)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cont = self.coutries[indexPath.row]
        delegate?.update(name: cont.title,image: cont.image)
        dismiss(animated: true, completion: nil)
    }
}


extension SecondVC {
    
    func fetchData() -> [Country] {
        let country1 = Country(image: Images.canada, title: "Canada")
        let country2 = Country(image: Images.cuba, title: "Cuba")
        let country3 = Country(image: Images.honduras, title: "Honduras")
        let country4 = Country(image: Images.liberia, title: "Liberia")
        let country5 = Country(image: Images.malta, title: "Malta")
        let country6 = Country(image: Images.panama, title: "Panama")
        let country7 = Country(image: Images.philippines, title: "Philippines")
        let country8 = Country(image: Images.uganda, title: "Uganda")
        
        return [country1,country2,country3,country4,country5,country6,country7,country8]
    }
}



