/*
 * Author: Kaiser Slocum
 * Last Modified: 9/11/2022
 * Purpose: Be one spot where everything is saved - that way nothing is being saved over each other
 * For this to work, you have to set Edit > Project Settings > Script Execution Order: SaveGame script to 120 so it is always run first
 * This is so that the user/leaderboard data has always been loaded when the game begins and objects start needing the data
 */

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SaveGame : MonoBehaviour
{
    public UserSave userSave;
    public LeaderboardSave ledSave;

    private void Start()
    {
        userSave = new UserSave(NameTransfer.theName);
        ledSave = new LeaderboardSave();
    }
}
