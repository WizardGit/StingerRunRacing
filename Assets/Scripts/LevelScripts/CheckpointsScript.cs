/*
 * Author: Kaiser Slocum
 * Last Modified: 9/19/2022
 * The Arrow pointing angle code is something I am VERY proud of.
 * Took forever to do!
 */

using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;

public class CheckpointsScript : MonoBehaviour
{    
    public GameObject models;
    public GameObject mainCamera;
    private GameObject player;

    public GameObject invisibleFinishLineTrigger;
    public GameObject arrow;

    // Private variables: list of our target game objects and current checkpoint reached
    private List<GameObject> targets;
    private List<GameObject> minimapTargets;
    private int currentCheckpointIndex = 0;   
    
    private AudioSource audioBleep;
    private SaveGame theSave;

    public int numLaps = 1;
    public int onLap = 1;

    // Start is called before the first frame update
    void Start()
    {
        audioBleep = gameObject.GetComponent<AudioSource>();

        ResetCheckpoints();

        // Get our player!
        theSave = GameObject.Find("SaveGameObject").GetComponent<SaveGame>();
        player = models.transform.GetChild(theSave.userSave.IndexOfDragonInUse()).gameObject;
    }

    // Update is called once per frame
    void FixedUpdate()
    {
        if (invisibleFinishLineTrigger.activeSelf == true)
        {
            // DisVec represents the vector between the player and the next checkpoint
            Vector3 disVec = targets[currentCheckpointIndex].transform.position - player.transform.position;
            // Look angle will represent the angle that our arrow needs to point to from our objective straight world line
            Vector3 lookAngleVec = Quaternion.LookRotation(disVec).eulerAngles;
            float c = -lookAngleVec.z;
            lookAngleVec.z = -lookAngleVec.y;
            lookAngleVec.y = c;

            // We want to cancel the angle that our player dragon is facing
            // This will mean our arrow is always pointing the same direction according to the world 
            Vector3 playerAngle = -(player.transform.localRotation.eulerAngles);

            bool thingy = mainCamera.GetComponent<CameraFollow>().lookForward;

            // If our camera turns around, we need our arrow to also turn around
            float yDir = 0;
            if (mainCamera.GetComponent<CameraFollow>().lookForward == false)
                yDir = 180;

            Vector3 frontDir = new Vector3(90, yDir, 0);

            // Add all these angles together! (Magic!!!)
            arrow.transform.rotation = Quaternion.Euler(playerAngle + frontDir + lookAngleVec);            

            // Update our next checkpoint
            if (targets[currentCheckpointIndex].activeInHierarchy == false)
            {
                audioBleep.Play();
                if (currentCheckpointIndex < targets.Count-2)
                {
                    targets[++currentCheckpointIndex].GetComponent<MeshRenderer>().material.color = Color.green;
                    minimapTargets[currentCheckpointIndex].GetComponent<MeshRenderer>().material.color = Color.green;
                    minimapTargets[currentCheckpointIndex - 1].SetActive(false);
                }
                else if (currentCheckpointIndex == (targets.Count - 2))
                {
                    currentCheckpointIndex++;
                    minimapTargets[currentCheckpointIndex - 1].SetActive(false);
                }
                else if (currentCheckpointIndex >= targets.Count)
                {
                    // We are done with the race
                    onLap++;
                    if (onLap <= numLaps)
                        ResetCheckpoints();
                    else
                        currentCheckpointIndex = 0;
                }
            }
        }
    }

    void ResetCheckpoints()
    {
        targets = new List<GameObject>();
        minimapTargets = new List<GameObject>();

        for (int i = 0; i < gameObject.transform.childCount; i++)
        {
            GameObject ring = gameObject.transform.GetChild(i).gameObject;
            for (int j = 0; j < ring.transform.childCount; j++)
            {
                if (ring.transform.GetChild(j).gameObject.name == "GlowingRingTarget")
                {
                    targets.Add(ring.transform.GetChild(j).gameObject);
                }
                else if (ring.transform.GetChild(j).gameObject.name == "Cube")
                {
                    minimapTargets.Add(ring.transform.GetChild(j).gameObject);
                }
            }
        }
        foreach (GameObject target in targets)
        {
            target.GetComponent<MeshRenderer>().material.color = Color.red;
        }
        foreach (GameObject minimapTarget in minimapTargets)
        {
            minimapTarget.GetComponent<MeshRenderer>().material.color = Color.red;
        }
        targets[0].GetComponent<MeshRenderer>().material.color = Color.green;
        minimapTargets[0].GetComponent<MeshRenderer>().material.color = Color.green;
        targets.Add(invisibleFinishLineTrigger);
    }
}
