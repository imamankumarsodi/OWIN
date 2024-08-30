//
//  AppDelegate.swift
//  JustBite
//
//  Created by Aman on 04/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import UIKit
import KYDrawerController
import GoogleMaps
import Firebase
import IQKeyboardManagerSwift
import UserNotifications
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit
import GooglePlaces
import RealmSwift
import UserNotifications
import Braintree

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate,GIDSignInDelegate,MessagingDelegate {
    
    
   

    var window: UIWindow?
    var drawerController:KYDrawerController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        BTAppSwitch.setReturnURLScheme("com.Mobulous.Owin.payments")
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        sleep(4)
        
        let simulaterToken = "Simulaterwalatokenbb55d44bfc4492bd33aac79afeaee474e92c12138e18b021e2326"
        UserDefaults.standard.set(simulaterToken as String, forKey: "devicetoken")
        
        FirebaseApp.configure()
        registerForRemoteNotification()
        
        // Initialize Google sign-in
        GIDSignIn.sharedInstance().clientID = "700871046888-h76tohojkq7uhsbrb6nmr73dc4ne66b0.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
        
        //TODO : Implenting IQKeyboard
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true
       
        GMSServices.provideAPIKey("AIzaSyDD7W-UTi8AeuCleBLS6fOr1Sqc2Vv2IJo")
       // GMSPlacesClient.provideAPIKey("AIzaSyBkaShjHeCswBX6K_3G8v6zLxxDgHZigGQ")
        GMSPlacesClient.provideAPIKey("AIzaSyDLRsO_oOSnSc0pzp6MzZ0Hg7cByd7k8qo")
        
        
        
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)

        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        Messaging.messaging().delegate = self
        
       checkAutoLogin()
        
        return true
    }
    
//    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
//        if url.scheme?.localizedCaseInsensitiveCompare("com.Mobulous.Owin.payments") == .orderedSame {
//            return BTAppSwitch.handleOpen(url, options: options)
//        }
//        return false
//    }
    
    // If you support iOS 8, add the following method.
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        if url.scheme?.localizedCaseInsensitiveCompare("com.Mobulous.Owin.payments") == .orderedSame {
            return BTAppSwitch.handleOpen(url, sourceApplication: sourceApplication)
        }
        return false
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if url.scheme?.localizedCaseInsensitiveCompare("com.Mobulous.Owin.payments") == .orderedSame {
            return BTAppSwitch.handleOpen(url, options: options)
        }
        
        if ApplicationDelegate.shared.application(app,open: (url as URL?)!,sourceApplication:options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,annotation: options[UIApplication.OpenURLOptionsKey.annotation] as Any){
            return true
        }else if GIDSignIn.sharedInstance().handle(url){
            return true
        }else{
            return true
        }
        
    }
    
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print(remoteMessage.appData)
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
    
        print(userInfo)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
     
        print(userInfo)
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        print(fcmToken)
        let dataDict:[String: String] = ["token": fcmToken]
        print(dataDict)
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        
        
        UserDefaults.standard.set(fcmToken, forKey: "devicetoken")
       
    }

  
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        AppEvents.activateApp()

    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    
    
    //MARK:- DEVICE TOKEN GET HERE
    //MARK:
    
    
    func registerForRemoteNotification() {
        
        if #available(iOS 10.0, *) {
            let center  = UNUserNotificationCenter.current()
            center.delegate = self
            center.requestAuthorization(options: [.sound, .alert, .badge]) { (granted, error) in
                if error == nil{
                    
                    DispatchQueue.main.async {
                        
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                    
                }
            }
        }
        else {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.sound, .alert, .badge], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
        }
        
    }
    
    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        
//        UserDefaults.standard.set(deviceTokenString as String, forKey: "devicetoken")
//
//        NSLog("Device Token : %@", deviceTokenString)
//
    }
    
    
    //MARK:  UNNOTIFICATION DELGATE METHODS
