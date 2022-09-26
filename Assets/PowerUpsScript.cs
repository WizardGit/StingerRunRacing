/*
 * Author: Kaiser Slocum
 * Last Modified: 9/25/2022
 */

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PowerUpsScript : MonoBehaviour
{
    public void ResetCheckpoints()
    {
        for (int i = 0; i < gameObject.transform.childCount; i++)
        {
            gameObject.transform.GetChild(i).gameObject.SetActive(true);
        }
    }
}
