//
//  SignInScreen.swift
//  Chatty
//
//  Created by Praveen Murugan on 31/10/21.
//

import SwiftUI
import Firebase

struct SignInScreen: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isHighlight = false
    @State var selection: Int? = nil
    @State private var emailValid: Bool = true
    @State private var passwordValid: Bool = true
    @State private var showAlert: Bool = false
    
    @EnvironmentObject var session: SessionManager
    @EnvironmentObject var firestore: FirestoreManager
    
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        emailValid = returnValue
        return returnValue
    }
    
    func isValidPassword(passwordString: String) -> Bool {
        if(passwordString.count >= 8){
            passwordValid = true;
            return true;
        } else {
            passwordValid = false;
            return false;
        }
    }
    
    func checkData() {
        let emailVal = isValidEmailAddress(emailAddressString: email)
        let passVal = isValidPassword(passwordString: password)
        if(emailVal && passVal){
            session.signIn(email: email, password: password) { (result, error) in
                if error != nil {
                    showAlert = true;
                } else {
                    self.firestore.userId = Auth.auth().currentUser?.uid ?? ""
                    firestore.getUserDetails(userId: firestore.userId)
                    self.selection = 1
                }
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Hello. \nWelcome Back")
                    .fontWeight(.semibold)
                    .font(.custom("Optima", size: 45))
                    .padding(EdgeInsets(top: 40, leading: 0, bottom: 0, trailing: 0))
                Group {
                    Text("E M A I L")
                        .foregroundColor(.gray)
                        .padding(EdgeInsets(top: 25, leading: 0, bottom: 0, trailing: 0))
                    TextField(
                        "",
                        text: $email
                    ).onSubmit {
                        let validate = isValidEmailAddress(emailAddressString: email)
                        print("Validation \(validate)")
                            }
                        .onChange(of: email, perform: { _ in
                            emailValid = true;
                        })
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        Divider()
                        .frame(height: 0.5)
                        .padding(.horizontal, 30)
                        .background(Color.gray)
                    if emailValid {
                        Text("")
                    }
                    else {
                        Text("Email not valid")
                            .foregroundColor(.red)
                    }
                    Text("P A S S W O R D")
                        .foregroundColor(.gray)
                        .padding(EdgeInsets(top: 40, leading: 0, bottom: 0, trailing: 0))
                    SecureField(
                        "",
                        text: $password
                    ).onSubmit {
                        let validate = isValidPassword(passwordString: password)
                        print("Validation \(validate)")
                        }
                    .onChange(of: password, perform: { _ in
                        passwordValid = true;
                    })
                    Divider()
                    .frame(height: 0.8)
                    .padding(.horizontal, 30)
                    .background(Color.gray)
                    if passwordValid {
                        Text("")
                    }
                    else {
                        Text("Must contain minimum 8 characters")
                            .foregroundColor(.red)
                    }
                    HStack {
                        Spacer()
                        NavigationLink (destination: ForgotPassword()) {
                        Text("Forgot password?")
                            .foregroundColor(Constants.chattyBlue)
                            .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 10))
                        }
                    }
                }
                Spacer()
                Group {
                    VStack {
                        NavigationLink(destination: TabBarView(),
                            tag: 1, selection: $selection) {
                        LargeButton(
                            buttonText: "L O G I N",
                            buttonAction: {
                                checkData()
                            })
                        }
                        NavigationLink (destination: SignUpScreen()) {
                        Text("Create Account")
                            .foregroundColor(Constants.chattyBlue)
                            .padding(EdgeInsets(top: 5, leading: 0, bottom: 20, trailing: 10))
                        }
                    }
                    .navigationBarHidden(true)
                }
            }
            .alert(isPresented: $showAlert, content: {
                Alert(title: Text("Failed"),
                      message:  Text("Failed to login. Please check your email and password"),
                      dismissButton: .default(Text("Close")))
            })
        }
            .navigationTitle("")
            .navigationBarHidden(true)
            .padding(EdgeInsets(top: 5, leading: 15, bottom: 0, trailing: 10))
            .frame( alignment: .topLeading)
    }
}


struct SignInScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignInScreen()
    }
}
