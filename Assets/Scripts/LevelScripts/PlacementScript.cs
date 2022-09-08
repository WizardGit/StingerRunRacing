/*
 * Author: Kaiser Slocum
 * Last Modified: 7/14/2022
 */

using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.InputSystem;
using TMPro;
using UnityEngine.SceneManagement;

public class PlacementScript : MonoBehaviour
{
    public GameObject dragonPlayers;
    public GameObject npcRacers;
    private PlayerController player;
    public TextMeshProUGUI raceBoard;
    public TextMeshProUGUI coinsWin;
    private int rankCounter = 1;
    public GameObject checkpoints;
    private List<int> stuff = new List<int>();
    
    private float time = 0.0f;
    private float startTime = 3.0f;
    public TextMeshProUGUI timeText;
    public GameObject pauseMenu;
    public GameObject ledBoard;

    private void Start()
    {
        timeText.text =  "Time: 0:0.0";
        UserSave usersave = new UserSave(NameTransfer.theName);

        ledBoard.SetActive(false);
        // Get our target
        for (int i = 0; i < usersave.dragons.Count; i++)
        {
            if (usersave.dragons[i].GetUse() == "Using")
                player = dragonPlayers.transform.GetChild(i).gameObject.GetComponent<PlayerController>();
        }
        for (int i = 0; i < npcRacers.transform.childCount; i++)
        {
            stuff.Add(0);
        }
        stuff.Add(0);
        raceBoard.text = "";
    }

    // Update is called once per frame
    void FixedUpdate()
    {
        int placement = 1;

        if (startTime > 0)
        {
            startTime -= Time.deltaTime;
        }
        if (startTime <= 0)
        {
            time += Time.deltaTime;
            if (stuff[0] != 1)
            {
                float minutes = MathF.Truncate(time / 60);
                float seconds = MathF.Round(time - (minutes * 60), 2);
                timeText.text = "Time: " + minutes + ":" + seconds;
            }           
        }

        if ((player.checkpointsReached == (checkpoints.transform.childCount + 1)) && (stuff[0] != 1))
        {
            

            float theTheTime = time;
            FinishPlayer(theTheTime);
            raceBoard.text += "\n" + (rankCounter++).ToString() + ". " + player.username + ": " + MathF.Round(theTheTime, 3).ToString();
            UserSave usersave = new UserSave(NameTransfer.theName);
            int numCoins = (npcRacers.transform.childCount + 2 - rankCounter) * 10;
            usersave.coins += numCoins;
            coinsWin.text = "You just won " + numCoins + " Coins!";

            
            stuff[0] = 1;
            usersave.SaveUser();
        }
        else
        {
            for (int i = 0; i < npcRacers.transform.childCount; i++)
            {
                WaypointTrip racer = npcRacers.transform.GetChild(i).gameObject.GetComponent<WaypointTrip>();

                if ((racer.checkpointsReached == (checkpoints.transform.childCount + 1)) && (stuff[i + 1] != 1))
                {
                    FinishNPC(time, racer.username);
                    raceBoard.text += "\n" + (rankCounter++).ToString() + ". " + racer.username + ": " + MathF.Round(time, 3).ToString();
                    stuff[i + 1] = 1;
                }

                if ((racer.checkpointsReached > player.checkpointsReached)
                || ((racer.checkpointsReached == player.checkpointsReached) && (racer.disToCheckpoint < player.disToCheckpoint)))
                {
                    placement++;
                }
            }
        }        
        gameObject.GetComponent<TextMeshProUGUI>().text = "Ranking: " + placement.ToString();
    }

    void FinishPlayer(float localTime)
    {
        string theName = NameTransfer.theName;
        string username = "";
        if (theName != null)
            username = theName;
        else
            Debug.Log("ERROR: no username!");
        UserSave usersave = new UserSave(username);
        LeaderboardSave ledsave = new LeaderboardSave();
        string sName = SceneManager.GetActiveScene().name;

        int levelNum = 0;
        if (sName == "LevelOne")
        {
            levelNum = 1;
            if ((localTime < usersave.levelOneTime) || (usersave.levelOneTime < 0))
                usersave.levelOneTime = localTime;
        }
        else if (sName == "LevelTwo")
        {
            levelNum = 2;
            if ((localTime < usersave.levelTwoTime) || (usersave.levelTwoTime < 0))
                usersave.levelTwoTime = localTime;
        }
        else if (sName == "LevelThree")
        {
            levelNum = 3;
            if ((localTime < usersave.levelThreeTime) || (usersave.levelThreeTime < 0))
                usersave.levelThreeTime = localTime;
        }
        else if (sName == "LevelFour")
        {
            levelNum = 4;
            if ((localTime < usersave.levelFourTime) || (usersave.levelFourTime < 0))
                usersave.levelFourTime = localTime;
        }
        else
        {
            Debug.Log("Scene name unrecognized in player controller!");
        }

        usersave.SaveUser();
        ledsave.SaveTime(levelNum, username, MathF.Round(localTime, 3));
        ledBoard.transform.GetChild(0).gameObject.GetComponent<TextMeshProUGUI>().text = username + ": " + MathF.Round(localTime, 3);
        ledBoard.transform.GetChild(1).gameObject.GetComponent<TextMeshProUGUI>().text = ledsave.GetLeaderboard(levelNum);

        ledBoard.SetActive(true);
    }
    void FinishNPC(float localTime, string racerUsername)
    {
        LeaderboardSave ledsave = new LeaderboardSave();

        string sName = SceneManager.GetActiveScene().name;
        int levelNum = 0;
        if (sName == "LevelOne")
            levelNum = 1;
        else if (sName == "LevelTwo")
            levelNum = 2;
        else if (sName == "LevelThree")
            levelNum = 3;
        else
            Debug.Log("Scene name unrecognized in player controller!");

        ledsave.SaveTime(levelNum, racerUsername, MathF.Round(localTime, 3));
        ledBoard.transform.GetChild(1).gameObject.GetComponent<TextMeshProUGUI>().text = ledsave.GetLeaderboard(levelNum);
    }
}
