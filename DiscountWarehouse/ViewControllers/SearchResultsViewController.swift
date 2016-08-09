//
//  SearchResultsTableViewController.swift
//  DiscountWarehouse
//
//  Created by Diogo Antunes on 8/1/16.
//  Copyright © 2016 Diogo. All rights reserved.
//

import UIKit

class SearchResultsViewController: UIViewController, ShowAlert {

	lazy var searchController: UISearchController = {
		$0.searchResultsUpdater = self
		$0.dimsBackgroundDuringPresentation = false
		$0.searchBar.barTintColor = UIColor(color: .Green)

		return $0
	}(UISearchController(searchResultsController: nil))

	@IBOutlet weak var tableView: UITableView! {
		didSet {
			tableView.tableHeaderView = searchController.searchBar
			tableView.register(ResultsTableViewCell)
		}
	}

	private var searchResults: [SearchResult]? {
		didSet { filteredResults = searchResults }
	}

	private var filteredResults: [SearchResult]? {
		didSet { tableView.reloadData() }
	}

	private lazy var viewModel: SearchResultsViewModel = {
		return SearchResultsViewModel()
	}()
}

private typealias LifeCycle = SearchResultsViewController
extension LifeCycle {

	override func viewDidLoad() {
		super.viewDidLoad()

		// Sets this view controller as presenting view controller for the search interface
		definesPresentationContext = true

		// Get initial results
		viewModel.getSearchResults(20, skip: 0) { results in
			if let results = results { self.searchResults = results }
			else { self.showError() }
		}
	}

	private func showError() {
		showAlertWithTitle("Error", message: "There was an error retrieving your results.")
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
		let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as ResultsTableViewCell

		guard let filteredResults = filteredResults, searchResults = searchResults else { return cell }
		let row = indexPath.row
		let result = filteredResults[row]

		// Results Stock
		if result.stock == 0 { cell.noStockMode() }
		else { cell.laStock?.text = String(result.stock) }

		// Price
		cell.laPrice?.text = result.price.toLocalCurrency

		// ASCII Face
		cell.laPlaceHolder?.text = result.face

		// Tags
		cell.laTags.text = result.tags.removeDuplicates().joinWithSeparator(", ")

		// Pagination
		if row == searchResults.count - 1 { loadMoreResults() }

		return cell
	}

	private func loadMoreResults() {
		viewModel.getSearchResults(20, skip: 20) { results in
			if let results = results { self.searchResults?.appendContentsOf(results) }
			else { self.showError() }
		}
	}
}

extension SearchResultsViewController: UISearchResultsUpdating {

	func updateSearchResultsForSearchController(searchController: UISearchController) {
		guard let searchText = searchController.searchBar.text else { return }
		filteredResults = searchText.isEmpty ? searchResults : searchResults?.filter({
			$0.tags.map({ $0.lowercaseString }).contains(searchText.lowercaseString)
		})
	}

}