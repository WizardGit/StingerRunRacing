/*
 * Author: Kaiser Slocum
 * Last Modified: 9/4/2022
 */

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GemScript : MonoBehaviour
{
    UserSave usersave;
    void Start()
    {

        usersave = new UserSave(NameTransfer.theName);

        if ((usersave.gemsList.Count == 0) && (transform.childCount > 0))
        {
            for (int i = 0; i < transform.childCount; i++)
            {
                usersave.gemsList.Add(true);
            }
        }
        else if (transform.childCount < usersave.gemsList.Count)
        {
            while (transform.childCount < usersave.gemsList.Count)
            {
                usersave.gemsList.RemoveAt(0);
            }
        }
        else if (transform.childCount > usersave.gemsList.Count)
        {
            while (transform.childCount < usersave.gemsList.Count)
            {
                usersave.gemsList.Add(false);
            }
        }

        for (int i = 0; i < usersave.gemsList.Count; i++)
        {
            transform.GetChild(i).gameObject.SetActive(usersave.gemsList[i]);
        }
        usersave.SaveUser();

        
    }
    public void UpdateGemCollected()
    {
        usersave.LoadUser();
        usersave.gems += 10;
        for (int i = 0; i < usersave.gemsList.Count; i++)
        {
            usersave.gemsList[i] = transform.GetChild(i).gameObject.activeSelf;
        }
        usersave.SaveUser();
    }
}
