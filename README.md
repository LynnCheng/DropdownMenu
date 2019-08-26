# DropdownMenu
下拉菜单

<video id="video" controls="" preload="none">
<source id="mp4" src="https://github.com/LynnCheng/DropdownMenu/blob/master/1.mov" type="video/mp4">
</video>
![avatar](1.gif)


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

