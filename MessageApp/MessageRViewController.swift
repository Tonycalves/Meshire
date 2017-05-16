//
//  MessageRViewController.swift
//  MessageApp
//
//  Created by Anthony Goncalves on 15/02/2017.
//  Copyright © 2017 Anthony Goncalves. All rights reserved.
//

import UIKit

class MessageRViewController: UIViewController {

    @IBOutlet weak var btnMenuButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        btnMenuButton.target = SWRevealViewController()
        btnMenuButton.action = #selector(SWRevealViewController.revealToggle(_:))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
