//
//  ARVPageControlViewController.swift
//  ARVPageViewController
//
//  Created by Arvindh Sukumar on 14/07/14.
//  Copyright (c) 2014 Arvindh Sukumar. All rights reserved.
//

import UIKit
@objc protocol ARVPageViewDelegate {
    
    
}
class ARVPageControlViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet var labelScrollView: UIView?
    @IBOutlet var pageControl: UIPageControl?
    weak var delegate: ARVPageViewDelegate?
    
    var currentPage: Int = 0
    
    var titles: [String]? {

        didSet {
        }
    }
    
    var labels: [UILabel] = []
    
    var contentOffset:CGFloat = 0.0 {
        didSet {
            self.contentOffsetDidChange()
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
        self.contentOffsetDidChange()


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func prepareView(){
        self.labels.removeAll(keepCapacity: true)
        if let titleArray = titles {

            
            for (index: Int, title:String) in enumerate(titleArray){
                var frame = CGRectInset(self.labelScrollView!.frame, 0, 0)
                frame.origin.x = CGFloat(index) * frame.size.width
                let label: UILabel = UILabel(frame: frame)
                label.text = title
                label.font = UIFont.systemFontOfSize(15)
                let parent = self.delegate as ARVPageViewController
                println(parent.navigationController.navigationBar.barStyle.toRaw())
                label.textColor = (parent.navigationController.navigationBar.barStyle == UIBarStyle.Black) ? UIColor.darkTextColor() : UIColor.whiteColor()
                label.textAlignment = NSTextAlignment.Center
                self.labels.append(label)
                labelScrollView!.addSubview(label)
            }
            self.pageControl!.numberOfPages = titleArray.count
        }
        
    }
    
    
    
       
    func contentOffsetDidChange(){
        
        for (index: Int, label:UILabel) in enumerate(labels){
            var frame = label.frame
            frame.origin.x = (CGFloat(index) * frame.size.width) - contentOffset
            label.frame = frame
            
            // Convert the label's frame in terms of that of the superView
            var relativeLabelFrame = self.view.convertRect(label.frame, fromView: self.labelScrollView)
            var relativeLabelCenter = CGRectGetMidX(relativeLabelFrame)
            
            var superViewCenter = CGRectGetMidX(self.labelScrollView!.frame)
            
            // Compare centers, and see how far the label's center is from that of the superview center.
            
            // alpha is inversely proportional to distance. Higher the distance, lesser the alpha
            var alpha = 1.0 - abs(relativeLabelCenter - superViewCenter)/superViewCenter
            label.alpha = max(alpha, 0)
            
            if relativeLabelCenter == superViewCenter {
                self.currentPage = index
            }
        }
        
    }
    
    func setCurrentPage(){
        self.pageControl!.currentPage = self.currentPage
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
