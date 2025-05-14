/* Author: Kaiser Slocum
 * Last Modified: 5/14/2025
 * Purpose: 
 */

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TargetScript : MonoBehaviour
{
    private Camera mainCamera;
    private SaveGame theSave;
    private GameObject player;
    private GameObject dragonPlayers;
    public bool setRed = false;
    public bool canAim = false;
    // Start is called before the first frame update
    void Start()
    {
        mainCamera = GameObject.FindWithTag("MainCamera").GetComponent<Camera>();
        theSave = GameObject.Find("SaveGameObject").GetComponent<SaveGame>();
        dragonPlayers = GameObject.Find("DragonPlayers");
        player = dragonPlayers.transform.GetChild(theSave.userSave.IndexOfDragonInUse()).gameObject;
    }

    // Update is called once per frame
    void FixedUpdate()
    {
        transform.up = mainCamera.transform.position - transform.position;
        transform.forward = -mainCamera.transform.up;
        CalcPlayerDist();
    }

    private void CalcPlayerDist()
    {    
        Vector3 disVec = transform.position - player.transform.position;
        Vector3 lookAngleVec = Quaternion.LookRotation(disVec).eulerAngles;

        if (player.GetComponent<PlayerRacingController>().isAiming == false)
        {
            canAim = false;
            transform.GetChild(0).gameObject.SetActive(false);
            transform.GetChild(1).gameObject.SetActive(false);
        }
        else if (player.GetComponent<PlayerRacingController>().isAiming == true)
        {
            canAim = true;
            if (setRed == true)
            {
                transform.GetChild(0).gameObject.SetActive(true);
                transform.GetChild(1).gameObject.SetActive(false);
            }
            else
            {
                transform.GetChild(0).gameObject.SetActive(false);
                transform.GetChild(1).gameObject.SetActive(true);
            }
        }        
    }
}
