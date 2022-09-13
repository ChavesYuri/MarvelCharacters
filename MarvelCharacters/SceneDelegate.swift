import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private let isSwiftUI = true


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        setupRootController(windowScene: windowScene)
    }

    private func setupRootController(windowScene: UIWindowScene) {
        let window = UIWindow(windowScene: windowScene)
        let remote = RemoteLoadCharacters(network: DefaultNetworkService())
        let service = CharactersService(remoteCharacters: remote)

        let proxy = CharactersWeakRefProxy()
        let presenter = CharactersPresenter(display: proxy)
        let interactor = CharacterInteractor(service: service, presenter: presenter)

        if isSwiftUI {
            let swiftUIView = CharactersSwiftUIView()
            let viewController = CharactersHostingViewController(rootView: swiftUIView, interactor: interactor)

            proxy.view = viewController

            let navigationController = UINavigationController(rootViewController: viewController)
            
            window.rootViewController = navigationController
        } else {
            let view = CharactersView()

            let rootViewController = CharactersListViewController(view: view, interactor: interactor)

            proxy.view = rootViewController
            view.delegate = rootViewController

            let navigationController = UINavigationController(rootViewController: rootViewController)

            window.rootViewController = navigationController
        }

        self.window = window
        window.makeKeyAndVisible()
    }

    private func setupSwiftUIView() {

    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}

