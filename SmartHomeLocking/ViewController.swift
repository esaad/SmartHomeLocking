//
//  ViewController.swift
//  SmartHomeLocking
//
//  Created by Muhammad Afaque on 2015-02-23.
//  Copyright (c) 2015 Esaad Afaque. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameTxt: UITextField!
    
    
    @IBOutlet weak var passwordTxt: UITextField!
    
    
    
    @IBOutlet weak var loginBtn: UIButton!
    
    
    @IBOutlet weak var signupBtn: UIButton!
    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.hidesBackButton = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                // Do any additional setup after loading the view, typically from a nib.
        
//        let theWidth = view.frame.size.width
//        let theHeight = view.frame.size.height
        
       // usernameTxt.frame = CGRectMake(16,200, theWidth-32, 30)
       // passwordTxt.frame = CGRectMake(16,240, theWidth-32, 30)
       // loginBtn.center = CGPointMake(theWidth/2, 330)
      //  signupBtn.center = CGPointMake(theWidth/2, theHeight-30)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        usernameTxt.resignFirstResponder()
        passwordTxt.resignFirstResponder()
      
        return true
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
        
        
    }
    
    @IBOutlet weak var loginchk: UILabel!
    
    
    @IBAction func loginBtn_click(sender: AnyObject) {
        
        PFUser.logInWithUsernameInBackground(usernameTxt.text, password: passwordTxt.text, block: {
            (user:PFUser!, logInError:NSError!) -> Void in
            
            if logInError == nil {
                println("log in")
                self.performSegueWithIdentifier("goToUsersVC", sender: self  )
                self.loginchk.text = "Login Correct"
                
            }
            else {
                println("error login")
                self.loginchk.text = "Login Error"
                
                
                
            }
        })
    }


}

