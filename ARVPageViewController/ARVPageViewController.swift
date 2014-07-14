//
//  ARVPageViewController.swift
//  ARVPageViewController
//
//  Created by Arvindh Sukumar on 14/07/14.
//  Copyright (c) 2014 Arvindh Sukumar. All rights reserved.
//

import UIKit

class ARVPageViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet var scrollView: UIScrollView
    var viewControllers: UIViewController[]!
    
    convenience init(controllers: UIViewController[]){
        self.init(nibName: "ARVPageViewController", bundle: NSBundle.mainBundle())
        self.viewControllers = controllers
    
    }
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization


    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.layoutViewControllers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func layoutViewControllers() {

        self.scrollView.contentSize = CGSizeMake(Float(viewControllers.count) * self.scrollView.frame.size.width, self.scrollView.frame.size.height)

        for (index: Int, controller:UIViewController) in enumerate(viewControllers!){
            self.addChildViewController(controller)
            var frame = controller.view.frame
            frame.origin.x = Float(index) * frame.size.width
            controller.view.frame = frame
            scrollView.addSubview(controller.view)
            controller.didMoveToParentViewController(self)
            
        }
        

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