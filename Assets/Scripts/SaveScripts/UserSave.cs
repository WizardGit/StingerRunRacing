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

    public string[] dreadSkins;
    public int currDreadSkin = 0;

    public string[] speedSkins;
    public int currSpeedSkin = 0;


    public string username = "nouser";
    public string dataFile = "";

    public UserSave(string user)
    {
        username = user;
        dreadSkins = new string[3] { "Using", "Buy", "Buy" };
        speedSkins = new string[3] { "Using", "Buy", "Buy" };

        dataFile = Application.persistentDataPath + "/" + username + ".save";
        //Debug.Log("Data file stored at: " + dataFile);
        File.Delete(dataFile);
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

            dreadSkins = user.dreadSkins;
            currDreadSkin = user.currDreadSkin;

            speedSkins = user.speedSkins;
            currSpeedSkin = user.currSpeedSkin;

            username = user.username;
            Debug.Log("User information Loaded");
        }
        else
        {
            Debug.Log("No file for this user!");
        }
    }
}
