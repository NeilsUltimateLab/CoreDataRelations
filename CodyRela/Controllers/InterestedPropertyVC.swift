//
//  InterestedPropertyVC.swift
//  CodyRela
//
//  Created by Neil Jain on 12/2/18.
//  Copyright © 2018 Neil Jain. All rights reserved.
//

import UIKit
import CoreData

class InterestedPropertyVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    lazy var fetchRequest: NSFetchRequest<PropertyItem> = {
        let request = NSFetchRequest<PropertyItem>(entityName: "PropertyItem")
        request.predicate = NSPredicate(format: "ANY referrals != NIL")
        request.returnsObjectsAsFaults = false
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        return request
    }()
    
    var managedObjectContext: NSManagedObjectContext {
        return (UIApplication.shared.delegate as? AppDelegate)!.persistentContainer.viewContext
    }
    
    lazy var fetchedResultController: NSFetchedResultsController<PropertyItem> = {
        let controller = NSFetchedResultsController<PropertyItem>(fetchRequest: self.fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
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
        self.title = "Interested Properties"
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupTableView() {
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 56
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "PropertyItemCell", bundle: nil), forCellReuseIdentifier: "PropertyItemCell")
    }
    
}

extension InterestedPropertyVC: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.reloadData()
    }
}

extension InterestedPropertyVC: UITableViewDelegate {
    
}

extension InterestedPropertyVC: UITableViewDataSource {
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
        guard let item = fetchedResultController.fetchedObjects?[indexPath.row] else { return UITableViewCell() }
        cell.configure(with: item)
        return cell
    }
}
