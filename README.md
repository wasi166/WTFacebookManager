# FacebookManager
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