//
//    @available(iOS 10.0, *)
//
//    func userNotificationCenter(_ center: UNUserNotificationCenter,  willPresent notification: UNNotification, withCompletionHandler   completionHandler: @escaping (_ options:   UNNotificationPresentationOptions) -> Void){
//        completionHandler([.alert, .badge, .sound])
//
//    }
    
    
    @available(iOS 10, *)
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        guard let screen_name = ScreeNNameClass.shareScreenInstance.screenName as? String else{
            return
        }
        
        if let userInfo = notification.request.content.userInfo as? NSDictionary{
            print(userInfo)
            
             completionHandler([.alert, .badge, .sound])
            
            if let type = userInfo.value(forKey: "type") as? String{
                
                
                
                if screen_name == MyOrderOngoingVC.className{
                    if type == "confirmed" || type == "kitchen" || type == "out for delivery"{
                        UserDefaults.standard.set("", forKey: "ORDER_STATUS")
                        completionHandler([.alert, .badge, .sound])
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "MyOngoingReload"), object:nil, userInfo: nil)
                    }else if type == "delivered"{
                        UserDefaults.standard.set("DELIVERED", forKey: "ORDER_STATUS")
                        completionHandler([.alert, .badge, .sound])
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "MyPastReload"), object:nil, userInfo: nil)
                    }else if type == "rejected"{
                        UserDefaults.standard.set("", forKey: "ORDER_STATUS")
                        // Change this to your preferred presentation option
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "MyOngoingReload"), object:nil, userInfo: nil)
                        completionHandler([.alert, .badge, .sound])
                    }else{
                        completionHandler([.alert, .badge, .sound])
                    }
                }else{
                    // Change this to your preferred presentation option
                    completionHandler([.alert, .badge, .sound])
                }
                

            }
            
        }
        
     //   print(userInfo)
        
        
        
        
        
    }
    
    
    
    
 
    
    @available(iOS 10.0, *)
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void){
        print("in did recieve")
        if let userInfo = response.notification.request.content.userInfo as? NSDictionary{
            print(userInfo)
            let realm = try! Realm()
            if let userInfo1 = realm.objects(SignupDataModel.self).first{
                
                if userInfo1.access_token == ""{
                    let storyboard = UIStoryboard(name: "Auth", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "LogInVC") as! LoginVC
                    let nav = UINavigationController(rootViewController: vc)
                    nav.isNavigationBarHidden = true
                    (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController = nav
                }else{
                    
                    if let type = userInfo.value(forKey: "type") as? String{
                        if type == "delivered"{
                            UserDefaults.standard.set("DELIVERED", forKey: "ORDER_STATUS")
                        }else{
                           UserDefaults.standard.set("", forKey: "ORDER_STATUS")
                        }
                    }
                    
                    
                    let viewController = AppStoryboard.tabbarClass as! TabBarViewC
                    let navigationController = UINavigationController(rootViewController: viewController)
                    viewController.selectedIndex = 2
                    navigationController.navigationBar.isHidden = true
                    (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController = navigationController
                    
                    APPLICATION.keyWindow?.rootViewController = navigationController
                }
            }else{
                let storyboard = UIStoryboard(name: "Auth", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "LogInVC") as! LoginVC
                let nav = UINavigationController(rootViewController: vc)
                nav.isNavigationBarHidden = true
                (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController = nav
            }
        }
    }
    
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if InternetConnection.internetshared.isConnectedToNetwork(){
                    if let error = error {
                        print("\(error.localizedDescription)")
                    } else {
                        // Perform any operations on signed in user here.
                        let userId = user.userID                  // For client-side use only!
                        let idToken = user.authentication.idToken // Safe to send to the server
                        let fullName = user.profile.name
                        let givenName = user.profile.givenName
                        let familyName = user.profile.familyName
                        let email = user.profile.email
                        // ...
                    }
        }else{
            print("No internet")
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
        
        if InternetConnection.internetshared.isConnectedToNetwork(){
            if let error = error {
                print("\(error.localizedDescription)")
            } else {
                // Perform any operations on signed in user here.
                let userId = user.userID                  // For client-side use only!
                let idToken = user.authentication.idToken // Safe to send to the server
                let fullName = user.profile.name
                let givenName = user.profile.givenName
                let familyName = user.profile.familyName
                let email = user.profile.email
                // ...
            }
        }else{
            print("No internet")
        }
        
    }
}

