//
//  SearchVC.swift
//  7ayakomApp
//
//  Created by SherifShokry on 10/19/19.
//  Copyright © 2019 Nora Sayed. All rights reserved.
//

import UIKit

class SearchVC : UIViewController {
     
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var indicator : UIActivityIndicatorView!
    @IBOutlet weak var textField : UITextField!
    var isFinishedPaging = false
    var page = 0
    var userList = [User]()
    lazy var pagingSpinner : UIActivityIndicatorView = {
        var spinner = UIActivityIndicatorView(style: .gray)
        spinner.color = UIColor.black
        return  spinner
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       textField.delegate = self
       textField.addTarget(self, action: #selector(handleSearch), for: .editingChanged)
       searchUsersByName()
       pagingSpinner.isHidden = true
       tableView.tableFooterView = pagingSpinner
    }
    
    func  searchUsersByName() {
       
        page = (userList.count / Pagination.per_page) + 1
        
        if page == 1 {
            showIndicator()
         }else{
            pagingSpinner.isHidden = false
            pagingSpinner.startAnimating()
        }
        
        
        
        let dataSource = SearchDataSource()
        dataSource.searchUsersByName(userName: textField.text ?? "",page : page) { (response, result) in
            if self.page == 1 {
                self.hideIndicator()
            }else{
                self.pagingSpinner.isHidden = true
                self.pagingSpinner.stopAnimating()
            }
            switch response {
            case .sucess :
                 let fetchedUsers = result as? [User] ?? []
                if self.page == 1 {
                     self.userList = fetchedUsers
                }else{
                 self.userList.append(contentsOf: fetchedUsers)
               }
                 if fetchedUsers.count < Pagination.per_page {
                    self.isFinishedPaging = true
                  }
                self.tableView.reloadData()
                break
            case .error:
                self.showMessage(result as? String ?? "")
                break
            case .networkError :
                self.showMessage(result as? String ?? "")
                break
                }
            }
    }
    
    
    func showIndicator(){
          indicator.isHidden = false
          indicator.startAnimating()
          
      }
      
      func hideIndicator(){
          indicator.isHidden = true
          indicator.stopAnimating()
      }
    
    
    @objc func handleSearch(textField: UITextField){
      
//        if textField.text?.count ?? 0 > 2 {
//                searchUsersByName()
//        }
        
    }
    
}
extension SearchVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchCell
        cell.setData(user: userList[indexPath.row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        let lastIndex = userList.count - 1

        if indexPath.row == lastIndex && !isFinishedPaging {
               searchUsersByName()
        }
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let vc = ChatVC.instantiateFromStoryBoard(appStoryBoard: .Home)
               vc.reciverUser = userList[indexPath.row]
               self.present(vc, animated: true, completion: nil)
    }
    
}
extension SearchVC : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         textField.resignFirstResponder()
         page = 0
         isFinishedPaging = false
         userList = []
         searchUsersByName()
       return true
    }

}

