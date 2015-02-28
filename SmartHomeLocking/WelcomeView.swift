//
//  WelcomeView.swift
//  SmartHomeLocking
//
//  Created by Muhammad Afaque on 2015-02-27.
//  Copyright (c) 2015 Esaad Afaque. All rights reserved.
//

import UIKit

class WelcomeView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
       let yourImage = UIImage(named: "planet.png")
       let imageview = UIImageView(image: yourImage)
        self.view.addSubview(imageview)

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
