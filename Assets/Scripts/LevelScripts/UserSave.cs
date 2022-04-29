/*
 * Author: Kaiser Slocum
 */

using System.Collections;
using System.Collections.Generic;
using System.Runtime.Serialization.Formatters.Binary;
using System.IO;
using UnityEngine;

[System.Serializable]
public class UserSave
{
    public int coins = 0;
    public int trophies = 0;
    public bool achievementSheep = false;
    public float levelOneTime = -1f;
    public float levelTwoTime = -1f;
    public float levelThreeTime = -1f;
    public string model = "speedstinger";
    public string skin = "normal";
    public string username = "nouser";
    public string dataFile = "";

    public UserSave(string user)
    {
        username = user;
        
        dataFile = Application.persistentDataPath + "/" + username + ".save";
        //Debug.Log("Data file stored at: " + dataFile);
        if (File.Exists(dataFile))
        {
            LoadGame();
        }
        else
        {
            SaveGame();
        }
    }

    // Saves our class/variables to a local file
    public void SaveGame()
    {
        BinaryFormatter bf = new BinaryFormatter();
        FileStream file = File.Create(dataFile);
        bf.Serialize(file, this);
        file.Close();
        Debug.Log("User information saved");
    }
    //Loads the variables in the file at 'username' if possible
    public void LoadGame()
    {
        if (File.Exists(dataFile))
        {
            BinaryFormatter bf = new BinaryFormatter();
            FileStream file = File.Open(dataFile, FileMode.Open);
            UserSave user = (UserSave)bf.Deserialize(file);
            file.Close();

            
            coins = user.coins;
            trophies = user.trophies;
            achievementSheep = user.achievementSheep;
            levelOneTime = user.levelOneTime;
            levelTwoTime = user.levelTwoTime;
            levelThreeTime = user.levelThreeTime;
            model = user.model;
            skin = user.skin;
            username = user.username;
            Debug.Log("User information Loaded");
        }
        else
        {
            Debug.Log("No file for this user!");
        }
    }
}
