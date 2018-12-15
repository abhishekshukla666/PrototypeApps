//
//  EntryViewController.swift
//  SplitViewDemo
//
//  Created by Abhishek Shukla on 19/11/18.
//  Copyright © 2018 Abhishek Shukla. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController {

    @IBOutlet weak var entryButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
    }
    
    @IBAction func entryButtonTapped(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let homeSplitVC = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController else {
            return
            
        }
        homeSplitVC.preferredDisplayMode = .allVisible
        
        self.navigationController?.pushViewController(homeSplitVC, animated: true)
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
