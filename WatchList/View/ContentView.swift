//
//  ContentView.swift
//  WatchList
//
//  Created by lucas.igarashi on 28/10/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
  // MARK: - PROPERTIES
  
  @Environment(\.modelContext) var modelContext
  @Query private var movies: [Movie]
  
  @State private var isSheetPresented: Bool = false
  @State private var randomMovie: String = ""
  @State private var isShowingAlert: Bool = false
  
  // MARK: - FUNCTIONS
  
  private func randomMovieGenerator() {
    randomMovie = movies.randomElement()!.title
  }
  
  var body: some View {
    List {
      if !movies.isEmpty {
        Section(
          header:
            VStack {
              Text("Watchlist")
                .font(.largeTitle.weight(.black))
                .foregroundStyle(.blue.gradient)
                .padding()
              
              HStack {
                Label("Title", systemImage: "movieclapper")
                Spacer()
                Label("Genre", systemImage: "tag")
              }
            }
        ) {
          ForEach(movies) { movie in
            HStack {
              Text(movie.title)
                .font(.title.weight(.light))
                .padding(.vertical, 2)
              
              Spacer()
              
              Text(movie.genre.name)
                .font(.footnote.weight(.medium))
                .padding(.horizontal, 6)
                .padding(.vertical, 3)
                .background(
                  Capsule()
                    .stroke(lineWidth: 1)
                )
                .foregroundStyle(.tertiary)
            } //: LIST ROW
            .swipeActions {
              Button(role: .destructive) {
                withAnimation {
                  modelContext.delete(movie)
                }
              } label: {
                Label("Delete", systemImage: "trash")
              }
            }
          }
        }
      }
    } //: LIST
    .overlay {
      if movies.isEmpty {
        EmptyListView()
      }
    }
    // MARK: - SAFE AREA
    .safeAreaInset(edge: .bottom, alignment: .center) {
      HStack {
        if movies.count >= 2 {
          // RANDOMIZE BUTTON
          Button {
            randomMovieGenerator()
            isShowingAlert = true
          } label: {
            ButtonImageView(symbolName: "arrow.trianglehead.2.clockwise.rotate.90.circle.fill")
          }
          .alert(randomMovie, isPresented: $isShowingAlert) {
            Button("OK", role: .cancel) {}
          }
          .accessibilityLabel("Random Movie")
          .sensoryFeedback(.success, trigger: isShowingAlert)
          
          Spacer()
        }
        
        // NEW MOVIE BUTTON
        Button {
          isSheetPresented.toggle()
        } label: {
          ButtonImageView(symbolName: "plus.circle.fill")
        }
        .accessibilityLabel("New Movie")
        .sensoryFeedback(.success, trigger: isSheetPresented)
      }
      .padding(.horizontal)
    } //: SAFE AREA
    // MARK: - SHEET
    .sheet(isPresented: $isSheetPresented) {
      NewMovieFormView()
    }
  }
}

#Preview("Sample Data") {
  ContentView()
    .modelContainer(Movie.preview)
}

#Preview("Empty List") {
  ContentView()
    .modelContainer(for: Movie.self, inMemory: true)
}
