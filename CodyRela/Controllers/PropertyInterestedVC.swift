//
//  PropertyInterestedVC.swift
//  CodyRela
//
//  Created by Neil Jain on 12/1/18.
//  Copyright © 2018 Neil Jain. All rights reserved.
//

import UIKit
import CoreData

class PropertyInterestedVC: UIViewController {

    var propertyItem: PropertyItem?
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var fetchRequest: NSFetchRequest<Referral> = {
        guard let propertyItemId = self.propertyItem?.id else {
            fatalError()
        }
        let fetchRequest = NSFetchRequest<Referral>(entityName: "Referral")
        fetchRequest.predicate = NSPredicate(format: "ANY interestedIn.id == %@", propertyItem?.id?.uuidString ?? "")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true, selector: nil)]
        return fetchRequest
    }()
    
    var managedObjectContext: NSManagedObjectContext {
        return (UIApplication.shared.delegate as? AppDelegate)!.persistentContainer.viewContext
    }
    
    lazy var fetchedResultController: NSFetchedResultsController<Referral> = {
        let controller = NSFetchedResultsController<Referral>(fetchRequest: self.fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        do {
            try controller.performFetch()
        } catch {
            print(error)
        }
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
        setupTableView()
    }
    
    func setupNavigationItem() {
        self.title = propertyItem?.name
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    func setupTableView() {
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 54
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellId")
    }

}

extension PropertyInterestedVC: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.reloadData()
    }
}

extension PropertyInterestedVC: UITableViewDelegate {
    
}

extension PropertyInterestedVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultController.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath) as? UITableViewCell else {
            return UITableViewCell()
        }
        cell.textLabel?.text = fetchedResultController.fetchedObjects?[indexPath.row].name
        return cell
    }
}
