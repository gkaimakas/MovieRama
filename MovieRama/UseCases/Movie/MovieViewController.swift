//
//  MovieViewController.swift
//  MovieRama
//
//  Created by George Kaimakas on 09/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import Dwifft
import MovieRamaCommon
import MovieRamaViewModels
import MoviewRamaViews
import ReactiveCocoa
import ReactiveSwift
import Result
import UIKit

class MovieViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var diffCalculator: TableViewDiffCalculator<String, Row>!
    weak var viewModel: MovieViewModel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        diffCalculator = TableViewDiffCalculator(tableView: tableView)
        
        tableView.register(ContentTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        
        diffCalculator.sectionedValues = SectionedValues<String, Row>([
            ("", [
                .title(viewModel.title),
                .padding(8),
                .label("Description"),
                .padding(4),
                .content(viewModel.overview)
                ])
            ])
    }
    
}

extension MovieViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return diffCalculator.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diffCalculator.numberOfObjects(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch diffCalculator.value(atIndexPath: indexPath) {
        case .title(let property):
            let cell = tableView.dequeueReusableCell(ContentTableViewCell.self, indexPath: indexPath)
            cell.configuration = ContentTableViewCell.Configuration(contentType: .title,
                                                                    content: property.producer)
            return cell
            
        case .label(let property):
            let cell = tableView.dequeueReusableCell(ContentTableViewCell.self, indexPath: indexPath)
            cell.configuration = ContentTableViewCell.Configuration(contentType: .label,
                                                                    content: property)
            return cell
            
        case .content(let property):
            let cell = tableView.dequeueReusableCell(ContentTableViewCell.self, indexPath: indexPath)
            cell.configuration = ContentTableViewCell.Configuration(contentType: .content,
                                                                    content: property.producer)
            return cell
            
        case .padding:
            let cell = UITableViewCell()
            cell.selectionStyle = .none
            return cell
        }
    }
}

extension MovieViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch diffCalculator.value(atIndexPath: indexPath) {
        case .title:
            return UITableView.automaticDimension
            
        case .label:
            return UITableView.automaticDimension
            
        case .content:
            return UITableView.automaticDimension
            
        case .padding(let height):
            return height
        }
    }
}
