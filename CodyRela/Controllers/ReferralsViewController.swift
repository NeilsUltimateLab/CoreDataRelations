//
//  ReferralsViewController.swift
//  CodyRela
//
//  Created by Neil Jain on 12/1/18.
//  Copyright © 2018 Neil Jain. All rights reserved.
//

import UIKit
import CoreData

class ReferralsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    lazy var fetchRequest: NSFetchRequest<Referral> = {
        let fetchResult = NSFetchRequest<Referral>(entityName: "Referral")
        fetchResult.returnsObjectsAsFaults = false
        fetchResult.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        return fetchResult
    }()
    
    var managedObjectContext: NSManagedObjectContext! {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    lazy var fetchedResultController: NSFetchedResultsController<Referral> = {
        let controller = NSFetchedResultsController<Referral>(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Referrals"
        setupTableView()
        setupNavigationItems()
    }
    
    func setupTableView() {
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 56
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "ReferralCell", bundle: nil), forCellReuseIdentifier: "ReferralCell")
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
        self.performSegue(withIdentifier: "AddReferral", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let referral = sender as? Referral else { return }
        guard let destination = segue.destination as? ViewController else { return }
        destination.referral = referral
    }
    
}

extension ReferralsViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.reloadData()
    }
}

extension ReferralsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let referral = self.fetchedResultController.fetchedObjects?[indexPath.row] else { return }
        self.performSegue(withIdentifier: "AddProperty", sender: referral)
    }
}

extension ReferralsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultController.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReferralCell", for: indexPath) as? ReferralCell else { return UITableViewCell() }
        guard let referral = self.fetchedResultController.fetchedObjects?[indexPath.row] else {
            return UITableViewCell()
        }
        cell.configure(with: referral)
        return cell
    }
    
}
