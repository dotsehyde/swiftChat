//
//  AuthViewModel.swift
//  swiftchat
//
//  Created by Benjamin. on 05/01/2024.
//

import Foundation
import FirebaseAuth

enum AuthState {
    case loading
    case error
    case success
    case initial
}

class AuthViewModel: ObservableObject {
    
    @Published var isLoggedin:Bool = false
    @Published var userModel:UserModel
    @Published var state:AuthState = .initial
    @Published var errMsg:String = ""
    
    
    init(){
        userModel = UserModel.empty()
        checkUserLoggedIn()
    }
    
    func checkUserLoggedIn() {
        if Auth.auth().currentUser != nil {
            self.isLoggedin = true
            
            if let user = Auth.auth().currentUser {
                userModel = UserModel(id: user.uid, name: user.displayName ?? "N/A", email: user.email ?? "")
            }
            
        } else {
            self.isLoggedin = false
        }
        
    }
    
    //Login
    func loginUser(email:String, pass:String){
        self.state = .loading
        Auth.auth().signIn(withEmail: email, password: pass){ auth, err in
            if err != nil {
                self.state = .error
                self.errMsg = err?.localizedDescription ?? "Something went wronng"
                print("Login Error: \(String(describing: err?.localizedDescription))")
            }
            if let user = auth?.user {
                self.userModel = UserModel(id: user.uid,
                                           name: user.displayName ?? "",
                                           email: user.email ?? "")
                self.state = .initial
                self.isLoggedin = true
            }
        }
    }
    
    //Signup user
    func signupUser(name:String, email:String, pass:String){
        self.state = .loading
        Auth.auth().createUser(withEmail: email, password: pass){ auth, err in
            if err != nil {
                self.state = .error
                self.errMsg = err?.localizedDescription ?? "Something went wronng"
            }
            if let user = auth?.user {
                let changeReq = user.createProfileChangeRequest()
                changeReq.displayName = name
                changeReq.commitChanges(){ err in
                    
                    self.userModel = UserModel(id: user.uid,
                                               name: name,
                                               email: user.email ?? "")
                    self.state = .initial
                    self.isLoggedin = true
                }
                
            }
        }
    }
    
    //logout
    func logout(){
        do{
            try Auth.auth().signOut()
            self.isLoggedin = false
        }catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        
    }
}
