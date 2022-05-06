/*
 * Author: Kaiser Slocum
 * Last Modified: 5/6/2022
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

    public List<Dragon> dragons;

    public string username = "nouser";
    public string dataFile = "";

    public UserSave(string user)
    {
        username = user;

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
        Speedstinger speed = new Speedstinger();
        Dreadstrider dread = new Dreadstrider();
        dragons = new List<Dragon>();
        for (int i = 0; i < 3; i++)
        {
            speed.AddSkin("Buy");
            speed.AddSkinPrice(i * 10 + 10);
            dread.AddSkin("Buy");
            dread.AddSkinPrice(i * 10 + 20);
        }
        speed.SetSkin(0, "Using");
        dread.SetSkin(0, "Using");
        dragons.Add(speed);
        dragons.Add(dread);

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
            dragons = user.dragons;

            username = user.username;
            Debug.Log("User information Loaded");
            Debug.Log("Dragons 0: " + dragons[1].GetSpeedForce());
        }
        else
        {
            Debug.Log("No file for this user!");
        }
    }
}
