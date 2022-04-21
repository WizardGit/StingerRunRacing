using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CheckpointsScript : MonoBehaviour
{
    private List<GameObject> targets;

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
                    Debug.Log("Adding Target");
                    targets.Add(ring.transform.GetChild(j).gameObject);
                }
            }
        }
        foreach (GameObject target in targets)
        {
            target.GetComponent<MeshRenderer>().material.color = Color.red;
        }
        target[0].GetComponent<MeshRenderer>().material.color = Color.green;
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
