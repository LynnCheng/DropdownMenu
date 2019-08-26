# DropdownMenu
点击按钮显示下拉菜单，支持的按钮类型包括UIButton和UIBarButtonItem。

##效果图：
<center>
<img src="https://github.com/LynnCheng/DropdownMenu/blob/master/2.gif" width="216" height="384"><img src="https://github.com/LynnCheng/DropdownMenu/blob/master/3.gif" width="216" height="384">
</center>

##示例代码：
```
    let barButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showMenu(sender:)))
    ......
    
    @objc func showMenu(sender:UIBarButtonItem) {
        let items: [String] = ["测试1","测试2"]
        let imgSource: [String] = ["add_pic","add_pic"]
        sender.showMenu(titles: items, images: imgSource)
    }
```

