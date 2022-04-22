using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;

public class CheckpointsScript : MonoBehaviour
{
    private List<GameObject> targets;
    public TextMeshProUGUI distanceText;
    public GameObject player;
    public GameObject invisibleFinishLineTrigger;
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
        distanceText.text = "Next checkpoint: \n" + (targets[currentCheckpointIndex].transform.position - player.transform.position).ToString();

        // Update our next checkpoint
        if (targets[currentCheckpointIndex].activeInHierarchy == false)
        {
            if (currentCheckpointIndex < targets.Count-2)
            {
                targets[++currentCheckpointIndex].GetComponent<MeshRenderer>().material.color = Color.green;
            }
            if (currentCheckpointIndex >= targets.Count)
            {
                // We are done with the race
                currentCheckpointIndex = 0;
            }
        }
    }
}
