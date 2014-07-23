//
//  ARVPageViewController.swift
//  ARVPageViewController
//
//  Created by Arvindh Sukumar on 14/07/14.
//  Copyright (c) 2014 Arvindh Sukumar. All rights reserved.
//

import UIKit


class ARVPageViewController: UIViewController, UIScrollViewDelegate, ARVPageViewDelegate {

    @IBOutlet var scrollView: UIScrollView?
    var scrollOffset: CGFloat {
        return self.view.frame.width/self.pageControlView.labelScrollView!.frame.width
    
    }

    var viewControllers: [UIViewController] = []
    var pageControlView: ARVPageControlViewController!
    
    convenience init(controllers: [UIViewController]){
        if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone{
            self.init(nibName: "ARVPageViewController", bundle: NSBundle.mainBundle())
        }
        else{
            self.init(nibName: "ARVPageViewController_iPad", bundle: NSBundle.mainBundle())
 
        }
        self.viewControllers = controllers
    }
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization


    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.frame = UIApplication.sharedApplication().delegate.window!.bounds
        self.scrollView!.frame = self.view.bounds
        self.view.setNeedsUpdateConstraints()

        self.navigationController.navigationBar.barStyle = UIBarStyle.Black
        println(self.navigationController.navigationBar.barStyle.toRaw())
        self.pageControlView = ARVPageControlViewController(nibName: "ARVPageControlViewController", bundle: NSBundle.mainBundle())
        self.pageControlView.delegate = self
        self.automaticallyAdjustsScrollViewInsets = false
        self.scrollView!.scrollsToTop = false
        // Do any additional setup after loading the view.
        self.layoutViewControllers()
        self.navigationItem.titleView = self.pageControlView.view
        self.setupNavbarItems()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func layoutViewControllers() {
        
        self.scrollView!.contentSize = CGSizeMake(CGFloat(viewControllers.count) * self.scrollView!.frame.size.width, 0)
        println("pagecontroller view size = \(self.view.frame.size)")
        println("scrollview size = \(self.scrollView!.frame.size)")

        println("scrollview contentsize = \(self.scrollView!.contentSize)")
        var titles: [String] = []
        
        for (index: Int, controller:UIViewController) in enumerate(viewControllers){
            self.addChildViewController(controller)
            var frame = self.scrollView!.frame
            frame.origin.x = CGFloat(index) * frame.size.width
            controller.view.frame = frame
            println("subcontroller frame = \(controller.view.frame)")
            scrollView!.addSubview(controller.view)
            controller.didMoveToParentViewController(self)
            titles.append(controller.title)
            
        }
        
        self.pageControlView.titles = titles
        

    }

    func scrollViewDidScroll(scrollView: UIScrollView!){
        self.pageControlView.contentOffset = scrollView.contentOffset.x/scrollOffset
    
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView!){
        self.pageControlView.setCurrentPage()
        self.setupScrollToTop()
        self.setupNavbarItems()
    }
    
    func setupScrollToTop(){
        for (index: Int, controller: UIViewController) in enumerate(self.viewControllers){
            
            let view = controller.view as? UIScrollView
            if view {
                if (index == self.pageControlView.currentPage) {
                    view!.scrollsToTop = true
                }
                else {
                    view!.scrollsToTop = false
                }
            }
            
        }
    }
    
    func setupNavbarItems(){
        for (index: Int, controller: UIViewController) in enumerate(self.viewControllers){
            
                if (index == self.pageControlView.currentPage) {
                    self.navigationItem.rightBarButtonItem = controller.navigationItem.rightBarButtonItem
                    self.navigationItem.leftBarButtonItem = controller.navigationItem.leftBarButtonItem
                }
            
            
            
        }
    }
    
   
    override func shouldAutorotate() -> Bool {
        
        return true
    }
    
   
    
    
    
    
    
    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        
        println("orientation change")
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
