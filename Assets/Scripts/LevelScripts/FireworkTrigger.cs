/* Created by Kaiser Slocum
 * Last Edited on 6/1/2022 by Kaiser Slocum
 * Purpose: To set off finish line fireworks once player runs over trigger
 */

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FireworkTrigger : MonoBehaviour
{
    public GameObject fireworksLeft;
    public GameObject fireworksRight;
    public GameObject checkpoints;

    public GameObject dragonPlayers;
    private GameObject targetObject;

    private void Start()
    {
        UserSave usersave = new UserSave(NameTransfer.theName);

        for (int i = 0; i < usersave.dragons.Count; i++)
        {
            if (usersave.dragons[i].GetUse() == "Using")
                targetObject = dragonPlayers.transform.GetChild(i).gameObject;
        }
    }
    
    private void FixedUpdate()
    {
        if (targetObject.GetComponent<PlayerController>().checkpointsReached == checkpoints.transform.childCount)
        {
            fireworksLeft.SetActive(true);
            fireworksRight.SetActive(true);
        }
    }
}
