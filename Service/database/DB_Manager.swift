//
//  DB_Manager.swift
//  Service
//
//  Created by My iMac on 24/1/2025.
//

import Foundation

internal import SQLite

public class DB_Manager {
    private var db: Connection!
    
    public init() {
        do{
            if let databasePath = Bundle.main.path(forResource: "database", ofType: "sqlite") {
                // Initialize the SQLite connection
                db = try Connection(databasePath)
                print("Database initialized successfully.")
            } else {
                print("Database file not found in the app bundle.")
            }

        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func getURLbyID(id: Int64) -> String? {
        do {
            // Prepare the query
            let query = "SELECT url FROM Paintings WHERE id = \(id)"
            let statement = try db.prepare(query)
            
            // Execute the query and fetch the result
            for row in statement {
                if let image_url = row[0] as? String {
                    return image_url
                }
            }
        } catch {
            print("Error executing query: \(error)")

        }
        return nil // Return nil if no rows match
//        return url
    }
    
    public func getInspirationText(id: Int64, idLanguage: Int64) -> String? {
        do {
            // Prepare the query
            let query = "SELECT inspiration FROM Inspirations WHERE id = \(id) AND idLanguage = \(idLanguage)"
            let statement = try db.prepare(query)
            
            // Execute the query and fetch the result
            for row in statement {
                if let inspiration = row[0] as? String {
                    return inspiration
                }
            }
        } catch {
            print("Error executing query: \(error)")

        }
        return nil // Return nil if no rows match
    }
    
    public func getMusicURLbyID (id: Int64) -> String? {
        do {
            let query = "SELECT idSpotify FROM Tracks WHERE id = \(id)"
            let statement = try db.prepare(query)
            
            // Execute the query and fetch the result
            for row in statement {
                if let musicUrl = row[0] as? String {
                    return musicUrl
                }
            }
        } catch {
            print("Error executing query: \(error)")

        }
        return nil // Return nil if no rows match
    }
    
    public func getMusicNamebyID (id: Int64) -> String? {
        do {
            let query = "SELECT name FROM Tracks WHERE id = \(id)"
            let statement = try db.prepare(query)
            
            // Execute the query and fetch the result
            for row in statement {
                if let musicName = row[0] as? String {
                    return musicName
                }
            }
        } catch {
            print("Error executing query: \(error)")

        }
        return nil // Return nil if no rows match
    }
    
    public func getImageIDbyURL(url: String) -> Int64? {
        do {
            let query = "SELECT id FROM Paintings WHERE url = ?"
            let statement = try db.prepare(query)
            try statement.bind(url)

            for row in statement {
                if let imageID = row[0] as? Int64 {
                    return imageID
                }
            }
        } catch {
            print("Error executing query: \(error)")
        }
        return nil
    }
    
    public func getMusicIDbyURL(url: String) -> Int64? {
        do {
            let query = "SELECT id FROM Tracks WHERE idSpotify = ?"
            let statement = try db.prepare(query)
            try statement.bind(url)

            for row in statement {
                if let musicID = row[0] as? Int64 {
                    return musicID
                }
            }
        } catch {
            print("Error executing query: \(error)")
        }
        return nil
    }

    public func getInspirationIDbyText(inspiration: String) -> Int64? {
        do {
            let query = "SELECT id FROM Inspirations WHERE inspiration = ?"
            let statement = try db.prepare(query)
            try statement.bind(inspiration)

            for row in statement {
                if let inspirationID = row[0] as? Int64 {
                    return inspirationID
                }
            }
        } catch {
            print("Error executing query: \(error)")
        }
        return nil
    }

}
