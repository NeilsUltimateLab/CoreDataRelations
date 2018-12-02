//
//  ViewController.swift
//  CodyRela
//
//  Created by Neil Jain on 12/1/18.
//  Copyright © 2018 Neil Jain. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var referral: Referral?
    
    lazy var fetchRequest: NSFetchRequest<PropertyItem> = {
        let fetchResult = NSFetchRequest<PropertyItem>(entityName: "PropertyItem")
        fetchResult.returnsObjectsAsFaults = false
        fetchResult.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        return fetchResult
    }()
    
    var managedObjectContext: NSManagedObjectContext! {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    lazy var fetchedResultController: NSFetchedResultsController<PropertyItem> = {
        let controller = NSFetchedResultsController<PropertyItem>(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Properties"
        setupTableView()
        setupNavigationItems()
    }
    
    func setupTableView() {
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 56
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "PropertyItemCell", bundle: nil), forCellReuseIdentifier: "PropertyItemCell")
        do {
            try fetchedResultController.performFetch()
        } catch {
            print(error)
        }
    }
    
    func setupNavigationItems() {
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(adAction))
        self.navigationItem.rightBarButtonItem = addItem
    }

    @objc func adAction() {
        self.performSegue(withIdentifier: "AddProperty", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let propertyItem = sender as? PropertyItem {
            if let destination = segue.destination as? PropertyInterestedVC {
                destination.propertyItem = propertyItem
            }
        }
    }

}

extension ViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let propertyItem = self.fetchedResultController.fetchedObjects?[indexPath.row] else {
            return
        }
        if let referral = self.referral {
            let result = propertyItem.add(referral: referral)
            switch result {
            case .value(let success):
                if success {
                    self.navigationController?.popViewController(animated: true)
                }
            case .error(let error):
                print(error)
            }
        } else {
            self.performSegue(withIdentifier: "InterestedIn", sender: propertyItem)
        }
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultController.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PropertyItemCell") as? PropertyItemCell else {
            return UITableViewCell()
        }
        guard let propertyItem = fetchedResultController.fetchedObjects?[indexPath.row] else { return UITableViewCell() }
        cell.configure(with: propertyItem)
        return cell
    }

}
