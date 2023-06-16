// EditUser.swift
// AzsProject
//
// Created by geka231 on 12.06.2023.

import SwiftUI

struct EditUser: View {
    @State private var name: String = ""
    @State private var genderSelection = false
    @State private var selectedGender: String?
    @State private var showDatePicker = false
    @State private var dateOfBirth = Date()
    @State private var email: String = ""
    @State private var isSaved = false
    @State private var showAlert = false
    @State private var errorMessage = ""
    @State private var nameError = ""
    @State private var dateError = ""
    @State private var emailError = ""
    
    let genders = ["Мужской", "Женский"]
    let nameRegex = "[а-яА-ЯёЁ]+"
    let emailRegex = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    
    var body: some View {
        VStack(spacing: 30) {
            LineTextField(text: $name, placeholder: "Имя", title: "Имя", regex: nameRegex, errorMessage: nameError)
            
            Button(action: {
                genderSelection = true
            }) {
                HStack {
                    Text("Выберите пол")
                        .foregroundColor(.primary)
                    Spacer()
                    if let selectedGender = selectedGender {
                        Text(selectedGender)
                            .foregroundColor(.secondary)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .buttonStyle(SelectionButtonStyle())
            
            Button(action: {
                showDatePicker = true
            }) {
                HStack {
                    Text("Выберите дату рождения")
                        .foregroundColor(.primary)
                    Spacer()
                    Text(formattedDate)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .buttonStyle(SelectionButtonStyle())
            
            LineTextField(text: $email, placeholder: "Email", title: "Email", regex: emailRegex, errorMessage: emailError)
            
            Button(action: {
                saveUser()
            }) {
                Text("Сохранить")
                    .frame(width: 200, height: 50)
                    .background(Color.green)
                    .foregroundColor(.black)
                    .font(.system(.title, design: .rounded))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 2)
                    )
            }
            .padding(.top, 50)
        }
        
        .padding()
        .actionSheet(isPresented: $genderSelection) {
            ActionSheet(title: Text("Выберите пол"), buttons: createGenderButtons())
        }
        .sheet(isPresented: $showDatePicker) {
            VStack {
                Spacer()
                DatePicker(selection: $dateOfBirth, in: Date().addingTimeInterval(-100*365*24*60*60)...Date().addingTimeInterval(-10*365*24*60*60), displayedComponents: .date) {
                    Text("Выберите дату рождения")
                        .font(.headline)
                        .padding()
                }
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden()
                
                Button(action: {
                    showDatePicker = false
                }) {
                    Text("Готово")
                        .font(.headline)
                        .padding()
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .padding()
            .frame(maxHeight: .infinity)
            .presentationDetents($showDatePicker.wrappedValue ? Set([.medium]) : Set([.medium]))
        }
        .onAppear {
            fetchUserData()
        }.alert(isPresented: $showAlert) {
            Alert(
                title: Text("Ошибка"),
                message: Text("Не удалось сохранить данные"),
                dismissButton: .default(Text("OK"))
            )
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Успешно"),
                message: Text("Данные сохранены успешно"),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    private func createGenderButtons() -> [ActionSheet.Button] {
        var buttons: [ActionSheet.Button] = []
        for gender in genders {
            buttons.append(.default(Text(gender), action: {
                selectedGender = gender
            }))
        }
        buttons.append(.cancel())
        return buttons
    }
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: dateOfBirth)
    }
    
    private func fetchUserData() {
        let callInfo = CallInfoAboutUser.shared
        callInfo.aboutUser { [self] (result: Result<(String, String, String, String), Error>) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    name = data.0
                    selectedGender = data.1
                    
                    if let convertedDate = convertDateFormat(data.2) {
                        dateOfBirth = convertedDate
                    }
                    
                    email = data.3
                }
            case .failure(let error):
                print("API request failed: \(error)")
            }
        }
    }
    
    private func convertDateFormat(_ dateString: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        return formatter.date(from: dateString)
    }
    
    private func saveUser() {
        guard validateFields() else {
            return
        }
        
        APIManagerForEdit.shared.createCardAndVerifyToken(Name: name, Gender: selectedGender!, DateOfBitrh: dateOfBirth, Email: email) { result in
            switch result {
            case .success(let data):
                print("User data saved successfully")
                DispatchQueue.main.async {
                    showAlert = true
                }
            case .failure(let error):
                print("API request failed: \(error)")
                DispatchQueue.main.async {
                    showAlert = true
                }
            }
        }
    }
    
    private func validateFields() -> Bool {
        var isValid = true
        nameError = ""
        emailError = ""
        
        if name.isEmpty {
            nameError = "Имя не может быть пустым"
            isValid = false
        } else if !isTextValid(text: name, regex: nameRegex) {
            nameError = "Неверный формат имени"
            isValid = false
        }
        
        if email.isEmpty {
            emailError = "Email не может быть пустым"
            isValid = false
        } else if !isTextValid(text: email, regex: emailRegex) {
            emailError = "Неверный формат email"
            isValid = false
        }
        
        let currentYear = Calendar.current.component(.year, from: Date())
        let minYear = 1900
        let maxYear = 2005
        
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.year], from: dateOfBirth)
        if let birthYear = components.year {
            if birthYear < minYear || birthYear > maxYear {
                dateError = "Недопустимый год рождения"
                isValid = false
            }
        }
        
        return isValid
    }
    
    private func isTextValid(text: String, regex: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: text)
    }
}

struct LineTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1).foregroundColor(.green))
    }
}

struct LineTextField: View {
    @Binding var text: String
    var placeholder: String
    var title: String
    var regex: String
    var errorMessage: String
    
    var body: some View {
        ZStack {
            TextField(placeholder, text: $text)
                .textFieldStyle(LineTextFieldStyle())
            VStack(alignment: .leading) {
                Text(title)
                    .foregroundColor(.green)
                    .background(Color.white)
                    .opacity(1)
                    .offset(x: -150, y: -28)
                    .padding(3)
            }
        }
        .overlay(Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.system(size: 12))
                    .padding(.top, 4)
                    .opacity(errorMessage.isEmpty ? 0 : 1)
        )
    }
}

struct SelectionButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 1)
                    .foregroundColor(.green)
            )
            .foregroundColor(.primary)
    }
}

struct EditUser_Previews: PreviewProvider {
    static var previews: some View {
        EditUser()
    }
}
