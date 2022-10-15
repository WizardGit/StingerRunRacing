/* Author: Kaiser Slocum
 * Last Modified: 10/14/2022
 * Purpose: 
 */

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class QuestDirectionScript : MonoBehaviour
{
    private Camera mainCamera;

    private void Start()
    {
        mainCamera = GameObject.FindWithTag("MainCamera").GetComponent<Camera>();
    }

    // Update is called once per frame
    void FixedUpdate()
    {
        transform.up = mainCamera.transform.position - transform.position;
        transform.forward = -mainCamera.transform.up;
    }
}
