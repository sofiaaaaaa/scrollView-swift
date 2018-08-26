//
//  imageViewController.swift
//  Cassini
//
//  Created by 임지후 on 2018. 8. 26..
//  Copyright © 2018년 임지후. All rights reserved.
//  Tip1 : main.storyboard에서 default viewController 삭제후 다시 새로 추가했을 때, 해당 view controller에 왼쪽 화살표를 다시 추가해줘야함.
//  (attribute inspector 탭 >  is Initial View Controller에 체크하기)
//  Tip2 : main.storyboard Scroll view 추가 . Editor > embeded > Scroll view


import UIKit

class imageViewController: UIViewController {

    //model
    var imageURL: URL? {
        didSet {
            imageView.image = nil
            if view.window != nil {
                fetchImage()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if imageView.image == nil {
            fetchImage()
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    private func fetchImage(){
        if let url = imageURL {
            //It can throw error, so try Data() or return nil
           let urlContents = try? Data(contentsOf: url)
            if let imageData = urlContents {
                imageView.image = UIImage(data: imageData)
            }
        }
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        if imageURL == nil {
            imageURL = DemoURLs.standard
        }
    }
}

