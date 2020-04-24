//
//  PersistenceLayer.swift
//  MobileClasswork
//
//  Created by Macbook Pro 15 on 2/21/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

/*
import UIKit

/// https://www.makeschool.com/academy/track/standalone/habitual-tutorial---swift-4/persisting-habits
struct PersistenceLayer {

    /// Step 1 Step 1: Creating an array of habits, but what's this private(set) we are seeing?
    ///- We are making a setter variable which means that we can write to our array of habits - We are using private because we only want our array of habits to be accessible through our persistence layer
//    private(set) var habits: [Habit] = []

    /// Step 2 make this constant static because we only want one instance of this key no matter how many times this persistence layer is instantiated
    private static let userDefaultsHabitsKeyValue = "HABITS_ARRAY"

    init() {
        /// Step 3: As a developer we are concerned firstly, with what the user is interacting with therefore let us further analyze the loading of habits function for that is what the user will first be seeing, their habits on the screen.
//        self.loadHabits()
    }
    
    /// Step 4: We make this function mutating because we want to alter the copy of data that is assigned when a user instantiates this persistence layer, for more information on this refer to the difference between value and reference types!
    private mutating func loadHabits() {

        // Step 5
        let userDefaults = UserDefaults.standard

        /// Step 6: Grab our array of habits from our User Defaults for the given key we made earlier
        /// Decode the data that it gives us into a swift Habit object, and lastly populate our array of habits with our new Habit object!
        /// Now that the user is able to load a collection of their habits, they have to have a way to create a habit and persist it!
        guard
            let habitData = userDefaults.data(forKey: PersistenceLayer.userDefaultsHabitsKeyValue),
            let habits = try? JSONDecoder().decode([Habit].self, from: habitData) else {
                return
        }

        self.habits = habits
    }
    
    /// Step 7: Well we add this decorator to this function because we are not going to be using the result of this function directly, if not the compiler will generate a warning for us!
    @discardableResult
    /// Step 8: We create a new habit with the attributes that the user passes in - We are prepending our habit to our habit array as denoted by inserting at index 0 - We then save our new habit and return that new habit
    mutating func createNewHabit(name: String, image: Habit.Images) -> Habit {
        
        let newHabit = Habit(title: name, image: image)
        self.habits.insert(newHabit, at: 0) // Prepend the habits to the array
        self.saveHabits()
        
        return newHabit
    }
    
    private func saveHabits() {
        /// Step 9:  We handle our decoding logic in a guard statement providing us with an early exit if we can't decode our array of habits - If we can not decode our array of habits the app will crash with the error statement provided
        guard let habitsData = try? JSONEncoder().encode(self.habits) else { //decode array of habits
            fatalError("could not encode list of habits")
        }
        /// Step 10: If we do successfully decode our array of habits we then set that json data inside our User Defaults for its given key!
        let userDefaults = UserDefaults.standard
        userDefaults.set(habitsData, forKey: PersistenceLayer.userDefaultsHabitsKeyValue)
    }
    
    /// Step 11
    mutating func delete(_ habitIndex: Int) {
        // Remove habit at the given index
        self.habits.remove(at: habitIndex)
        // Persist the changes we made to our habits array
        self.saveHabits()
    }
    
    mutating func markHabitAsCompleted(_ habitIndex: Int) -> Habit {
        /// Step 12: We create a variable called updatedHabit that stores the habit at the given index.
        var updatedHabit = self.habits[habitIndex]
        /// Step 13: The next step is checking if that habit has been completed for the day. If the habit has not been completed then we increment the number of completions by 1. If it has already been completed then we return out of this function with the same habit
        guard updatedHabit.completedToday == false else { return updatedHabit }
        updatedHabit.numberOfCompletions += 1
        /// Step 14: We create a constant that is going to store the value of the current habit's last completion date With that value we check if that date was yesterday. If so then we increment the streak of the habit by 1. If the it wasn't completed yesterday we set the current streak to 1 denoting either it's a new habit or the user lost their streak on the habit
        if let lastCompletionDate = updatedHabit.lastCompletionDate, lastCompletionDate.isYesterday {
            updatedHabit.currentStreak += 1
        } else {
            updatedHabit.currentStreak = 1
        }
        /// Step 15: We then check if the current streak of our chosen habit is better than that habit's best streak!
        if updatedHabit.currentStreak > updatedHabit.bestStreak {
            updatedHabit.bestStreak = updatedHabit.currentStreak
        }
        /// Step 16: It's important to update the completion date of the habit so that our previous logic is still accurate at a later time!
        let now = Date()
        updatedHabit.lastCompletionDate = now
        /// Step 17: We then change the chosen habit to reflect the updated habit with changes we made
        self.habits[habitIndex] = updatedHabit
        /// Step 18: Lastly we save our changes made to our habits array and return the newly updated habit
        self.saveHabits()
        return updatedHabit
    }
    
    /// Step 19: The first function takes to parameters a habitIndex and a destinationIndex representing the two indices of the habits you want to swap - We remove the current habit from it's position and insert it at the destination index - We then save the newly made changes to our habit array
     mutating func swapHabits(habitIndex: Int, destinationIndex: Int) {
            let habitToSwap = self.habits[habitIndex]
            self.habits.remove(at: habitIndex)
            self.habits.insert(habitToSwap, at: destinationIndex)
            self.saveHabits()
        }

    /// Step 20: The next function comes in handy after we added a new habit and update the collection of habits present in the table view!
     mutating func setNeedsToReloadHabits() {
            self.loadHabits()
    }
}
*/
