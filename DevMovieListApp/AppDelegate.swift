//
//  AppDelegate.swift
//  DevMovieListApp
//
//  Created by Rahul on 10/06/24.
//

import UIKit
import DevNetworking

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private(set) lazy var sceneFactory: SceneFactoryProtocol = {
        let factory = SceneFactory(movieListService: movieService)
        return factory
    }()

    private let defaultNetworkModule: DefaultNetworkModule = {
        let baseURLString = Bundle.main.infoDictionary?["BASE_URL"] as! String
        let baseURL = URL(string: baseURLString)!
        let authorizationAction: AddAuthenticationTokenNetworkModuleAction =
        AddAuthenticationTokenNetworkModuleAction(authenticationTokenProvider: Bundle.main.infoDictionary?["AUTHORIZATION_HEADER"] as! String,
                                                  authenticationTokenHeaderFieldName: "Authorization")
        let requestBuilder = DefaultRequestBuilder(baseURL: baseURL)
        let networkModule = DefaultNetworkModule(requestBuilder: requestBuilder, actions: [authorizationAction])
        return networkModule
    }()
    
    private lazy var movieService = MovieListService(networkModule: defaultNetworkModule)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

