/*
 * Author: Kaiser Slocum
 * Last Modified: 5/12/2025
 * Purpose: traces the directions the specified object is pointing
 */

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GizmosLine : MonoBehaviour
{
    public GameObject testObject;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    void OnDrawGizmos()
    {
        if (testObject != null)
        {
            Gizmos.color = Color.red;
            Gizmos.DrawRay(testObject.transform.position, testObject.transform.forward * 2f);
        }
    }
}
