//
//  ContentView.swift
//  Notes-WatchOS Watch App
//
//  Created by Drashti on 20/12/23.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    @State private var notes: [Note] = [Note]()
    @State private var text:String = ""
    
    @AppStorage("lineCount") var lineCount: Int = 1
    
    // MARK: - Function
    func getDocumentDirectory() -> URL{
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    
    
    func save(){
        //dump(notes)
        
        do{
            // 1. Convert the notes array to data using JSONencoder
            let data = try JSONEncoder().encode(notes)
            // 2. Create a new url to save the file using the getDocumentDirectory
            let url = getDocumentDirectory().appendingPathComponent("notes")
            // 3. Write the data to the given URL
            try data.write(to: url)
        }
        catch{
            print("saving data has failed.")
        }
    }
    
    func load(){
        DispatchQueue.main.async {
            do {
                // 1. get notes url path
                let url = getDocumentDirectory().appendingPathComponent("notes")
                // 2. create a new property for the data
                let data = try Data(contentsOf: url)
                // 3. decode the data
                notes = try JSONDecoder().decode([Note].self, from: data)
            }
            catch{
                // Do nothing
            }
        }
    }
    
    func delete(offsets: IndexSet){
        withAnimation {
            notes.remove(atOffsets: offsets)
            save()
        }
    }
    
    // MARK: - Body
    var body: some View {
        NavigationView(content: {
            VStack {
                HStack(alignment:.center,spacing: 6){
                    TextField("Add New Note", text: $text)
                    
                    Button(action: {
                        // 1. only run the button's action when text is not empty.
                        guard text.isEmpty == false else { return }
                        
                        // 2. create a new note item and initialize it with the text value
                        let note = Note(id: UUID(), text: text)
                        
                        // 3. add the new note item to the notes array (append)
                        notes.append(note)
                        
                        // 4. Make the text field empty
                        text = ""
                        
                        // 5. Save the notes (function)
                        save()
                    }, label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 42, weight: .semibold))
                    })
                    .fixedSize()
                    .buttonStyle(PlainButtonStyle())
                    .foregroundStyle(.accent)
                }//:HStack
                Spacer()
                
                if notes.count >= 1 {
                    List{
                        ForEach(0..<notes.count, id: \.self){ i in
                            NavigationLink(destination: DetailView(note: notes[i], count: notes.count, index: i)) {
                                HStack{
                                    Capsule()
                                        .frame(width: 4)
                                        .foregroundStyle(.accent)
                                    
                                    Text(notes[i].text)
                                        .lineLimit(lineCount)
                                        .padding(.leading, 5)
                                }// HStack
                            }// Navigation
                        } // Loop
                        .onDelete(perform: { indexSet in
                            delete(offsets: indexSet)
                        })
                    }
                } else {
                    Spacer()
                    Image(systemName: "note.text")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.gray)
                        .opacity(0.25)
                        .padding(25)
                    Spacer()
                }// List
                
            }//:VStack
            .navigationTitle("Notes")
            .onAppear(perform: {
                load()
            })
        })
    }
}

#Preview {
    ContentView()
}
