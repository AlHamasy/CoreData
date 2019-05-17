//
//  StudentTableViewController.swift
//  CoreDataDemo
//
//  Created by asad on 14/05/19.
//  Copyright © 2019 imastudio. All rights reserved.
//

import UIKit
import CoreData

class StudentTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var students : [Student] = [Student]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        reloadData()
    }
   
    
    func reloadData(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
        
        do {
            let result = try context.fetch(fetchRequest)
            students = result as! [Student]
            tableView.reloadData()
        } catch  {
            print("error")
        }
    }
    
    // action segue ke masing masing identifier
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Edit"{
            if let destinationVC = segue.destination as? AddStudentViewController{
                var indexPath = sender as! IndexPath
                let student = self.students[indexPath.row]
                
                // panggil variable dari kelas tujuan / AddStudentViewController
                destinationVC.student = student
            }
        }
    
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if identifier == "Edit"{
            return false
        }
        return true
        
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


extension StudentTableViewController : UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let student = self.students[indexPath.row]
        
        var cell : StudentTableViewCell? = nil
        
        if student.gender == "Pria"{
            cell = tableView.dequeueReusableCell(withIdentifier: "StudentTableViewCell", for: indexPath) as? StudentTableViewCell

        }
        else{
            cell = tableView.dequeueReusableCell(withIdentifier: "StudentTableViewCell2", for: indexPath) as! StudentTableViewCell2
        }
        
        cell!.namaLabel.text = student.namaDepan! + " " + student.namaBelakang!
        cell!.jenjangLabel.text = student.jenjang
        cell!.genderLabel.text = student.gender
        cell!.noHpLabel.text = student.noHp
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            
            let student = self.students[indexPath.row]
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            context.delete(student)
            
            do {
                try context.save()
            } catch  {
                print("gagal hapus")
            }
            reloadData()
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (ac : UIContextualAction, view: UIView, success : (Bool) -> Void) in
            print("edit data")
            
            self.performSegue(withIdentifier: "Edit", sender: indexPath)
        }
        
        editAction.image = UIImage(named: "edit2")
        editAction.backgroundColor = UIColor.blue
        
        return UISwipeActionsConfiguration(actions: [editAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destination = storyboard.instantiateViewController(withIdentifier: "ViewDetail") as! StudentDetailViewController

        let student = self.students[indexPath.row]
        destination.student = student
        
        show(destination, sender: indexPath)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let firstname = searchText
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
        
        if searchText != "" {
            fetchRequest.predicate = NSPredicate(format: "namaDepan == %@", firstname)
        }
        
        do {
            let result = try context.fetch(fetchRequest)
            students = result as! [Student]
            tableView.reloadData()
        } catch  {
            print("error")
        }
    }
    
}
