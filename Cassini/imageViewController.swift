//
//  imageViewController.swift
//  Cassini
//
//  Created by 임지후 on 2018. 8. 26..
//  Copyright © 2018년 임지후. All rights reserved.
//  Tip1 : main.storyboard에서 default viewController 삭제후 다시 새로 추가했을 때, 해당 view controller에 왼쪽 화살표를 다시 추가해줘야함.
//  (attribute inspector 탭 >  is Initial View Controller에 체크하기)
//  Tip2 : main.storyboard Scroll view 추가 . Editor > embeded > Scroll view
//  Tip3 : libc++abi.dylib: terminating with uncaught exception of type NSException
//         https://stackoverflow.com/questions/26442414/libcabi-dylib-terminating-with-uncaught-exception-of-type-nsexception-lldb
//          main.storyboard에서  view controller에 매핑되어있었던 @IBoutlet image view 삭제
//  Tip4 : zooming touch <= option Key + drag



import UIKit

class imageViewController: UIViewController, UIScrollViewDelegate {

    //MARK: - Variable
    var imageURL: URL? {
        didSet {
            image = nil
            if view.window != nil {
                fetchImage()
            }
        }
    }
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    //MARK: - Variable
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.minimumZoomScale = 1/25
            scrollView.maximumZoomScale = 1.0
            scrollView.delegate = self
            scrollView.addSubview(imageView)
        }
    }
    
    
    //MARK: - Variable
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
            //spinning stop
            spinner?.stopAnimating()
        }
    }
    
    //MARK: - Function
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if imageView.image == nil {
            fetchImage()
        }
    }
    
     //MARK: - Function
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    //MARK: - Variable
    var imageView = UIImageView()
    
     //MARK: - Function
    private func fetchImage(){
        if let url = imageURL {
            //spinning stop
            spinner.startAnimating()
            
            //Multi threading
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                let urlContents = try? Data(contentsOf:url)
                DispatchQueue.main.async {
                    if let imageData = urlContents, url == self?.imageURL {
                        //inside closure, self.xxx
                        self?.image = UIImage(data: imageData)
                    }
                }
            }
//            //It can throw error, so try Data() or return nil
//           let urlContents = try? Data(contentsOf: url)
//            if let imageData = urlContents {
//                image = UIImage(data: imageData)
//            }
        }
    }
    
    //MARK: - Function
    override func viewDidLoad(){
        super.viewDidLoad()
//        if imageURL == nil {
//            imageURL = DemoURLs.standard
//        }
    }
}

