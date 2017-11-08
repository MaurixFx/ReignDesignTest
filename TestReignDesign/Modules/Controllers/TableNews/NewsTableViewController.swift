//
//  NewsTableViewController.swift
//  TestReignDesign
//
//  Created by Mauricio Figueroa olivares on 08-11-17.
//  Copyright © 2017 Maurix. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {

    var allNews = [News]()
    let manager = ApiManager()
    var refresh: UIRefreshControl!
    let news = News()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configRefreshControl()
        loadNews()
    }
    
    // Función donde configuramos el refresh
    func configRefreshControl() {
        self.refresh = UIRefreshControl()
        self.tableView.addSubview(self.refresh)
        self.refresh.attributedTitle = NSAttributedString(string: "Pull to Refresh")
        self.refresh.tintColor = UIColor.red
        self.refresh.addTarget(self, action: #selector(loadNews), for: .valueChanged)
    }
    
    // Función donde cargamos las Noticias
    @objc func loadNews() {
        manager.loadApiNews { (newsList, message, error) in
            if !error {
                self.allNews = newsList!
                self.tableView.reloadData()
                self.refresh.endRefreshing()
            }
        }
    }

    // MARK: - Table view data source
    //Función donde retornamos el numero de secciones
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    //Función donde retornamos el numero de filas
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allNews.count
    }

    //Función donde configuramos la celda
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NEWS_CELL, for: indexPath) as! NewsTableViewCell
        let story = self.allNews[indexPath.row]
        cell.configCell(news: story)
        return cell
    }
    
    //Funcion para cuando se selecciona la celda
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: SHOW_WEB, sender: self)
    }
    
    // Función donde retornamos el tamaño de la celda
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    // Función donde indicamos que si queremos acciones en las filas
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Función donde realizamos la acción de Swipe para eliminar
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            news.deleteStory(idStory: self.allNews[indexPath.row].storyId)
            self.allNews.remove(at: indexPath.item)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SHOW_WEB {
            if let indexPath = tableView.indexPathForSelectedRow{
                let selectedRow = indexPath.row
                let destinationNavigationController = segue.destination as! UINavigationController
                let webContent = destinationNavigationController.topViewController as! WebContentViewController
                // Enviamos el link de la celda seleccionada hacia la webView
                webContent.storyLink = self.allNews[selectedRow].storyLink
            }
        }
    }
}
