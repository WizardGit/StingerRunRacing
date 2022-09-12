/*
 * Author: Kaiser Slocum
 * Last Modified: 9/4/2022
 */

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GemScript : MonoBehaviour
{
    private SaveGame usersave;
    void Start()
    {
        usersave = GameObject.Find("SaveGameObject").GetComponent<SaveGame>();

        if ((usersave.userSave.gemsList.Count == 0) && (transform.childCount > 0))
        {
            for (int i = 0; i < transform.childCount; i++)
            {
                usersave.userSave.gemsList.Add(true);
            }
        }
        else if (transform.childCount < usersave.userSave.gemsList.Count)
        {
            while (transform.childCount < usersave.userSave.gemsList.Count)
            {
                usersave.userSave.gemsList.RemoveAt(0);
            }
        }
        else if (transform.childCount > usersave.userSave.gemsList.Count)
        {
            while (transform.childCount < usersave.userSave.gemsList.Count)
            {
                usersave.userSave.gemsList.Add(false);
            }
        }

        for (int i = 0; i < usersave.userSave.gemsList.Count; i++)
        {
            transform.GetChild(i).gameObject.SetActive(usersave.userSave.gemsList[i]);
        }
        usersave.userSave.SaveUser();        
    }
    public void UpdateGemCollected()
    {
        usersave.userSave.LoadUser();
        usersave.userSave.gems += 10;
        for (int i = 0; i < usersave.userSave.gemsList.Count; i++)
        {
            usersave.userSave.gemsList[i] = transform.GetChild(i).gameObject.activeSelf;
        }
        usersave.userSave.SaveUser();
    }
}
