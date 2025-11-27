//
//  UserSettingsView.swift
//  ZakFit
//
//  Created by Anne Ferret on 27/11/2025.
//

import SwiftUI

struct UserSettingsView: View {
    @Environment(MainViewModel.self) var vm
    @Environment(\.dismiss) private var dismiss

    @State var editUser = User()
    
    // UX states
    @State private var showCalendar = false
    @FocusState private var focusedField: Field?
    enum Field { case height, weight, cals }
    
    private var card: some View {
        HStack {
            Image(systemName: "person.crop.circle.fill")
                .font(.system(size: 72))
                .foregroundStyle(Color.Label.tertiary)
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(vm.user.firstName ?? "undefined")
                    Text(vm.user.lastName ?? "undefined")
                }
                .font(.cardSubheader)
                .foregroundStyle(Color.Label.primary)

                Text(vm.user.email ?? "undefined")
                    .font(.callout2)
                    .foregroundStyle(Color.Label.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 12) {
                Image(systemName: "pencil.circle")
                    .foregroundStyle(Color.Label.secondary)
                Image(systemName: "rectangle.portrait.and.arrow.forward")
                    .foregroundStyle(Color.Label.destructive)
            }
            .font(.system(size: 20))
            .fontWeight(.semibold)
            .padding(.vertical, 16)

        }
        .frame(maxWidth: .infinity)
        .padding()
        .glassEffect(.regular.tint(Color.Card.darkBackground))
    }
    private var morphology: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Ma morphologie")
                .font(.title2)
            
            GlassEffectContainer {
                VStack(spacing: 16) {
                    DataBox(label: "Date de naissance", icon: .calendar) {
                        if let birthday = editUser.birthday {
                            Text(birthday.formatted(.dateTime.day(.twoDigits)))
                                .font(.cardDataSmall)
                            Text("/")
                                .font(.cardUnit)
                            Text(birthday.formatted(.dateTime.month(.twoDigits)))
                                .font(.cardDataSmall)
                            Text("/")
                                .font(.cardUnit)
                            Text(birthday.formatted(.dateTime.year()))
                                .font(.cardDataSmall)
                        }
                    }
                    .onTapGesture {
                        showCalendar = true
                    }
                    
                    Menu {
                        Picker("Niveau d'activité physique", selection: $editUser.physicalActivity) {
                            Text("5 : Très intense").tag(5)
                            Text("4 : Intense").tag(4)
                            Text("3 : Quotidien").tag(3)
                            Text("2 : Moyen").tag(2)
                            Text("1 : Faible").tag(1)
                            Text("0 : Sédentaire").tag(0)
                        }
                    } label: {
                        DataBox(label: "Niveau d'activité physique", icon: .list) {
                            if let physicalActivity = editUser.physicalActivity {
                                Text("\(physicalActivity)")
                                    .font(.cardData)
                            }
                        }
                    }
                    
                    HStack {
                        Menu {
                            Picker("Sexe", selection: $editUser.sex) {
                                Text("Homme").tag(true)
                                Text("Femme").tag(false)
                            }
                        } label: {
                            DataBox(label: "Sexe", icon: .list) {
                                if let sex = editUser.sex {
                                    Text(sex ? "H" : "F")
                                        .font(.cardData)
                                }
                            }
                        }
                        
                        
                        DataBox(label: "Taille", icon: .numbers) {
                            TextField("", value: $editUser.height, format: .number)
                                .font(.cardData)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.decimalPad)
                                .submitLabel(.next)
                                .focused($focusedField, equals: .height)
                            Text("cm")
                                .font(.cardUnit)
                                .offset(y: -5)
                        }
                        .onTapGesture {
                            focusedField = .height
                        }
                        
                        DataBox(label: "Poids", icon: .numbers) {
                            TextField("", value: $editUser.weight, format: .number)
                                .font(.cardData)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.decimalPad)
                                .submitLabel(.go)
                                .focused($focusedField, equals: .weight)
                            Text("kg")
                                .font(.cardUnit)
                                .offset(y: -5)
                        }
                        .onTapGesture {
                            focusedField = .weight
                        }
                    }
                }
            }

        }
    }
    
    private var calendar: some View {
        VStack {
            DatePicker("", selection: Binding(
                get: {
                    editUser.birthday ?? Calendar.current.date(
                        from: DateComponents(year: 2000, month: 1, day: 1)
                    )!
                },
                set: { editUser.birthday = $0 }
            ), displayedComponents: .date)
            .datePickerStyle(.wheel)
            .labelsHidden()
            .frame(maxWidth: .infinity, alignment: .center)
            
            Button("Valider") {
                showCalendar = false
            }
            .buttonStyle(CustomButtonStyle(state: .validate))
        }
        .presentationDetents([.fraction(0.35)])
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 36) {
                    
                    card
                    morphology

                }
                .padding()
            }
            
            .sheet(isPresented: $showCalendar) { calendar }
            
            .task {
                editUser = vm.user.copy()
            }
            

            .toolbar {
                ToolbarItem(placement: .title) {
                    Text("Mes préférences")
                        .font(.smallTitle)
                        .foregroundStyle(Color.Label.primary)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Confirmer", systemImage: "checkmark") {
                        Task {
                            let success: Bool = await vm.updateSettings(editUser)
                            if success { dismiss() }
                        }
                    }
                    .tint(Color.Button.validate)
                }
            }
            
            .navigationBarTitleDisplayMode(.inline)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                Color.App.background
                    .ignoresSafeArea()
            }
        }
    }
}

#Preview {
    UserSettingsView().environment(MainViewModel())
}
