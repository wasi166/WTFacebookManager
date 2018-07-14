//
//  WTFacebookManager.swift
//  Facebook Login test
//
//  Created by Wasi Tariq on 14/07/2018.
//  Copyright © 2018 Wasi Tariq. All rights reserved.
//

import Foundation
import FBSDKLoginKit

class WTFacebookManager
{
    private let manager = FBSDKLoginManager()
    private init (){}
    
    static let sharedInstance = WTFacebookManager()
    
    var currentToken : FBSDKAccessToken?
    {
        get{
            return FBSDKAccessToken.current()
        }
    }
  
    var isTokenActive : Bool
    {
        get{
            return FBSDKAccessToken.currentAccessTokenIsActive()
        }
    }
    
    func logout()
    {
        manager.logOut()
        FBSDKAccessToken.setCurrent(nil)
        FBSDKProfile.setCurrent(nil)
    }
    
    func getBasicInfo(permissionList : [String] , completion : @escaping(Dictionary<String , AnyObject>?)->Void)
    {
        var permissionString = String()
        for permission in permissionList
        {
            permissionString += permission+","
        }
        
        if permissionString.hasSuffix(",")
        {
            permissionString.removeLast()
        }
        
        if self.currentToken == nil
        {
            print("No accounts logged in")
            completion(nil)
        }
        else
        {
            FBSDKGraphRequest(graphPath: "/me", parameters: ["fields":permissionString])?.start(completionHandler: { (connection, result, error) in
                if error != nil
                {
                    print("Error in requesting information : \(error!.localizedDescription)")
                    completion(nil)
                }
                else
                {
                    completion(result as? Dictionary<String , AnyObject>)
                }
            })
        }
    }
    
    func login(readPermissions : [String] , fromViewController : UIViewController? , completion : @escaping(Bool)->())
    {
        manager.logIn(withReadPermissions: readPermissions, from: fromViewController) { (loginResult, error) in
            
            if error != nil
            {
                print("login failed with due to : \(error!.localizedDescription)")
                completion(false)
                return
            }
            
            if loginResult!.isCancelled
            {
                print("Login request cancelled by the user")
                completion(false)
            }
            else
            {
                print("Login Success")
                completion(true)
            }
        }
    }
    
    func refreshToken(with Completion : @escaping(Bool , FBSDKAccessToken?)->Void)
    {
        FBSDKAccessToken.refreshCurrentAccessToken { (connection, result, error) in
            if(error == nil)
            {
                Completion(true,self.currentToken)
            }
            else
            {
                Completion(false , nil)
            }
        }
    }
    
}

