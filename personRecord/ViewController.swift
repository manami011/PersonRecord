//
//  ViewController.swift
//  personRecord
//
//  Created by 竹内愛実 on 2021/05/11.
//

import UIKit

class ViewController: UIViewController {
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func faceCreate(_ sender: Any) {
        
        let faceCreateVC = self.storyboard!.instantiateViewController(identifier: "faceCreate")
        present(faceCreateVC, animated: true)
        
    }
    
    


}

