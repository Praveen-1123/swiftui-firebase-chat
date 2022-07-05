//
//  SignUpScreen.swift
//  Chatty
//
//  Created by Praveen Murugan on 31/10/21.
//

import SwiftUI
import Firebase

struct SignUpScreen: View {
    
    @State private var userName: String = ""
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isHighlight = false
    @State var selection: Int? = nil
    @State private var userNameValid: Bool = true
    @State private var firstNameValid: Bool = true
    @State private var lastNameValid: Bool = true
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
    
    
    func validateName(value: String) -> Bool {
        if(value.count >= 4){
            firstNameValid = true;
            lastNameValid = true;
            return true;
        } else {
            firstNameValid = false;
            lastNameValid = false;
            return false;
        }
    }
    
    
    func createUser() {
        let emailVal = isValidEmailAddress(emailAddressString: email)
        let passVal = isValidPassword(passwordString: password)
        let userNameVal = validateName(value: userName)
        let firstNameVal = validateName(value: firstName)
        let lastNameVal = validateName(value: lastName)
        
        if(emailVal && passVal && userNameVal && firstNameVal && lastNameVal){
            session.signUp(email: email, password: password ) { (result, error) in
                if error != nil {
                    showAlert = true;
                } else {
                    let userId: String = Auth.auth().currentUser?.uid ?? ""
                    firestore.createUser(
                        userName: userName,
                        userId: userId,
                        userEmail: email,
                        firstName: firstName,
                        lastName: lastName)
                        self.selection = 1
                }
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Spacer()
                Text("Create Account")
                    .fontWeight(.semibold)
                    .font(.custom("Optima", size: 40))
                    .padding(EdgeInsets(top: 40, leading: 10, bottom: 50, trailing: 0))
                    Section {
                        TextField(
                            "User Name (ex: chatty_23)",
                            text: $userName
                        ).onSubmit {
                        }
                        .onChange(of: userName, perform: { _ in
                            userNameValid = true;
                        })
                        .padding(10)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(userNameValid ? .black : .red, lineWidth:userNameValid ? 0.5 : 2.0))
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        TextField(
                            "First Name",
                            text: $firstName
                        ).onSubmit {
                        }
                        .onChange(of: firstName, perform: { _ in
                            firstNameValid = true;
                        })
                        .padding(10)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(firstNameValid ? .black : .red, lineWidth:firstNameValid ? 0.5 : 2.0))
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        TextField(
                            "Last Name",
                            text: $lastName
                        ).onSubmit {
                        }
                        .onChange(of: lastName, perform: { _ in
                            lastNameValid = true;
                        })
                        .padding(10)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(lastNameValid ? .black : .red, lineWidth:lastNameValid ? 0.5 : 2.0))
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        TextField(
                            "Email",
                            text: $email
                        ).onSubmit {
                            let validate = isValidEmailAddress(emailAddressString: email)
                            print("Validation \(validate)")
                        }
                        .onChange(of: email, perform: { _ in
                            emailValid = true;
                        })
                        .padding(10)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(emailValid ? .black : .red, lineWidth:emailValid ? 0.5 : 2.05))
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        SecureField(
                            "Password",
                            text: $password
                        ).onSubmit {
                            let validate = isValidPassword(passwordString: password)
                            print("Validation \(validate)")
                            }
                        .onChange(of: password, perform: { _ in
                            passwordValid = true;
                        })
                        .padding(10)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(passwordValid ? .black : .red, lineWidth:passwordValid ? 0.5 : 2.0))
                    }
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                Spacer()
                Group {
                    VStack {
                        NavigationLink(destination: TabBarView(),
                            tag: 1, selection: $selection) {
                        LargeButton(
                            buttonText: "S I G N U P",
                            buttonAction: {
                                createUser()
                            })
                        }
                        HStack {
                            Text("Already have an account?")
                            NavigationLink (destination: SignInScreen()) {
                            Text("Sign In")
                                .foregroundColor(Constants.chattyBlue)
                            }
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0))
                    }
                    .navigationBarHidden(true)
                }
            }
            .alert(isPresented: $showAlert, content: {
                Alert(title: Text("Failed"),
                      message:  Text("Something went wrong.Please check your details"),
                      dismissButton: .default(Text("Close")))
            })
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct SignUpScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignUpScreen()
    }
}
