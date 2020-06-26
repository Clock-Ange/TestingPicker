//
//  DetailViewController.swift
//  Challenge4
//
//  Created by Stanislav Makhmoudov on 21.06.2020.
//  Copyright © 2020 GennadyMakhmudov. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var detailImage: UIImageView!
    var selectedImageName: String?
    var selectedTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if let selectedImage = selectedImageName{
            detailImage.image = UIImage(named: selectedImage)
        }
        if let newTitle = selectedTitle{
            title = newTitle
        }
    }
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         navigationController?.hidesBarsOnTap = true
     }
     override func viewWillDisappear(_ animated: Bool) {
         super.viewWillDisappear(animated)
         navigationController?.hidesBarsOnTap = false
     }
     
    
    

}
