//
//  CassiniViewController.swift
//  Cassini
//
//  Created by 임지후 on 2018. 8. 29..
//  Copyright © 2018년 임지후. All rights reserved.
//

import UIKit

class CassiniViewController: UIViewController {

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if let url = DemoURLs.NASA[identifier] {
                //var destination = segue.destination
//                if let navcon = destination as? UINavigationController {
//                    destination = navcon.visibleViewController ?? navcon
//                }
                if let imageVC = segue.destination.contents as? imageViewController {
                    imageVC.imageURL = url
                    imageVC.title = (sender as? UIButton)?.currentTitle
                }
            }
        }
    }
  

}

extension UIViewController {
    var contents: UIViewController {
        if let navcon = self as? UINavigationController {
            return navcon.visibleViewController ?? self
        } else {
            return self
        }
    }
}
