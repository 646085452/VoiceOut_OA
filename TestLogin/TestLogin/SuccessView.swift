//
//  SuccessView.swift
//  TestLogin
//
//  Created by Jiaqi Chen on 5/29/24.
//

import SwiftUI

struct SuccessView: View {
    var body: some View {
        VStack {
            Text("注册成功！")
                .font(.system(size: 45, weight: .bold))
                .padding(.top, 200)
                .padding(.trailing, 60)
                .frame(maxWidth: .infinity, alignment: .trailing)
            Spacer()
        }
    }
}

struct SuccessView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessView()
    }
}
