//
//  DropdownMenu.swift
//  
//
//  Created by Lynn's MacMini on 2019/6/29.
//  Copyright © 2019. All rights reserved.
//

import UIKit

class DropdownMenu: UIView {
    private var tableView: UITableView = UITableView()
    var titles:[String]
    var images:[String]
    var point:CGPoint
    
    init(point:CGPoint, titles:[String]? = nil, images:[String]? = nil) {
        self.titles = titles ?? []
        self.images = images ?? []
        self.point = point

        super.init(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: screenWidth, height: screenHeight)))
        self.backgroundColor = UIColor.white.withAlphaComponent(0)

        //计算长/宽/起点
        var width:CGFloat = 0
        let font = UIFont.systemFont(ofSize: 17)
        for title in self.titles {
            let textWidth = title.widthWith(font: font)
            width = width > textWidth ? width : textWidth
        }
        
        if !self.images.isEmpty {
            width += 100
        } else {
            width += 40
        }
        
        var startPoint = point
        if point.x + width + 10 > screenWidth {
            startPoint.x = screenWidth - width - 10
        }
        startPoint.y = point.y + 10
        
        let maxCount = self.titles.count > self.images.count ? self.titles.count : self.images.count
        let heigth:CGFloat = CGFloat(44 * maxCount)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SystemCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView = UIView()
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        tableView.backgroundColor = UIColor.clear
        tableView.layer.cornerRadius = 5
        tableView.layer.masksToBounds = true
        tableView.frame = CGRect(origin: startPoint, size: CGSize(width: width, height: heigth))
        self.addSubview(tableView)
        
        self.setAnchorPoint(CGPoint(x: point.x/screenWidth, y: point.y/screenHeight))
    }
    
    /// drawRect方法,画tableView上的小三角形
    override func draw(_ rect: CGRect) {

        let y1 = (self.point.y) + 10
        let x1 = (self.point.x) - 8
        let x2 = (self.point.x) + 8

        UIColor(white: 0, alpha: 0.66).set()

        let context = UIGraphicsGetCurrentContext()
        context?.beginPath()
        context?.move(to: CGPoint(x: (self.point.x), y: (self.point.y)))
        context?.addLine(to: CGPoint(x: x1, y: y1))
        context?.addLine(to: CGPoint(x: x2, y: y1))
        context?.closePath()
        context?.fillPath()

        UIGraphicsEndImageContext()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func dissmiss() {
        weak var weakSelf = self
        UIView.animate(withDuration: 0.5, animations: {
            weakSelf?.layer.setAffineTransform(CGAffineTransform.init(scaleX: 0.1, y: 0.1))
            weakSelf?.alpha = 0
        }) { (_) in
            weakSelf?.layer.setAffineTransform(CGAffineTransform.identity)
            weakSelf?.removeFromSuperview()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        dissmiss()
    }
}

extension DropdownMenu: UITableViewDelegate,UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SystemCell") else {
            return UITableViewCell(style: .default, reuseIdentifier: "SystemCell")
        }
        cell.backgroundColor = UIColor(white: 0, alpha: 0.66)
        if indexPath.row < titles.count {
            let title = titles[indexPath.row]
            cell.textLabel?.text = title
            cell.textLabel?.textColor = UIColor.white
        }
        
        if indexPath.row < images.count {
            let image = images[indexPath.row]
            cell.imageView?.image = UIImage(named: image)
            
            let imageSize = CGSize(width: 30, height: 30)
            UIGraphicsBeginImageContextWithOptions(imageSize, false, UIScreen.main.scale)
            let imageRect = CGRect(x: 0.0, y: 0.0, width: imageSize.width, height: imageSize.height)
            cell.imageView?.image?.draw(in: imageRect)
            cell.imageView?.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext();
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dissmiss()
        let cell = self.tableView(tableView, cellForRowAt: indexPath)
        cell.isSelected = false
    }
}

extension UIBarButtonItem {
    func showMenu(titles:[String]? = nil, images:[String]? = nil) {
        let window = UIApplication.shared.windows.first
        if let view = self.value(forKey: "_view") as? UIView {
            let point = CGPoint(x: view.frame.minX+view.frame.width/2, y: view.bounds.maxY)
            let frame = view.convert(point, to: window!)
            let menu = DropdownMenu(point: frame, titles: titles, images: images)
            window?.addSubview(menu)
        }
    }
}

extension UIButton {
    func showMenu(titles:[String]? = nil, images:[String]? = nil) {
        let window = UIApplication.shared.windows.first
        let point = CGPoint(x: self.frame.minX+self.frame.width/2, y: self.bounds.maxY)
        let frame = self.convert(point, to: window!)
        let menu = DropdownMenu(point: frame, titles: titles, images: images)
        window?.addSubview(menu)
    }
}
