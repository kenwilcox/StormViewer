//
//  DetailViewController.swift
//  StormViewer
//
//  Created by Kenneth Wilcox on 10/11/15.
//  Copyright © 2015 Kenneth Wilcox. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

  @IBOutlet weak var scrollView: UIScrollView!
  var detailImageView: UIImageView!
  
  var detailItem: String? {
    didSet {
      // Update the view.
      self.configureView()
    }
  }
  
  func configureView() {
    // Update the user interface for the detail item.
    if let detail = self.detailItem {
      if let imageView = self.detailImageView {
        imageView.image = UIImage(named: detail)
        imageView.frame = self.scrollView.bounds
        self.scrollView.contentSize = imageView.bounds.size
        self.scrollView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.scrollView.delegate = self
        
        let imageViewSize = imageView.bounds.size
        let scrollViewSize = scrollView.bounds.size
        let widthScale = scrollViewSize.width / imageViewSize.width
        let heightScale = scrollViewSize.height / imageViewSize.height
        
        let zoomScale = min(widthScale, heightScale)
        self.scrollView.maximumZoomScale = 4.0
        self.scrollView.minimumZoomScale = 0.5
        self.scrollView.zoomScale = zoomScale
        
        self.scrollView.contentMode = .ScaleAspectFill
        //self.scrollView.frame = imageView.bounds
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    self.detailImageView = UIImageView(frame: self.scrollView.bounds)
    self.scrollView.addSubview(self.detailImageView)

    self.configureView()
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.hidesBarsOnTap = true
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.hidesBarsOnTap = false
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}

extension DetailViewController: UIScrollViewDelegate {
  func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
    return self.detailImageView
  }
}
