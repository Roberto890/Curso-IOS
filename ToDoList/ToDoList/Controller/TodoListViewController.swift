//
//  TodoListViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController, UISearchBarDelegate {
    
    var itemArray = [Item]()
    var selectedCategory: Category? {
        //did Set quando o valor for setado na variavel vai rodar oq tem dentro do didSet
        didSet {
            loadItems()
        }
    }
    
    // Fazendo o singleton no appdelegate para pegar a instancia do banco de dados assim usamos o context para fazer o crud
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        //pega todos os dados da tabela
//        loadItems()
//        print(itemArray.count)
        
    }
    
    //MARK: Add new items
    
    @IBAction func AddButtonPress(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen when click in add item
            if textField.text != "" {
                
                let newItem = Item(context: self.context)
                newItem.name = textField.text
                newItem.checked = false
                newItem.parentCategory = self.selectedCategory
                
                self.itemArray.append(newItem)
                self.saveItems()
            }
            print(self.itemArray.count)
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: - Model Manipulation Methods
    func saveItems(){
        
        do {
            //CONTEXT.SAVE É O COMMIT DO CORE DATA
            try context.save()
        } catch {
            print("Error Saving items, \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    //if dont have parameter load all files in table
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), and predicate: NSPredicate? = nil){
        
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        if let additionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(type: .and, subpredicates: [categoryPredicate, additionalPredicate])
        } else {
            request.predicate = categoryPredicate
        }
        
        
        //chamamos o context novamente pois ele que faz o crud e passamos o fetch com os dados que queremos
        do{
            itemArray =  try context.fetch(request)
        }catch{
            print("Error loading items, \(error)")
        }
        tableView.reloadData()
        
    }
    
    func deleteItem(with position: Int){
        let item = itemArray[position]
        let deleteItemFetch: NSFetchRequest<Item> = Item.fetchRequest()
        deleteItemFetch.predicate = NSPredicate(format: "name MATCHES %@", item.name!)
        let deleteItemRequest = NSBatchDeleteRequest(fetchRequest: deleteItemFetch as! NSFetchRequest<NSFetchRequestResult>)
        
        do{
            try context.execute(deleteItemRequest)
            itemArray.remove(at: position)
            try context.save()
            
        }catch{
            print("Error loading items, \(error)")
        }
        
    }
    
    //MARK: - TableView Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.name
        
        cell.accessoryType = item.checked ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].checked = !itemArray[indexPath.row].checked
        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Remove") { (_,_,completionHandler) in
            DispatchQueue.main.async {
                self.deleteItem(with: indexPath.row)
                self.tableView.reloadData()
            }
            completionHandler(true)
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    //MARK: - Search Bar Methods
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        
        //Usamos o predicate para fazer comparação
        // o [cd] "c" ignorar maiusculas e "d" as minusculas entao tanto faz ser maiusculo e minusculo nesse caso
        let predicate = NSPredicate(format: "name CONTAINS[cd] %@", searchBar.text!)
        
        //ordenar por nome em ordem alfabetica
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        loadItems(with: request, and: predicate)
       
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
    
}


