//
//  ARVPageControlViewController.swift
//  ARVPageViewController
//
//  Created by Arvindh Sukumar on 14/07/14.
//  Copyright (c) 2014 Arvindh Sukumar. All rights reserved.
//

import UIKit
let scrollOffset: Float = 3.2

class ARVPageControlViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet var labelScrollView: UIView
    @IBOutlet var pageControl: UIPageControl
    var currentPage: Int = 0
    
    var titles: String[]? {

        didSet {
        }
    }
    
    var labels: UILabel[] = []
    
    var contentOffset:Float = 0.0 {
        didSet {
            let decrease = (contentOffset < oldValue) ? true : false
            self.contentOffsetDidChange(decrease)
        }
    }
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.prepareView()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func prepareView(){
        self.labels.removeAll(keepCapacity: true)
        if let titleArray = titles {

            
            for (index: Int, title:String) in enumerate(titleArray){
                var frame = CGRectInset(self.labelScrollView.frame, 0, 0)
                frame.origin.x = Float(index) * frame.size.width
                let label: UILabel = UILabel(frame: frame)
                label.text = title
                label.textAlignment = NSTextAlignment.Center
                self.labels.append(label)
                labelScrollView.addSubview(label)
            }
        }
        
    }
    
    
    
    func scrollViewDidScroll(scrollView: UIScrollView!){
//        let pageWidth = self.labelScrollView.frame.size.width
//        let page = floorf((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1.0;
//        self.pageControl.currentPage = Int(page);
        
        
        
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView!){
        
        
    }
    
    func contentOffsetDidChange(decrease:Bool){
        
        for (index: Int, label:UILabel) in enumerate(labels){
            var frame = label.frame
            frame.origin.x = (Float(index) * frame.size.width) - contentOffset
            label.frame = frame
            
            var alpha: Float = 1.0
            var relativeLabelFrame = self.view.convertRect(label.frame, fromView: self.labelScrollView)
            var relativeLabelCenter = CGRectGetMidX(relativeLabelFrame)
            var superViewCenter = CGRectGetMidX(self.labelScrollView.frame)
            if relativeLabelCenter == superViewCenter {
                self.currentPage = index
            }
            alpha = 1.0 - abs(relativeLabelCenter - superViewCenter)/superViewCenter
            label.alpha = max(alpha, 0)
        }
        
    }
    
    func setCurrentPage(){
        self.pageControl.currentPage = self.currentPage
    }
    
    

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
