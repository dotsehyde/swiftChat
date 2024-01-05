//
//  AuthView.swift
//  swiftchat
//
//  Created by Benjamin. on 04/01/2024.
//

import SwiftUI

struct AuthView: View {
    @State var email:String = ""
    @State var password:String=""
    @State var name:String=""
    @State private var showAlert = false
    @State var isLogin = true
    @State private var isSecure: Bool = true
    @State var showPassword = false
    @ObservedObject var authViewModel: AuthViewModel
    var body: some View {
        VStack{
            Image("logo").resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
            Text("SwiftChat").font(.title).bold()
                Text(
                    isLogin ? "Login into your account." : "Create an new account."
                )
                .font(.subheadline)
            if(!isLogin){
                HStack(spacing: 5){
                    Image(systemName: "person")
                        .foregroundStyle(.gray)
                    TextField("Name", text: $name)
                        .textInputAutocapitalization(.never)
                }
                .padding()
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(lineWidth: 0.5).foregroundStyle(Color("Primary"))
                    
                })
                    .padding(.horizontal)
                    .padding(.bottom,5 )
            }
            
            HStack(spacing: 5){
                Image(systemName: "envelope")
                    .foregroundStyle(.gray)
                TextField("Email Address", text: $email)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
            }
            .padding()
            .overlay(content: {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 0.5).foregroundStyle(Color("Primary"))
                
            })
            .padding(.horizontal)
            
            HStack(spacing: 5){
                Image(systemName: "lock.fill")
                    .foregroundStyle(.gray)
                if isSecure{
                    SecureField("Password", text: $password)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.alphabet)
                }else{
                    TextField("Password", text: $password)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.alphabet)
                }
                Image(systemName: "eye")
                    .foregroundStyle(.gray)
                    .onTapGesture {
                        withAnimation {
                            isSecure.toggle()
                        }
                    }
            }
            .padding()
            .overlay(content: {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 0.5).foregroundStyle(Color("Primary"))
                
            })
            .padding(.horizontal)
                .padding(.top,5)
            if   authViewModel.state == .loading {
                ProgressView()
                    .padding(.top)
            }else{  Button{
                if isLogin {
                    authViewModel.loginUser(email: email, pass: password)
                }else{
                    authViewModel.signupUser(name: name, email: email, pass: password)
                }
            }label:{
                Text(isLogin ? "Login" : "Signup")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color("Primary"))
                    .cornerRadius(10)
                    .foregroundColor(.white)
            }
           
            .padding(.horizontal)
            .padding(.top)
            }
            Button(isLogin ? "Create an account" : "Already have an account?") {
                    isLogin.toggle()
            }
            .padding(.top)
        }
        .onChange(of: authViewModel.state) { newValue in
            if newValue == .error {
                // show errorDialog
                showAlert = true
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Authentication Error"),
                  message: Text(authViewModel.errMsg),
                  dismissButton: .default(Text("OK"),action: {
                showAlert = false
            })
            )
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView(authViewModel: AuthViewModel())
    }
}
