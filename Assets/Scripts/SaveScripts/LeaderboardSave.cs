/*
 * Author: Kaiser Slocum
 * Last Modified: 9/13/2022
 * Purpose: Save a copy of best times and users for each level
 */

using System;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.Serialization.Formatters.Binary;
using System.IO;
using UnityEngine;

[System.Serializable]
public class LeaderboardUser
{
    private float bestTime;
    private string userName;

    public LeaderboardUser()
    {
        bestTime = 0.0f;
        userName = "nouser";
    }
    public LeaderboardUser(string u, float t)
    {
        bestTime = t;
        userName = u;
    }

    public void SetTime(float t)
    {
        bestTime = t;
    }
    public float GetTime() => bestTime;
    public string GetUser() => userName;
}

[System.Serializable]
public class LeaderboardLevel
{
    public List<LeaderboardUser> lvlLedBrd;
    public int maxPlayers;

    public LeaderboardLevel(int mp = 0)
    {
        lvlLedBrd = new List<LeaderboardUser>();
        maxPlayers = mp;
    }
    public void Add(string u, float t)
    {
        lvlLedBrd.Add(new LeaderboardUser(u, t));
    }
    public LeaderboardUser Get(int i)
    {
        return lvlLedBrd[i];
    }

    public void SaveTime(string u, float t)
    {
        for (int i = 0; i < maxPlayers; i++)
        {
            if (t < lvlLedBrd[i].GetTime())
            {
                lvlLedBrd.Insert(i, new LeaderboardUser(u, t));
                lvlLedBrd.RemoveAt(maxPlayers);
                return;
            }
        }
        // If we reach this point, then that the time was not good enough to make the leaderboard, so we won't add it.
    }
}

[System.Serializable]
public class LeaderboardSave
{
    public List<LeaderboardLevel> ledBoard;
    const int numPlayers = 6;
    const int numLevels = 5;
    private string dataFile = "";   

    public LeaderboardSave(string happy = "")
    {
        dataFile = Application.persistentDataPath + "/leaderboard.save";        
        if (File.Exists(dataFile))
            LoadGame();
        else
            ResetLeaderboard();
    }

    // Saves our class/variables to a local file
    private void SaveGame()
    {
        BinaryFormatter bf = new BinaryFormatter();
        FileStream file = File.Create(dataFile);
        bf.Serialize(file, this);
        file.Close();
        Debug.Log("Leaderboard information saved");
    }
    //Loads the variables in the file at 'username' if possible
    private void LoadGame()
    {
        if (File.Exists(dataFile))
        {
            BinaryFormatter bf = new BinaryFormatter();
            FileStream file = File.Open(dataFile, FileMode.Open);
            LeaderboardSave ledsave = (LeaderboardSave)bf.Deserialize(file);
            file.Close();
            try
            {

                ledBoard = ledsave.ledBoard;
                Debug.Log("Loaded User!");
            }
            catch
            {
                DeleteUser();
                ResetLeaderboard();
            }
        }
        else
            Debug.Log("No file for this theSave!");
    }
    public void DeleteUser()
    {
        File.Delete(dataFile);
    }

    public void ResetLeaderboard()
    {     
        string[] levelusers = new string[] { "Honey", "Kaizar", "Not Me", "Sonic", "Eric", "Person6" };
        float[] leveltimes = new float[] { 90f, 100f, 110f, 120f, 140f, 160f };
        ledBoard = new List<LeaderboardLevel>();

        for (int i = 0; i < numLevels; i++)
        {
            ledBoard.Add(new LeaderboardLevel(numPlayers));
            for (int j = 0; j < numPlayers; j++)
            {
                ledBoard[i].Add(levelusers[j], leveltimes[j]);
            }
            
        }
        SaveGame();
    }
    public void SaveTime(int level, string username, float time)
    {
        if (level > ledBoard.Count)
            Debug.Log("ERROR: Invalid Level!");
        else
        {
            ledBoard[level - 1].SaveTime(username, time);
            SaveGame();
        }    
    }
    public string GetLeaderboard(int level)
    {
        string led = "";
        if ((level > ledBoard.Count) || (level < 1))
            Debug.Log("ERROR: Invalid Level!");
        else
        {            
            for (int i = 0; i < ledBoard[level - 1].maxPlayers; i++)
            {
                led += (i + 1).ToString() + " " + ledBoard[level - 1].Get(i).GetUser() + ": " + ledBoard[level - 1].Get(i).GetTime() + "\n";
            }            
        }
        return led;
    }    
}