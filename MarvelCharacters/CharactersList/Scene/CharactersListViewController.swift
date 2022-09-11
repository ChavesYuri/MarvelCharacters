import Foundation
import UIKit

protocol CharactersListDisplay: AnyObject {
    func displayCharacters(viewModel: CharactersScenarios.FetchCharacters.ViewModel)
}

final class CharactersListViewController: UIViewController {

    private let interactor: CharactersInteractorProtocol

    private var dataSource: [String] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    private let activityIndicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.color = .red
        spinner.translatesAutoresizingMaskIntoConstraints = false

        return spinner
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    init(interactor: CharactersInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        showLoading(true)
        interactor.loadCharacters(request: .init())
    }

    private func setupUI() {
        title = "Marvel Characters"

        view.addSubview(tableView)
        view.addSubview(activityIndicator)

        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 30).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }

    private func showLoading(_ isLoading: Bool) {
        DispatchQueue.main.async {
            isLoading ? self.activityIndicator.startAnimating() : self.activityIndicator.stopAnimating()
        }
    }
}

extension CharactersListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = dataSource[indexPath.row]

        return cell
    }
}

extension CharactersListViewController: UITableViewDelegate {
    //TODO: Implement onDidTap
}

extension CharactersListViewController: CharactersListDisplay {
    func displayCharacters(viewModel: CharactersScenarios.FetchCharacters.ViewModel) {
        showLoading(false)
        switch viewModel {
        case .content(viewModel: let characters):
            dataSource = characters.map( { $0.name } )
        case .error:
            break
        case .hidePagingLoading:
            break
        }
    }
}