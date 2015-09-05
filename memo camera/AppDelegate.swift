//
//  AppDelegate.swift
//  memo camera
//
//  Created by kanata kana on 2015/09/05.
//  Copyright (c) 2015年 かなたす. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let navController =
        UINavigationController(rootViewController: ViewController())
        
        self.window = UIWindow()
        self.window?.frame = UIScreen.mainScreen().bounds;
        self.window?.backgroundColor = UIColor.whiteColor()
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
}
