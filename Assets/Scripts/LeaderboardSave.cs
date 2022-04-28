/*
 * Author: Kaiser Slocum
 */

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
    private string dataFile;

    public LeaderboardSave()
    {
        dataFile = Application.persistentDataPath + "/leaderboard.save";
        Debug.Log("Data file stored at: " + dataFile);
        //File.Delete(dataFile);
        if (File.Exists(dataFile))
        {
            Debug.Log("THE BIG LOAD");
            LoadGame();
        }
        else
        {
            Debug.Log("The BIG SAVE");
            level1users = new string[] { "Person1", "Person2", "Person3", "Person4", "Person5", "Person6" };
            level2users = new string[] { "Person1", "Person2", "Person3", "Person4", "Person5", "Person6" };
            level3users = new string[] { "Person1", "Person2", "Person3", "Person4", "Person5", "Person6" };
            level1times = new float[] { -1.0f, -1.0f, -1.0f, -1.0f, -1.0f, -1.0f };
            level2times = new float[] { -1.0f, -1.0f, -1.0f, -1.0f, -1.0f, -1.0f };
            level3times = new float[] { -1.0f, -1.0f, -1.0f, -1.0f, -1.0f, -1.0f };

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
        Debug.Log("Leaderboard information saved");
    }
    //Loads the variables in the file at 'username' if possible
    public void LoadGame()
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
            level1times = ledsave.level1times;
            level2times = ledsave.level2times;
            level3times = ledsave.level3times;
        }
        else
        {
            Debug.Log("No file for this user!");
        }
    }

    private void rotateDownUsers(ref string[] users, int index)
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
    private void rotateDownTimes(ref float[] times, int index)
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
        //Debug.Log("Users before" + users[0] + users[1] + users[2] + users[3] + users[4] + users[5]);
        for (int i = 0; i < times.Length; i++)
        {
            if ((time < times[i]) || (times[i] < 0))
            {
                rotateDownTimes(ref times, i);
                rotateDownUsers(ref users, i);
                times[i] = time;
                users[i] = username;
                //Debug.Log("Users after" + users[0] + users[1] + users[2] + users[3] + users[4] + users[5]);
                //Debug.Log("Times" + times[0].ToString() + times[1].ToString() + times[5].ToString());
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
        else
        {
            Debug.Log("INVALID level!");
        }      
    }
}
