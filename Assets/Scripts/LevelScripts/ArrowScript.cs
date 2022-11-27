/*
 * Author: Kaiser Slocum
 * Last Modified:  11/26/2022
 * The Arrow pointing angle code is something I am VERY proud of.
 * Took forever to do!
 */

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ArrowScript : MonoBehaviour
{
    private GameObject player;
    private PlayerRacingController playerScript;
    private CameraFollow mainCameraScript;

    private GameObject checkpoints;
    private int numCheckpoints;

    // Start is called before the first frame update
    void Start()
    {
        // Get our player!
        player = GameObject.Find("DragonPlayers").transform.GetChild(GameObject.Find("SaveGameObject").GetComponent<SaveGame>().userSave.IndexOfDragonInUse()).gameObject;
        playerScript = player.GetComponent<PlayerRacingController>();
        checkpoints = GameObject.Find("Checkpoints").transform.gameObject;
        mainCameraScript = GameObject.Find("Main Camera").GetComponent<Camera>().GetComponent<CameraFollow>();
        numCheckpoints = checkpoints.transform.childCount;
    }

    // Update is called once per frame
    void FixedUpdate()
    {
        // DisVec represents the vector between the player and the next checkpoint
        Vector3 disVec = checkpoints.transform.GetChild(playerScript.checkpointsReached - (numCheckpoints * playerScript.lapsCompleted)).transform.position - player.transform.position;
        // Look angle will represent the angle that our arrow needs to point to from our objective straight world line
        Vector3 lookAngleVec = Quaternion.LookRotation(disVec).eulerAngles;
        Vector3 lookAngleVec2 = Quaternion.LookRotation(disVec).eulerAngles;
        float c = -lookAngleVec.z;
        lookAngleVec.z = -lookAngleVec.y;
        lookAngleVec.y = c;

        // We want to cancel the angle that our player dragon is facing
        // This will mean our arrow is always pointing the same direction according to the world 
        Vector3 playerAngle = -(player.transform.localRotation.eulerAngles);

        // If our camera turns around, we need our arrow to also turn around
        float yDir = 0;
        if (mainCameraScript.lookForward == false)
            yDir = 180;

        Vector3 frontDir = new Vector3(90, yDir, 0);

        // Add all these angles together! (Magic!!!)
        transform.rotation = Quaternion.Euler(playerAngle + frontDir + lookAngleVec);
    }    
}
