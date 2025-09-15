//
//  ContentView.swift
//  DayCounter
//
//  Created by Mobin on 15.09.25.
//

import SwiftUI

struct ContentView: View {
    @State private var startTime: Date? = nil
    @State private var elapsedTime: TimeInterval = 0
    @State private var timer: Timer? = nil
    @State private var isRunning = false
    var body: some View {
        VStack (spacing: 40){
            //Display time
            Text(timeString(from:elapsedTime))
                .font(.system(size: 48, weight: .bold,design: .monospaced))
        }
        .padding()
        
        //Buttons
        HStack (spacing: 40){
            Button(isRunning ? "Stop" : "Start"){
                isRunning ? stopTimer() : startTimer()
            }
            .buttonStyle(.borderedProminent)
            
            Button("Reset"){
                resetTimer()
            }
            .buttonStyle(.bordered)
        }
        .padding()
    }
    // Mark: - Helper functions
    func startTimer(){
        if !isRunning{
            startTime = Date() - elapsedTime //resime if paused
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ _ in
                if let start = startTime {
                    elapsedTime = Date().timeIntervalSince(start)
                }
            }
            isRunning = true
        }
    }

    func stopTimer(){
        timer?.invalidate()
        timer = nil
        isRunning = false
    }

    func resetTimer () {
        stopTimer()
        elapsedTime = 0
        startTime = nil
    }

    func timeString(from interval: TimeInterval) -> String {
        let seconds = Int(interval) % 60
        let minutes = (Int(interval / 60)) % 60
        let hours = Int(interval) / 3600
        return String(format: "%02d:%02d:%02d", hours,minutes,seconds)
    }

}

#Preview {
    ContentView()
}
