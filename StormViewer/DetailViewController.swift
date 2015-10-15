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
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    self.detailImageView = UIImageView(image: UIImage(named:"nssl0049.jpg"))
    self.detailImageView.frame = self.scrollView.bounds
    self.detailImageView.contentMode = .ScaleAspectFill
    self.scrollView.contentMode = .ScaleAspectFit
    
    self.scrollView.delegate = self
    
    let scale = self.detailImageView.frame.size.width / self.scrollView.frame.size.width
    self.scrollView.maximumZoomScale = scale;
    self.scrollView.minimumZoomScale = 0.25;
    //let scale = self.scrollView.frame.size.width  / self.detailImageView.frame.size.width
    //self.scrollView.zoomScale = scale;
    //self.scrollView.zoomScale = 1
    
    //self.scrollView.clipsToBounds = true
    //self.detailImageView.sizeToFit()
    
    self.scrollView.addSubview(self.detailImageView)
    self.scrollView.contentSize = self.detailImageView.frame.size;

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
