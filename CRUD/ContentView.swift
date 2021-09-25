//
//  ContentView.swift
//  CRUD
//
//  Created by David on 13/6/21.
//

import SwiftUI
import CoreData

class CoreDataViewModel: ObservableObject {
    
    let container: NSPersistentContainer
    
    @Published var savedPlants: [PlantEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "Data")
        
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print ("Error loading Core Data \(error.localizedDescription)")
            }
        }
        fetchPlants()
    }
    
    func fetchPlants() {
        let request = NSFetchRequest<PlantEntity>(entityName: "PlantEntity")
        
        do {
            savedPlants = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching CoreData \(error.localizedDescription)")
        }
    }
    
    func addPlant(text: String, size: String) {
        let newPlant = PlantEntity(context: container.viewContext)
        newPlant.name = text
        newPlant.size = size
        newPlant.id = UUID()
        savePlant()
    }
    
    func savePlant() {
        do {
            try container.viewContext.save()
            fetchPlants()
            
        } catch let error {
            print ("Error saving Core Data \(error.localizedDescription)")
        }
    }
    
    func deletePlant(indexSet: IndexSet) {
        guard let index = indexSet.first else {return}
        let entity = savedPlants[index]
        container.viewContext.delete(entity)
        savePlant()
    }
    
    func updatePlant(entity: PlantEntity) {
        savePlant()
    }
    
    
    
    
}

struct ContentView: View {
    
    // Init only once and hold in memory (@ObservedObject is used for subviews)
    @StateObject var vm = CoreDataViewModel()
    
    @State var textFieldName: String = ""
    @State var textFieldSize: String = ""
    
    var body: some View {
        
        NavigationView {
            VStack(spacing: 20) {
                TextField("Add plant name...", text: $textFieldName)
                    .font(.headline)
                    .padding(.leading)
                    .frame(height: 55)
                    .background(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                TextField("Add plant size...", text: $textFieldSize)
                    .font(.headline)
                    .padding(.leading)
                    .frame(height: 55)
                    .background(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                
                
                Button(action: {
                    guard !textFieldName.isEmpty else {return}
                    vm.addPlant(text: textFieldName, size: textFieldSize)
                    textFieldName = ""
                    textFieldSize = ""
                }, label: {
                    Text("Add Save")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)))
                        .cornerRadius(10)
                })
                .padding(.horizontal)
                .navigationTitle("Plants")
                
                Spacer()
                
                Spacer()
                
                List{
                    ForEach(vm.savedPlants) { entity in
                        
                        NavigationLink(destination: EditView(plantVM: vm, p: entity), label: {Text(entity.name ?? "No Plant")})
                    }
                    .onDelete(perform: vm.deletePlant)
                }
                .toolbar {
                    EditButton()
                }
                .listStyle(PlainListStyle())
            }
        }
    }
}



struct EditView: View {
        
    @Environment(\.presentationMode) var presentationMode
    
    // ObseredObject not init in this subview
    @ObservedObject var plantVM: CoreDataViewModel
    
    @State private var editMode = false
    
    @State var plantName: String = ""
    @State var plantSize: String = ""

    enum Field: Hashable {
            case plantName
        }

    
    let p: PlantEntity
    
    var body: some View {
        
        VStack{
            
            TextField("Name", text: $plantName)
             
                .font(.headline)
                .padding(.leading)
                .frame(height: 55)
                .background(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                .cornerRadius(10)
                .padding(.horizontal)
                .disabled(!editMode)
                
            TextField("Size", text: $plantSize)
                .font(.headline)
                .padding(.leading)
                .frame(height: 55)
                .background(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                .cornerRadius(10)
                .padding(.horizontal)
                .disabled(!editMode)
    
            Spacer()
        }

        .navigationBarItems(trailing: Button(editMode ? "Done" : "Edit") {
                self.editMode.toggle()
                self.p.name = plantName
                self.p.size = plantSize
                plantVM.updatePlant(entity: p)
            })
        
        .onAppear(perform: {
            self.plantName = p.name ?? ""
            self.plantSize = p.size ?? ""
      
        })
        
    }
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

