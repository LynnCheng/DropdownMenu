# DropdownMenu
下拉菜单

<img src="https://github.com/LynnCheng/DropdownMenu/blob/master/1.gif" width="216" height="384" alt="效果图" align=center>


示例代码：
```
    let barButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showMenu(sender:)))
    ......
    
    @objc func showMenu(sender:UIBarButtonItem) {
        let items: [String] = ["测试1","测试2"]
        let imgSource: [String] = ["add_pic","add_pic"]
        sender.showMenu(titles: items, images: imgSource)
    }
```

