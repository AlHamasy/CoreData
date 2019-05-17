//
//  AddStudentViewController.swift
//  CoreDataDemo
//
//  Created by asad on 14/05/19.
//  Copyright © 2019 imastudio. All rights reserved.
//

import UIKit

class AddStudentViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var namaDepanTextField: UITextField!
    @IBOutlet weak var namaBelakangTextField: UITextField!
    @IBOutlet weak var noHpTextField: UITextField!
    @IBOutlet weak var genderPicker: UIPickerView!
    @IBOutlet weak var jenjangPicker: UIPickerView!
    @IBOutlet weak var membacaSwitch: UISwitch!
    @IBOutlet weak var menulisSwitch: UISwitch!
    @IBOutlet weak var menggambarSwitch: UISwitch!
    @IBOutlet weak var alamatTextView: UITextView!
    
    var genderData = ["Pria","Wanita"]
    var jenjangData = ["TK", "SD", "SMP", "SMA"]
    
    var student : Student? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        genderPicker.delegate = self
        genderPicker.dataSource = self
        
        jenjangPicker.delegate = self
        jenjangPicker.dataSource = self
        
        if student != nil{
            self.title = "Edit Data"
            terimaData()
        }
    }
    
    func terimaData(){
        
        namaDepanTextField.text = student?.namaDepan
        namaBelakangTextField.text = student?.namaBelakang
        noHpTextField.text = student?.noHp
        
        // ambil index untuk gender
        let indexGender = genderData.index(of: ((student?.gender)!))
        genderPicker.selectRow(indexGender!, inComponent: 0, animated: true)
        
        // ambil index jenjang
        let indexJenjang = jenjangData.index(of: ((student?.jenjang)!))
        jenjangPicker.selectRow(indexJenjang!, inComponent: 0, animated: true)
        
        if (student?.hobi?.contains("Membaca"))!{
            membacaSwitch.isOn = true
        }
        if (student?.hobi?.contains("Menulis"))!{
            menulisSwitch.isOn = true
        }
        if (student?.hobi?.contains("Menggambar"))!{
            menggambarSwitch.isOn = true
        }
        
        alamatTextView.text = student?.alamat
        
    }
    

    @IBAction func onSavedButtonClicked(_ sender: Any) {
        
        let namaDepan = namaDepanTextField.text
        let namaBelakang = namaBelakangTextField.text
        let noHp = noHpTextField.text
        let gender = self.genderData[genderPicker.selectedRow(inComponent: 0)]
        let jenjang = self.jenjangData[jenjangPicker.selectedRow(inComponent: 0)]
        let alamat = alamatTextView.text
        
        var hobbies = [String]()
        
        if membacaSwitch.isOn{
            hobbies.append("Membaca")
        }
        
        if menulisSwitch.isOn{
            hobbies.append("Menulis")
        }
        
        if menggambarSwitch.isOn{
            hobbies.append("Menggambar")
        }
        
        let hobi = hobbies.joined(separator: ",")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        // di cek apabila belum pernah isi core data
        if student == nil {
            student = Student(context: context)
        }
        
        // set data ke core data
        student?.namaDepan = namaDepan
        student?.namaBelakang = namaBelakang
        student?.noHp = noHp
        student?.gender = gender
        student?.jenjang = jenjang
        student?.hobi = hobi
        student?.alamat = alamat
        
        // simpan data ke core data
        do{
            try context.save()
        }
        catch{
            print("Gagal simpan data")
        }

        let alert = UIAlertController(title: "Alert", message: "Berhasil Simpan Data", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (alertSaja) in
            
            alert.dismiss(animated: true, completion: nil)
            self.navigationController?.popToRootViewController(animated: true)
        }
    
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    // menampilkan data di dalam array dalam 1 row
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // untuk menghitung data yang ada di dalam array
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        let tag = pickerView.tag
        
        if tag == 1{
            return genderData.count
        }
        else{
            return jenjangData.count
        }
    }
    
    // untuk menampilkan data yang dipilih
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let tag = pickerView.tag
        
        if tag == 1{
            return genderData[row]
        }
        else{
            return jenjangData[row]
        }
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
