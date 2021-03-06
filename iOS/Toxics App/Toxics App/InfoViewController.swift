//
//  InfoViewController.swift
//  Toxics App
//
//  Created by Legeng Liu on 3/31/17.
//  Copyright © 2017 test. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
    var barcode: String!

    @IBOutlet weak var infoLabel: UILabel!
    
    @IBAction func backButton(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindToFirst", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        infoLabel.text = "Displaying ingrediants for \(barcode)"

        // Do any additional setup after loading the view.
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
