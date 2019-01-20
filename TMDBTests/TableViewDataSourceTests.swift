//
//  TableViewDataSourceTests.swift
//  TMDBTests
//
//  Created by Bruce McTigue on 12/29/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import XCTest
@testable import TMDB

class TableViewDataSourceTests: XCTestCase {
    typealias CellConfigurator = (String, UITableViewCell) -> Void
    
    var tableViewDatasource: TableViewDataSource<String>!
    var tableView: UITableView!
    
    override func setUp() {
        let data = ["Rodrigo", "Cavalcante", "Testing", "Delegate", "Datasource"]
        tableViewDatasource = TableViewDataSource(models: data, reuseIdentifier: "Cell") { (model: String, cell: UITableViewCell) in
            cell.textLabel?.text = model
        }
        tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = tableViewDatasource
    }

    func testDataSourceRows() {
        let rows = tableViewDatasource.tableView(tableView, numberOfRowsInSection: 0)
        XCTAssert(rows == 5)
    }
    
    func testDataSourceCell() {
        let cell = tableViewDatasource.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssert(cell.textLabel?.text == "Rodrigo")
    }
}
