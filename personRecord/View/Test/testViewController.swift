//
//  testViewController.swift
//  personRecord
//
//  Created by 竹内愛実 on 2021/05/25.
//

import UIKit

class testViewController: UIViewController {
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var button: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addBtn(_ sender: Any) {
        
        let btn = UILabel()
        let label = UILabel()
        btn.text = "ボタン作ったよ！"
        label.text = "2個目！！！"
        
        stackView.addArrangedSubview(btn)
        stackView.addArrangedSubview(label)
        
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
