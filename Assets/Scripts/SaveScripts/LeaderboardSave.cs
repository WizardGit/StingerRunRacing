/*
 * Author: Kaiser Slocum
 * Last Modified: 9/7/2022
 * Purpose: Save a copy of best times and users for each level
 */

using System;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.Serialization.Formatters.Binary;
using System.IO;
using UnityEngine;

[System.Serializable]
public class LeaderboardSave
{
    public string[] level1users;
    public float[] level1times;
    public string[] level2users;
    public float[] level2times;
    public string[] level3users;
    public float[] level3times;
    public string[] level4users;
    public float[] level4times;
    private string dataFile = "";

    public LeaderboardSave(string altDatapath="")
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

            level1users = ledsave.level1users;
            level2users = ledsave.level2users;
            level3users = ledsave.level3users;
            level4users = ledsave.level4users;
            level1times = ledsave.level1times;
            level2times = ledsave.level2times;
            level3times = ledsave.level3times;
            level4times = ledsave.level4times;
        }
        else
        {
            Debug.Log("No file for this user!");
        }
    }

    public void ResetLeaderboard()
    {
        level1users = new string[] { "Honey", "Kaizar", "Not Me", "Sonic", "Eric", "Person6" };
        level2users = new string[] { "Honey", "Kaizar", "Not Me", "Sonic", "Eric", "Person6" };
        level3users = new string[] { "Honey", "Kaizar", "Not Me", "Sonic", "Eric", "Person6" };
        level4users = new string[] { "Honey", "Kaizar", "Not Me", "Sonic", "Eric", "Person6" };
        level1times = new float[] { 90f, 100f, 110f, 120f, 140f, 160f };
        level2times = new float[] { 50f, 60f, 70f,  80f,  90f, 100f };
        level3times = new float[] { 80f, 90f, 100f, 110f, 130f, 160f };
        level4times = new float[] { 80f, 90f, 100f, 110f, 130f, 160f };

        SaveGame();
    }

    private void RotateDownUsers(ref string[] users, int index)
    {
        for (int i = (users.Length - 1); i > index; i--)
        {
            //Swap
            string temp = users[i];
            if (i - 1 >= users.Length)
            {
                users[i] = users[0];
                users[0] = temp;
            }
            else
            {
                users[i] = users[i - 1];
                users[i - 1] = temp;
            }
        }        
    }
    private void RotateDownTimes(ref float[] times, int index)
    {
        for (int i = (times.Length - 1); i > index; i--)
        {
            //Swap
            float temp = times[i];
            if (i-1 >= times.Length)
            {
                times[i] = times[0];
                times[0] = temp;
            }
            else
            {
                times[i] = times[i - 1];
                times[i - 1] = temp;
            }            
        }
    }
    private bool SaveTimesUsers(ref float[] times, ref string[] users, float time, string username)
    {
        for (int i = 0; i < times.Length; i++)
        {
            if ((time < times[i]) || (times[i] < 0))
            {
                RotateDownTimes(ref times, i);
                RotateDownUsers(ref users, i);
                times[i] = MathF.Round(time,5);
                users[i] = username;
                return true;
            }
        }
        return false;
    }
    public void SaveTime(int level, string username, float time)
    {
        if (level == 1)
        {
            SaveTimesUsers(ref level1times, ref level1users, time, username);
            SaveGame();
        }
        else if (level == 2)
        {
            SaveTimesUsers(ref level2times, ref level2users, time, username);
            SaveGame();
        }
        else if (level == 3)
        {
            SaveTimesUsers(ref level3times, ref level3users, time, username);
            SaveGame();
        }
        else if (level == 4)
        {
            SaveTimesUsers(ref level4times, ref level4users, time, username);
            SaveGame();
        }
        else
        {
            Debug.Log("ERROR: Invalid Level!");
        }      
    }
    private string GetLevelLed(ref float[] leveltimes, ref string[] levelusers)
    {
        string led = "";
        for (int i = 0; i < levelusers.Length; i++)
        {
            led += (i+1).ToString() + " " + levelusers[i] + ": " + leveltimes[i] + "\n";
        }
        return led;
    }
    public string GetLeaderboard(int level)
    {
        if (level == 1)
        {
            return GetLevelLed(ref level1times, ref level1users);
        }
        else if (level == 2)
        {
            return GetLevelLed(ref level2times, ref level2users);
        }
        else if (level == 3)
        {
            return GetLevelLed(ref level3times, ref level3users);
        }
        else if (level == 4)
        {
            return GetLevelLed(ref level4times, ref level4users);
        }
        else
        {
            Debug.Log("ERROR: Invalid Level!");
            return "";
        }
    }    
}
