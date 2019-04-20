//
//  Test.swift
//  TableMaker
//
//  Created by Роман Чулкевич on 19/04/2019.
//  Copyright © 2019 Роман Чулкевич. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Для генерации n-ого количества чисел с преобразованием к строке
        func generateNumbers(_ n: Int) -> [String] {
            return (0..<n).map{ _ in String(Int.random(in: 1...20)) }
        }
        // Генерируем числа
        let randomNumbers = generateNumbers(45)
        // Отображаем табличку с рандомными числами (самое начало приложения)
        let firstTabViewController = TableViewController.tableInstance("Таблица случайных чисел", randomNumbers, nil)
         // Помещаем в стэк навбара контроллер упомянутой таблички
        self.pushViewController(firstTabViewController, animated: true)
    }
}
