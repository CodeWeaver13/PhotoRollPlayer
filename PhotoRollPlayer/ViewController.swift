//
//  ViewController.swift
//  
//
//  Created by 汪诗雨 on 15/7/28.
//
//

import UIKit

class ViewController: UIViewController {
    lazy var rollPlayerView: PhotoRollPlayerView = {
        let view: PhotoRollPlayerView = PhotoRollPlayerView(frame: CGRectMake(0, 0, self.view.bounds.size.width, 200))
        let array = NSMutableArray()
        for i in 1..<5 {
            let button: PhotoButton = PhotoButton(frame: CGRectMake(0, 0, self.view.bounds.size.width, 200))
            button.contentImageView = UIImageView(image: UIImage(named: "\(i).jpg"))
            button.addTarget(self, action: "click:", forControlEvents: UIControlEvents.TouchUpInside)
            array.addObject(button)
        }
        view.viewArray = array as [AnyObject]
        return view
        }()
    
    func click(sender: PhotoButton) {
        print("click--------------\(sender)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.rollPlayerView)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
