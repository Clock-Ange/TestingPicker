//
//  ViewController.swift
//  Challenge4
//
//  Created by Stanislav Makhmoudov on 21.06.2020.
//  Copyright © 2020 GennadyMakhmudov. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var users = [UserPicture]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPicture))
        
        let defaults = UserDefaults.standard
        
        if let savedData = defaults.object(forKey: "users") as? Data{
            let jsonDecoder = JSONDecoder()
            do{
                users = try jsonDecoder.decode([UserPicture].self, from: savedData)
            }catch{
                print("Failed to load users.")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ImageCell else {
            fatalError("Failed loading cell")
        }
        let user = users[indexPath.row]
        let path = getDocumentsDirectory().appendingPathComponent(user.userImageName)
        cell.imageName.image = UIImage(named: path.path)
        cell.imageLabel.text = user.userLabel
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
       
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            let path = getDocumentsDirectory().appendingPathComponent(user.userImageName)
            vc.selectedImageName = path.path
            vc.selectedTitle = user.userLabel
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    @objc func addNewPicture(){
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {return}
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
               if let jpegData = image.jpegData(compressionQuality: 0.8){
                   try? jpegData.write(to: imagePath)
               }
        let user = UserPicture(userImageName: imageName, userLabel: "Unknown")
        users.append(user)
        save()
        picker.dismiss(animated: true, completion: nil)
        tableView.reloadData()
        let ac = UIAlertController(title: "Change the name", message: "Pick a new name for a picture", preferredStyle: .alert)
               ac.addTextField()
               let newAction = UIAlertAction(title: "OK", style: .default, handler: {
                   [weak self, weak ac] _ in
                   guard let newName = ac?.textFields?[0].text else{return}
                   user.userLabel = newName
                   self?.tableView.reloadData()
               })
               ac.addAction(newAction)
               present(ac, animated: true)
    }
    func getDocumentsDirectory() -> URL {
           let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
           return paths[0]
       }
    func save(){
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(users){
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "users")
        }else{
            print("Failed to save users.")
        }
    }


}

