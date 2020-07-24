//
//  DialogsViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 12.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DialogsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    //PRIVATE
    private let disposeBag = DisposeBag()
    
    //PUBLIC
    public var dialogsViewModel: DialogsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        subscribe()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier, id == SegueID.messages.id{
            if let dvc = segue.destination as? MessagesViewController{
                dvc.messageViewModel = MessagesViewModel(indexPath: sender as! IndexPath, chatModel: dialogsViewModel.getChatModel(), myID: dialogsViewModel.getIdUser())
            }
        }
    }
    
    private func subscribe(){
        dialogsViewModel.getChatModel().skip(1).asObservable().subscribe(onNext: { [tableView] (_) in
            tableView?.reloadData()
            }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }

    //MARK:- deinit
    deinit{
        print("DialogsViewController is deinit")
    }
}

//MARK:- TableView
extension DialogsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dialogsViewModel.numberOfRow(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID.dialogs.identifire) as! DialogTableViewCell
        cell.dataDialog = dialogsViewModel.cellForRow(at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dialogsViewModel.selectCell(at: indexPath)
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: SegueID.messages.id, sender: indexPath)
        }
    }
}
