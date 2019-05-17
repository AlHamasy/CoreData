//
//  StudentDetailViewController.swift
//  CoreDataDemo
//
//  Created by asad on 15/05/19.
//  Copyright © 2019 imastudio. All rights reserved.
//

import UIKit

class StudentDetailViewController: UIViewController {

    @IBOutlet weak var detailNama: UILabel!
    @IBOutlet weak var detailNoHP: UILabel!
    @IBOutlet weak var detailGender: UILabel!
    @IBOutlet weak var detailJenjang: UILabel!
    @IBOutlet weak var detailHobi: UILabel!
    @IBOutlet weak var detailAlamat: UILabel!
    
    var student : Student? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailNama.text = (student?.namaDepan)! + " " + (student?.namaBelakang)!
        detailNoHP.text = student?.noHp
        detailGender.text = student?.gender
        detailJenjang.text = student?.jenjang
        detailHobi.text = student?.hobi
        detailAlamat.text = student?.alamat

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
