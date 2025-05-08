/* Author: Kaiser Slocum
 * Last Modified: 5/7/2025
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
        //transform.up = mainCamera.transform.position - transform.position;
        // Get base rotation facing opposite camera.forward
        // Combine the two rotations (face away from camera, then tilt around X axis)
        transform.rotation = Quaternion.LookRotation(-mainCamera.transform.forward, mainCamera.transform.up) * Quaternion.AngleAxis(90, Vector3.right);
    }
}
