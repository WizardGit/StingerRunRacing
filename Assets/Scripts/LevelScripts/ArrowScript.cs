/*
 * Author: Kaiser Slocum
 * Last Modified:  5/21/2025
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
    private GameObject mainCamera;

    private GameObject checkpoints;
    private int numCheckpoints;

    // Start is called before the first frame update
    void Start()
    {
        // Get our player!
        player = GameObject.Find("DragonPlayers").transform.GetChild(GameObject.Find("SaveGameObject").GetComponent<SaveGame>().userSave.IndexOfDragonInUse()).gameObject;
        playerScript = player.GetComponent<PlayerRacingController>();
        checkpoints = GameObject.Find("Checkpoints").transform.gameObject;        
        numCheckpoints = checkpoints.transform.childCount;

        mainCamera = GameObject.Find("Main Camera").GetComponent<Camera>().gameObject;
    }

    // Using Update - called once per frame
    void Update()
    {
        // DisVec represents the vector between the player and the next checkpoint
        Vector3 checkPointVec = checkpoints.transform.GetChild(playerScript.checkpointsReached - (numCheckpoints * playerScript.lapsCompleted)).transform.position;
        // Aim for more of the center of the checkpoint
        checkPointVec.y += 4;
        Vector3 disVec = checkPointVec - player.transform.position;
        // Look angle will represent the angle that our arrow needs to point to from our objective straight world line
        Vector3 lookAngleVec = Quaternion.LookRotation(disVec).eulerAngles;

        // We want to cancel the angle that our camera is facing
        // This will mean our arrow is always pointing the same direction according to the world 
        Vector3 cameraAngle = -(mainCamera.transform.rotation.eulerAngles);

        //Tip the arrow onto its side
        Vector3 frontDir = new Vector3(90, 0, 0);

        transform.rotation = Quaternion.Euler(frontDir + cameraAngle + lookAngleVec);
    }
}
