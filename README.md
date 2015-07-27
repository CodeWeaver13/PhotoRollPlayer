# PhotoRollPlayer
## 一个简单的图片轮播器
### 使用方法
    lazy var rollPlayerView: PhotoRollPlayerView = {
        let view: PhotoRollPlayerView = PhotoRollPlayerView(frame: CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height))
        let array = NSMutableArray()
        for i in 1..<4 {
            let button: PhotoButton = PhotoButton(frame: CGRectMake(0, 0, kScreenW(), self.bounds.size.height))
            button.contentImageView = UIImageView(image: UIImage(named: "\(i).png"))
            button.addTarget(self, action: "click:", forControlEvents: UIControlEvents.TouchUpInside)
            array.addObject(button)
        }
        view.viewArray = array as [AnyObject]
        return view
        }()
    
    func click(sender: PhotoButton) {
        print("click--------------\(sender)")
    }
