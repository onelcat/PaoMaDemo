//
//  ViewController.swift
//  MyDemo
//
//  Created by haoshuai on 2020/11/4.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 可以实现滚动 但是不行
//        let timer = Timer(timeInterval: 1.0, repeats: true) { (t) in
//
//            UIView.animate(withDuration: 1) {
//                let po = self.tableView.contentOffset
//                let y = po.y + 10
//
//                self.tableView.contentOffset = CGPoint(x: 0, y: y)
//            }
//
//        }
//        timer.fire()
//        RunLoop.main.add(timer, forMode: .common)
        // Do any additional setup after loading the view.
    }


}

class MYCell: UITableViewCell {
    @IBOutlet weak var aImageView:UIImageView!
    @IBOutlet weak var tLabel: UILabel!
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userInfoCell", for: indexPath) as! MYCell
//        cell.textLabel?.text = "\(indexPath)"
        cell.tLabel.text = "\(indexPath)"
        return cell
    }
    
    
    
}


extension  ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = HViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

class UserInfoView: UIView {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "张筱雨  拼夕夕砍价成功"
        label.font = UIFont(name: "PingFangSC-Regular", size: 13)
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = #colorLiteral(red: 0.09019607843, green: 0.09411764706, blue: 0.137254902, alpha: 1)
        self.layer.cornerRadius = 15
        self.addSubview(imageView)
        imageView.frame = CGRect(x: 4, y: 3, width: 24, height: 24)
        self.addSubview(label)
        label.frame = CGRect(x: 32, y: 6, width: frame.width - 32, height: 18.5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func Height(_ text: String) -> CGSize {
        return CGSize.zero
    }
    
}

class HViewController: UIViewController {
    
    
//    lazy var itemView: UIView = {
//        let view = UIView()
//        view.backgroundColor = UIColor.yellow
//        return view
//    }()
//
    
    @IBOutlet weak var bgView: UIView!
    
    var cellViews = [UserInfoView]()
    
    var animtaions = [CAAnimationGroup]()

    func initItemView() {
        
        for i in 0...4 {
            
            let w = UIScreen.main.bounds.width - 40
            let itemView = UserInfoView(frame: CGRect(x: 20, y: 438, width: w, height: 30))
            cellViews.append(itemView)
            
            let anim0 = CABasicAnimation(keyPath: "opacity")
            anim0.toValue = 0.0
            anim0.fromValue = 1.0
            anim0.duration = 3
            
            let path = CGMutablePath()
            path.move(to: CGPoint.init(x: UIScreen.main.bounds.width / 2.0, y: 438))
            path.addLine(to: CGPoint.init(x: UIScreen.main.bounds.width / 2.0, y: 150))
            
            let anim1 = CAKeyframeAnimation(keyPath:"position")
            anim1.duration = 3
            
            
            
            anim1.path = path
            anim1.calculationMode = CAAnimationCalculationMode.paced
            anim1.fillMode = CAMediaTimingFillMode.forwards
            
            
            let anim2 = CAAnimationGroup()
            anim2.animations = [anim0,anim1]
            anim2.duration = 3
            anim2.fillMode = .forwards
//            anim2.isRemovedOnCompletion = false
            anim2.delegate = self
            
            self.animtaions.append(anim2)
        }
        

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        initItemView()
        print(self.animtaions)
//        let y =  UIScreen.main.bounds.height - 60
////        itemView.frame = CGRect(x: 0, y: y, width: UIScreen.main.bounds.width, height: 50)
//
//
////        let centerX = view.bounds.size.width/2
////        let boundingRect = CGRect(x:centerX-75, y:50, width:150, height:150)
//
//        let an = CABasicAnimation(keyPath: "opacity")
//        an.toValue = 0.0
//        an.fromValue = 1.0
//        an.duration = 3
//        an.delegate = self
//
//        let orbit = CAKeyframeAnimation(keyPath:"position")
//        orbit.duration = 3
//        let path = CGMutablePath()
//        path.move(to: CGPoint.init(x: UIScreen.main.bounds.width / 2.0, y: y))
//        path.addLine(to: CGPoint.init(x: UIScreen.main.bounds.width / 2.0, y: 100))
//        orbit.path = path
//        orbit.calculationMode = CAAnimationCalculationMode.paced
//        orbit.fillMode = CAMediaTimingFillMode.forwards
////        orbit.isRemovedOnCompletion = false
////        orbit.repeatCount = HUGE
//
//
//        orbit.delegate = self
//
//        let animationgroup = CAAnimationGroup()
//        animationgroup.animations = [orbit,an]
//        animationgroup.duration = 3
////        animationgroup.repeatCount = HUGE
//        animationgroup.fillMode = .forwards
//        animationgroup.isRemovedOnCompletion = false
//        animationgroup.delegate = self
//        itemView.layer.add(animationgroup,forKey:"Move")
//        self.view.addSubview(itemView)
        
        
    }
    
    private var tIndex = 0
    private var timer: Timer?
    @IBAction func buttonAction() {
        // 线程 延迟调用
        
        timer = Timer(timeInterval: 1.0, target: self, selector: #selector(addView), userInfo: nil, repeats: true)
        timer?.fire()
        RunLoop.main.add(timer!, forMode: .common)
    }
    
    @objc
    private func addView() {
        debugPrint("调用",tIndex)
        if tIndex == cellViews.count - 1 {
            timer?.invalidate()
            timer = nil
            tIndex = 0
        }
        
        let v = cellViews[tIndex]
        let a = animtaions[tIndex]
        self.view.addSubview(v)
//        self.view.pre
//        self.view.insertSubview(v, at: 0)
        v.layer.add(a, forKey: "Move\(tIndex)")
        tIndex = tIndex + 1
        
    }
    
}


extension HViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        guard flag else { return }
//        print("停止动画",anim)
        let ag = anim as! CAAnimationGroup
//        debugPrint(anim,ag,ag.animations?.first)
        print("----------------------",Date().timeIntervalSince1970)
        
        for (i,item) in animtaions.enumerated() {
            if item.animations?.first == ag.animations?.first {
//                print("重新更新动画")
                let v = cellViews[i]
                v.layer.removeAllAnimations()
                let a = animtaions[i]
                a.duration = 3
                v.layer.add(a, forKey: "Move_\(i)")
            }
        }
    }
}
