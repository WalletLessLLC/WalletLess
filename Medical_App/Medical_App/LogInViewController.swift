//
//  LogInViewController.swift
//  Medical_App
//
//  Created by Gregory Johnson on 2/20/17.
//  Copyright © 2017 Gregory Johnson. All rights reserved.
//

import UIKit
import Alamofire

class LogInViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var i_email: UITextField!
    @IBOutlet weak var i_password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        i_email.delegate = self
        i_password.delegate = self
        
        i_password.isSecureTextEntry = true
        
        i_email.layer.borderWidth = 1
        i_email.layer.borderColor = UIColor.white.cgColor
        i_password.layer.borderWidth = 1
        i_password.layer.borderColor = UIColor.white.cgColor
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func signIn(_ sender: Any) {
        
        Alamofire.request("http://155.246.138.185:3000/users").responseString {
            response in
            
            switch (response.result) {
            case .success:
                print(response)
                let nextViewController = self.storyboard!.instantiateViewController(withIdentifier: "MenuScene")
                self.present(nextViewController, animated:true, completion:nil)
                break
            case .failure(let error):
                if error._code == NSURLErrorTimedOut {
                    //timeout
                    print("There was a timout")
                }
                break
            }
            print(response)
            
            
        }
        
        
    }

    @IBAction func register(_ sender: Any) {
        let postInfo = ["user_id":i_email.text, "password":i_password.text]
        Alamofire.request("http://155.246.138.85:3000/users", method: .post, parameters: postInfo, encoding: JSONEncoding.default).responseJSON {
            response in
            gl_data.myUsername = self.i_email.text!
            debugPrint(response)
            let nextViewController = self.storyboard!.instantiateViewController(withIdentifier: "MenuScene")
            self.present(nextViewController, animated:true, completion:nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
