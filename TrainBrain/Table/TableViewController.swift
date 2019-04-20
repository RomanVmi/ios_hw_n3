//
//  FirstTabViewController.swift
//  TableMaker
//
//  Created by Роман Чулкевич on 19/04/2019.
//  Copyright © 2019 Роман Чулкевич. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var navigationBarTitle: String!
    var tableItems: [String]!
    var tableHeader: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = navigationBarTitle
        tableView.dataSource = self
    }
    
    // При клике на значение ячейки вызываем segue с нажатой кнопкой в качестве сендера
    @IBAction func showCellValue(_ sender: UIButton) {
        performSegue(withIdentifier: "ButtonSegue", sender: sender)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CellValueViewController {
            // т.к. теперь мы уверены, что наш сендер - кнопка, можем переопределеть сендер для вытаскивания текста с него, но все же проверим
            guard let sender = sender as? UIButton else {
                fatalError("Can't convert sender to UIButton!")
            }
            // если все ок, присваем значение ячейки лейблу в следующем контроллере
            destination.cellLabelText = sender.titleLabel?.text ?? ""
        }
    }

}

extension TableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.tableHeader
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // количество ячеек = количество элементов в массиве данных
        return self.tableItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellViewController") as! CellViewController
        // в качестве значения ячейки устаналиваем соответствующий элемент из массива с рандомными числами
        cell.setup(with: String(self.tableItems[indexPath.row]))
        return cell
    }
    
}
