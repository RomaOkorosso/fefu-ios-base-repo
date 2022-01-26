//
//  ViewController.swift
//  fefuactivity
//
//  Created by Andrew L on 04.10.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func regButtonAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let regVC = storyboard.instantiateViewController(withIdentifier: "RegView") as! RegController
        
        navigationController?.pushViewController(regVC, animated: true)
    }

    @IBAction func enterButtonAction(_ sender: UIButton) {
        let loginVC = LoginViewConstroller()

        navigationController?.pushViewController(loginVC, animated: true)
    }

    override func viewDidLoad() {


        super.viewDidLoad()
    }


}


