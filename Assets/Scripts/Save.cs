using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[System.Serializable]
public class Save
{
    public int coins = 0;
    public int trophies = 0;
    public bool achievementSheep = false;
    public float levelOneTime = -1f;
    public float levelTwoTime = -1f;
    public float levelThreeTime = -1f;
    public string username = "nouser";   
}
