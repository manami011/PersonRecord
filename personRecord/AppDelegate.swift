//
//  AppDelegate.swift
//  personRecord
//
//  Created by 竹内愛実 on 2021/05/11.
//

import UIKit
import Onboard
import EAIntroView
import RealmSwift

@main


//MARK:AppDelegate class

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        print(documentsPath)
        
        // マイグレーション処理
        migration()
        let realm = try! Realm()
        return true
      }

      // Realmマイグレーション処理
      func migration() {
        // 次のバージョン（現バージョンが０なので、１をセット）
        let nextSchemaVersion = 3

        // マイグレーション設定
        let config = Realm.Configuration(
            schemaVersion: UInt64(nextSchemaVersion),
          migrationBlock: { migration, oldSchemaVersion in
            if (oldSchemaVersion < nextSchemaVersion) {
            }
          })
          Realm.Configuration.defaultConfiguration = config
      
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

