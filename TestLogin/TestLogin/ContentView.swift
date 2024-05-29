//
//  ContentView.swift
//  TestLogin
//
//  Created by Jiaqi Chen on 5/29/24.
//

import SwiftUI

struct SignInView: View {
    @State private var email: String = ""
    @State private var pwd: String = ""
    @State private var confirmPwd: String = ""
    
    @State private var ifPwdVisible: Bool = false
    @State private var ifConfirmPwdVisible: Bool = false
    @State private var emailValid: Bool = true
    @State private var pwdValid: Bool = true
    @State private var pwdMatch: Bool = true
    @State private var showSuccessPage: Bool = false
    
    // Intentionally set the email format like this
    // Local part allows special char ._-, domain only allows -
    // Domain must have at least 2 char after .
    private var ifEmailValid: Bool {
        let emailRegEx = "^[A-Za-z0-9._-]+@[A-Za-z0-9-]+\\.[A-Za-z]{2,}$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    // Password needs at least 8 chars and contain both letters and numbers
    private var ifPwdValid: Bool {
        let pwdRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        let pwdTest = NSPredicate(format:"SELF MATCHES %@", pwdRegEx)
        return pwdTest.evaluate(with: pwd)
    }
    
    private var ifPwdMatch: Bool {
        return confirmPwd == pwd
    }
    
    private var ifFormValid: Bool {
        return !email.isEmpty && !pwd.isEmpty && !confirmPwd.isEmpty
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Text("注册")
                    .font(.system(size: 25, weight: .bold))
                    .padding(.bottom, 20)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("邮箱")
                        .font(.headline)
                    
                    TextField("", text: $email)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .overlay(RoundedRectangle(cornerRadius: 15).stroke(emailValid ? Color.black : Color.red, lineWidth: 1))
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    
                    if !emailValid {
                        Text("请输入正确的邮箱格式")
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("密码")
                        .font(.headline)
                    
                    ZStack {
                        if ifPwdVisible {
                            TextField("", text: $pwd)
                                .padding()
                                .background(Color(.secondarySystemBackground))
                                .overlay(RoundedRectangle(cornerRadius: 15).stroke(pwdValid ? Color.black : Color.red, lineWidth: 1))
                                .autocapitalization(.none)
                        } else {
                            SecureField("", text: $pwd)
                                .padding()
                                .background(Color(.secondarySystemBackground))
                                .overlay(RoundedRectangle(cornerRadius: 15).stroke(pwdValid ? Color.black : Color.red, lineWidth: 1))
                                .autocapitalization(.none)
                        }
                        
                        HStack {
                            Spacer()
                            Button(action: {
                                ifPwdVisible.toggle()
                            }) {
                                Image(systemName: ifPwdVisible ? "eye" : "eye.slash")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 15)
                            }
                        }
                    }
                    
                    if !pwdValid {
                        Text("密码必须不少于八位，包含字母和数字！").foregroundColor(.red)
                            .font(.caption)
                    }
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("确认密码")
                        .font(.headline)
                    
                    ZStack {
                        if ifConfirmPwdVisible {
                            TextField("", text: $confirmPwd)
                                .padding()
                                .background(Color(.secondarySystemBackground))
                                .overlay(RoundedRectangle(cornerRadius: 15).stroke(pwdMatch ? Color.black : Color.red, lineWidth: 1))
                                .autocapitalization(.none)
                        } else {
                            SecureField("", text: $confirmPwd)
                                .padding()
                                .background(Color(.secondarySystemBackground))
                                .overlay(RoundedRectangle(cornerRadius: 15).stroke(pwdMatch ? Color.black : Color.red, lineWidth: 1))
                                .autocapitalization(.none)
                        }
                        
                        HStack {
                            Spacer()
                            Button(action: {
                                ifConfirmPwdVisible.toggle()
                            }) {
                                Image(systemName: ifConfirmPwdVisible ? "eye" : "eye.slash")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 15)
                            }
                        }
                    }
                    
                    if !pwdMatch {
                        Text("您输入的密码不一致！")
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                }
                
                Spacer()
                
                NavigationLink(destination: SuccessView(), isActive: $showSuccessPage) {
                    Button(action: {
                        emailValid = ifEmailValid
                        pwdValid = ifPwdValid
                        pwdMatch = ifPwdMatch
                        
                        if emailValid && pwdValid && pwdMatch {
                            showSuccessPage = true
                        }
                    }) {
                        Text("注  册")
                            .foregroundColor(.white)
                            .padding()
                            .font(.system(size: 18))
                            .frame(maxWidth: .infinity)
                            .background(ifFormValid ? Color.orange : Color.gray)
                            .cornerRadius(25)
                    }
                    .disabled(!ifFormValid)
                }
                .padding(.bottom, -100)
                
                Spacer()
            }
            .padding(.horizontal)
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
