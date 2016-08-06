//
//  SearchResultsTableViewController.swift
//  DiscountWarehouse
//
//  Created by Diogo Antunes on 8/1/16.
//  Copyright © 2016 Diogo. All rights reserved.
//

import UIKit

class SearchResultsViewController: UIViewController {

	lazy var searchController: UISearchController = {
		$0.searchResultsUpdater = self
		$0.dimsBackgroundDuringPresentation = false

		return $0
	}(UISearchController(searchResultsController: nil))

	@IBOutlet weak var tableView: UITableView! {
		didSet {
			tableView.tableHeaderView = searchController.searchBar
			tableView.registerNib(UINib(nibName: String(ResultsTableViewCell), bundle: nil),
				forCellReuseIdentifier: String(ResultsTableViewCell))
		}
	}

	private var searchResults: [SearchResult]? {
		didSet { filteredResults = searchResults }
	}

	private var filteredResults: [SearchResult]? {
		didSet { tableView.reloadData() }
	}

}

private typealias LifeCycle = SearchResultsViewController
extension LifeCycle: Network {

	override func viewDidLoad() {
		super.viewDidLoad()

		Network.getSearchResults(false, limit: 20, skip: 0) { result in
			switch result {
			case .Success(let search): self.searchResults = search
			case .Failure(let error): print(error)
			}
		}

		definesPresentationContext = true

	}

	func loadMore() {
		Network.getSearchResults(false, limit: 20, skip: 20) { result in
			switch result {
			case .Success(let search): self.searchResults?.appendContentsOf(search)
			case .Failure(let error): print(error)
			}
		}
	}
}

extension SearchResultsViewController: UITableViewDataSource {

	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}

	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		guard let filteredResults = filteredResults else { return 0 }

		return filteredResults.count
	}

	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier(String(ResultsTableViewCell), forIndexPath: indexPath) as! ResultsTableViewCell

		guard let filteredResults = filteredResults else { return cell }
		let row = indexPath.row

		cell.laPlaceHolder?.text = filteredResults[row].face
		cell.laPrice?.text = filteredResults[row].price.toLocalCurrency

		if row == filteredResults.count - 1 {
			loadMore()
		}

		return cell
	}
}

extension SearchResultsViewController: UISearchResultsUpdating {

	func updateSearchResultsForSearchController(searchController: UISearchController) {
		guard let searchText = searchController.searchBar.text else { return }
		filteredResults = searchText.isEmpty ? searchResults : searchResults?.filter({
			$0.tags.map({ $0.value.lowercaseString }).contains(searchText.lowercaseString)
		})
	}

}