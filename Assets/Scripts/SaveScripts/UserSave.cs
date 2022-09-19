/*
 * Author: Kaiser Slocum
 * Last Modified: 9/11/2022
 * Purpose: Saves users' information
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
    public int gems = 0;
    public int numSheep = 0;

    public List<Dragon> dragons;
    public List<int> quests;
    public List<bool> gemsList;
    const int numLevels = 5;
    public List<float> levelTimes;

    public string username = "nouser";
    public string dataFile = "";

    public UserSave(string user)
    {
        username = user;

        dataFile = Application.persistentDataPath + "/" + username + ".save";
        if (File.Exists(dataFile))
        {            
            LoadUser();
        }
        else
        {
            CreateUser();
            SaveUser();
        }
    }

    // Creates a brand new user
    private void CreateUser()
    {
        Speedstinger speed = new Speedstinger();
        Dreadstrider dread = new Dreadstrider();
        dragons = new List<Dragon>();
        quests = new List<int>();
        gemsList = new List<bool>();

        levelTimes = new List<float>();
        for (int i = 0; i < numLevels; i++)
        {
            levelTimes.Add(-1f);
        }

        for (int i = 0; i < 3; i++)
        {
            speed.AddSkin("Buy");
            speed.AddSkinPrice(i * 100);
            dread.AddSkin("Buy");
            dread.AddSkinPrice(i * 110);
        }
        speed.SetSkin(0, "Using");
        dread.SetSkin(0, "Using");
        dragons.Add(speed);
        dragons.Add(dread);
    }

    // Saves our class/variables to a local file
    public void SaveUser()
    {      
        BinaryFormatter bf = new BinaryFormatter();
        FileStream file = File.Create(dataFile);
        bf.Serialize(file, this);
        file.Close();
    }
    //Loads the variables in the file at 'username' if possible
    public void LoadUser()
    {
        if (File.Exists(dataFile))
        {
            BinaryFormatter bf = new BinaryFormatter();
            FileStream file = File.Open(dataFile, FileMode.Open);
            UserSave user = (UserSave)bf.Deserialize(file);
            file.Close();
            try
            {
                coins = user.coins;
                gems = user.gems;
                numSheep = user.numSheep;
                levelTimes = user.levelTimes;
                dragons = user.dragons;
                quests = user.quests;
                gemsList = user.gemsList;
                username = user.username;
            }
            catch
            {
                DeleteUser();
                CreateUser();
                coins = 400;
                gems = 40;
                SaveUser();
            }          
        }
        else
            Debug.Log("No file for this user!");
    }
    public void DeleteUser()
    {
        File.Delete(dataFile);
    }

    // Returns a reference to the dragon that is currently in use
    public int IndexOfDragonInUse()
    {
        for (int i = 0; i < dragons.Count; i++)
        {
            if (dragons[i].GetUse() == "Using")
                return i;
        }
        return -1;
    }
    public int IndexOfDragon(Dragon derg)
    {
        for (int i = 0; i < dragons.Count; i++)
        {
            if (dragons[i] == derg)
                return i;
        }
        return -1;
    }
    public void UseDragon(int dragonIndex)
    {
        dragons[dragonIndex].ChangeUse("Using");

        for (int i = 0; i < dragons.Count; i++)
        {
            if ((dragons[i].GetUse() == "Using") && (i != dragonIndex))
                dragons[i].ChangeUse("Switch");            
        }
        SaveUser();
    }
}
