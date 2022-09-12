import UIKit

protocol CharactersViewDelegate: AnyObject {
    func onLoadingCharacters()
}

final class CharactersView: UIView, CharactersViewProtocol {

    weak var delegate: CharactersViewDelegate?

    private var dataSource: [String] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()

    private let activityIndicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.color = .red
        spinner.startAnimating()
        spinner.translatesAutoresizingMaskIntoConstraints = false

        return spinner
    }()

    private let loadingBottomView: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.color = .red
        spinner.startAnimating()
        spinner.isHidden = true

        return spinner
    }()

    init() {
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {

        addSubview(tableView)
        addSubview(activityIndicator)

        tableView.tableFooterView = loadingBottomView

        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 30).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 30).isActive = true

        loadingBottomView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 44)
    }

    func updateDataSource(_ characters: [String]) {
        dataSource = characters
        hideLoading()
    }

    private func hideLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = true
            self.loadingBottomView.isHidden = true
        }
    }
}

extension CharactersView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = dataSource[indexPath.row]

        return cell
    }
}

extension CharactersView: UITableViewDelegate {
    //TODO: Implement onDidTap
}

extension CharactersView {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard loadingBottomView.isHidden else { return }

        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.height * 1.5

        if offsetY >= contentHeight - frameHeight {
            loadingBottomView.isHidden = false
            delegate?.onLoadingCharacters()
        }
    }
}
