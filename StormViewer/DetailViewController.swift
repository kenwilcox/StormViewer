//
//  DetailViewController.swift
//  StormViewer
//
//  Created by Kenneth Wilcox on 10/11/15.
//  Copyright © 2015 Kenneth Wilcox. All rights reserved.
//

import UIKit
import Social

class DetailViewController: UIViewController {
  
  @IBOutlet weak var scrollView: UIScrollView!
  var detailImageView: UIImageView!
  
  var detailItem: String? {
    didSet {
      // Update the view.
      self.configureView()
      navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(DetailViewController.shareTapped))
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    self.detailImageView = UIImageView(frame: self.scrollView.bounds)
    self.scrollView.addSubview(self.detailImageView)
    
    self.configureView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.hidesBarsOnTap = true
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.hidesBarsOnTap = false
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func configureView() {
    // Update the user interface for the detail item.
    if let detail = self.detailItem {
      if let imageView = self.detailImageView {
        imageView.image = UIImage(named: detail)
        imageView.frame = self.scrollView.bounds
        self.scrollView.contentSize = imageView.bounds.size
        self.scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.scrollView.delegate = self
        
        let imageViewSize = imageView.bounds.size
        let scrollViewSize = scrollView.bounds.size
        let widthScale = scrollViewSize.width / imageViewSize.width
        let heightScale = scrollViewSize.height / imageViewSize.height
        
        let zoomScale = min(widthScale, heightScale)
        self.scrollView.maximumZoomScale = 4.0
        self.scrollView.minimumZoomScale = 0.5
        self.scrollView.zoomScale = zoomScale
        
        self.scrollView.contentMode = .scaleAspectFill
        //self.scrollView.frame = imageView.bounds
      }
    }
  }
  
  func shareTapped() {
    let url:URL = URL(string: "http://www.photolib.noaa.gov/nssl")!
    let activityItems = ["Look at this great picture from NOAA!", detailImageView.image!, url] as [Any]
    let vc = UIActivityViewController(activityItems: activityItems, applicationActivities: [])
    
    // If they're on an iPad then we want to make it a popover
    if UIDevice().userInterfaceIdiom == UIUserInterfaceIdiom.pad {
      vc.modalPresentationStyle = .popover
      vc.popoverPresentationController!.barButtonItem = navigationItem.rightBarButtonItem
    }
    self.present(vc, animated: true, completion: nil)
    
    // Share just to Facebook
//    let vc = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
//    vc.setInitialText("Look at this great picture!")
//    vc.addImage(detailImageView.image!)
//    vc.addURL(NSURL(string: "http://www.photolib.noaa.gov/nssl"))
//    presentViewController(vc, animated: true, completion: nil)
    
    // Share just to Twitter
//    let vc = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
//    vc.setInitialText("Look at this great picture!")
//    vc.addImage(detailImageView.image!)
//    vc.addURL(NSURL(string: "http://www.photolib.noaa.gov/nssl"))
//    presentViewController(vc, animated: true, completion: nil)
  }
  
}

extension DetailViewController: UIScrollViewDelegate {
  func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    return self.detailImageView
  }
}
