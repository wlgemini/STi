//
//  MyViewController.swift
//  STi
//
//  Created by wangluguang@live.com on 05/24/2019.
//  Copyright (c) 2019 wangluguang@live.com. All rights reserved.
//

import STi

class MyViewController: ViewController {
    
    // MARK: UI
    private weak var v1: UIView!
    private weak var v2: UIView!
    private weak var v3: UIView!

    override func setupStyle() {
        // navBar
        self.snb.backgroundEffect = .color(Color.random())
        
        // v1
        self.v1 = self.view.createSubview()
        self.v1.backgroundColor = Color.random()
        
        // v2
        self.v2 = self.view.createSubview()
        self.v2.backgroundColor = Color.random()

        // v3
        self.v3 = self.view.createSubview()
        self.v3.backgroundColor = Color.random()
    }
    
    override func setupLayout() {
        self.v1.dw.make().left(15).top(10, to: self.view.safeAreaLayoutGuide.dw.top).right(-15).height(55)
        self.v2.dw.make().left(0).top(0, to: self.v1.dw.bottom).right(0).bottom(0, to: self.v3.dw.top)
        self.v3.dw.make().left(15).bottom(0, to: self.view.safeAreaLayoutGuide.dw.bottom).right(-15).height(55)
    }
}

