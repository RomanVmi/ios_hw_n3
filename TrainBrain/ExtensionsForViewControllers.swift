//
//  ExtensionsForViewControllers.swift
//  TableMaker
//
//  Created by Роман Чулкевич on 19/04/2019.
//  Copyright © 2019 Роман Чулкевич. All rights reserved.
//

import UIKit

extension UIViewController {
    static func instance() -> UIViewController {
        let name = String(describing: self)
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: name)
        return viewController
    }
}

extension UIViewController {
    static func tableInstance(_ navBarTitle: String, _ tableItems: [String], _ tableHeader: String?) -> UIViewController {
        let name = String(describing: self)
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let viewController: TableViewController = storyboard.instantiateViewController(withIdentifier: name) as! TableViewController
        viewController.navigationBarTitle = navBarTitle
        viewController.tableItems = tableItems
        viewController.tableHeader = tableHeader
        return viewController
    }
}
