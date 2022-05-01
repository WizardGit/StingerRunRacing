/*
 * Author: Kaiser Slocum
 * Last Modified: 5/1/2022
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
    public TextMeshProUGUI distanceText;
    public GameObject player;
    public GameObject invisibleFinishLineTrigger;
    public GameObject arrow;

    // Private variables: list of our target game objects and current checkpoint reached
    private List<GameObject> targets;
    private int currentCheckpointIndex = 0;    

    // Start is called before the first frame update
    void Start()
    {
        targets = new List<GameObject>();

        for (int i = 0; i < gameObject.transform.childCount; i++)
        {
            GameObject ring = gameObject.transform.GetChild(i).gameObject;
            for (int j = 0; j < ring.transform.childCount; j++)
            {
                if (ring.transform.GetChild(j).gameObject.name == "GlowingRingTarget")
                {
                    targets.Add(ring.transform.GetChild(j).gameObject);
                }
            }
        }
        foreach (GameObject target in targets)
        {
            target.GetComponent<MeshRenderer>().material.color = Color.red;
        }
        targets[0].GetComponent<MeshRenderer>().material.color = Color.green;
        targets.Add(invisibleFinishLineTrigger);  
    }

    // Update is called once per frame
    void Update()
    {
        if (invisibleFinishLineTrigger.activeSelf == true)
        {
            // DisVec represents the vector between the player and the next checkpoing
            Vector3 disVec = targets[currentCheckpointIndex].transform.position - player.transform.position;
            float thing = MathF.Abs(disVec.x) + MathF.Abs(disVec.y) + MathF.Abs(disVec.z);
            distanceText.text = "Next: " + MathF.Round(thing,2).ToString();
            // Look angle will represent the angle that our arrow needs to point to from our objective straight world line
            Vector3 lookAngleVec = Quaternion.LookRotation(disVec).eulerAngles;
            float c = -lookAngleVec.z;
            lookAngleVec.z = -lookAngleVec.y;
            lookAngleVec.y = c;

            // We want to cancel the angle that our player dragon is facing
            // This will mean our arrow is always pointing the same direction according to the world 
            Vector3 playerAngle = -(player.transform.localRotation.eulerAngles);
            Vector3 frontDir = new Vector3(90, 0, 0);

            // Add all these angles together! (Magic!!!)
            arrow.transform.rotation = Quaternion.Euler(playerAngle + frontDir + lookAngleVec);            

            // Update our next checkpoint
            if (targets[currentCheckpointIndex].activeInHierarchy == false)
            {
                if (currentCheckpointIndex < targets.Count-2)
                {
                    targets[++currentCheckpointIndex].GetComponent<MeshRenderer>().material.color = Color.green;
                }
                else if (currentCheckpointIndex == (targets.Count - 2))
                {
                    currentCheckpointIndex++;
                }
                else if (currentCheckpointIndex >= targets.Count)
                {
                    // We are done with the race
                    currentCheckpointIndex = 0;
                }
            }
        }
        else
        {
            distanceText.text = "";
        }
    }
}
