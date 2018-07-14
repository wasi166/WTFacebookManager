# WTFacebookManager
A simple Singleton class which can give you all the basic operation for FBSDKManager.

# Properties
- static sharedInstance : WTFacebookManager -> The shared instance of this class to interact with functions.
- currentToken : FBSDKAccessToken -> The current token from which the user is logged in.
- isTokenActive : Bool -> returns true if the current Access token is still active.

# Sample
    
    let manager = WTFacebookManager.sharedInstance
        
        if manager.isTokenActive
        {
            print("User is logged in with access token : \(manager.currentToken)")
        }
        else
        {
         print("Token is not active")
        }



# Logging in
     
     let manager = WTFacebookManager.sharedInstance
     manager.login(readPermissions: ["public_profile","email"], fromViewController: yourViewController) { (success) in
            if success 
            {
                print("Logged in successfully with access token : \(manager.currentToken)")
            }
            else
            {
                print("Error in logging in")
            }
        }
The success variable indicates whether the login went successful or nor.

# Getting the Info of User
Before getting the info of the user , you must make sure that user is logged in. Otherwise it will fail to obtain the information of user.

    WTFacebookManager.sharedInstance.login(readPermissions: ["public_profile","email"], fromViewController: yourViewController) { (success) in
     if success 
       {   
           WTFacebookManager.sharedInstance.getBasicInfo(permissionList: ["name","picture.type(Large)","email"]) { (info) in
            
            guard let userInfo = info
            else
            {
                print("Error in requesting information")
                return
            }
            print(userInfo["email"])
           
           }
        }
        else
         {
                print("Error in logging in")
         }
      }

# Logging Out

    WTFacebookManager.sharedInstance.logout()

# Refreshing The Token

        WTFacebookManager.sharedInstance.refreshToken { (success, token) in
            if success
            {
                print("Token refreshed successfully , New Token is : \(token)")
            }
            else
            {
                print("Error in refreshing Token")
            }
        }
        
        
# Usage
Liked it? want to use this in your project?
No Problem just copy the WTFacebookManager.swift file in your project and you are ready to go :)



