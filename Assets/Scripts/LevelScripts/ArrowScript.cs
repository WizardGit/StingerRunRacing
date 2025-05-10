/*
 * Author: Kaiser Slocum
 * Last Modified:  5/9/2025
 * The Arrow pointing angle code is something I am VERY proud of.
 * Took forever to do! Still is goofed :(
 */

using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using static UnityEngine.GraphicsBuffer;

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
        Vector3 checkPointVec = checkpoints.transform.GetChild(playerScript.checkpointsReached - (numCheckpoints * playerScript.lapsCompleted)).transform.position;
        checkPointVec.y += 4;
        Vector3 disVec = checkPointVec - player.transform.position;
        // Look angle will represent the angle that our arrow needs to point to from our objective straight world line
        Vector3 lookAngleVec = Quaternion.LookRotation(disVec).eulerAngles;
        //lookAngleVec = new Vector3(lookAngleVec.x, -lookAngleVec.z, -lookAngleVec.y);

        // We want to cancel the angle that our player dragon is facing
        // This will mean our arrow is always pointing the same direction according to the world 
        Vector3 playerAngle = -(player.transform.localRotation.eulerAngles);

        // If our camera turns around, we need our arrow to also turn around
        float zDir = 0;
        if (mainCameraScript.lookForward == false)
            zDir = 180;

        Vector3 frontDir = new Vector3(90, 0, zDir);
        //Vector3 frontDir = new Vector3(270, 180, zDir);

        transform.rotation = Quaternion.Euler(frontDir + playerAngle + lookAngleVec);
    }
}
