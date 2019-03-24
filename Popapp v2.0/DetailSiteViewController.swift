//
//  DetailSiteViewController.swift
//  Popapp v2.0
//
//  Created by thinking on 3/24/19.
//  Copyright © 2019 thinking. All rights reserved.
//

import UIKit

class DetailSiteViewController: UIViewController {

    @IBOutlet weak var imageSite: UIImageView!
    @IBOutlet weak var titleSite: UILabel!
    @IBOutlet weak var siteDes: UILabel!
    
    var titleS = String()
    var des = String()
    var img = UIImage()
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        imageSite.image = img
        titleSite.text = titleS
        siteDes.text = des
        
        // Do any additional setup after loading the view.
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
