/* Created by Kaiser Slocum
 * Last Edited on 4/14/2022 by Kaiser Slocum
 * Purpose: To constantly modify the camera's positioning on the object
 */
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

public class CameraFollow : MonoBehaviour
{
    public Transform target;

    public Vector3 offsetPosition;
    public Vector3 offsetRotation;

    public bool lookAt = true;
    public bool check = false;

    private void FixedUpdate()
    {
        // If we want to look at our dragon...
        if ((lookAt == true) && (check == false))
        {
            // Get where our camera needs to be
            transform.position = target.TransformPoint(offsetPosition);

            // Calculate the angle that our gcamera needs to be at
            Quaternion lookRotation = Quaternion.LookRotation(target.transform.position - transform.position);
            // Add in our offset values
            Vector3 transformRotation = new Vector3(lookRotation.eulerAngles.x - offsetRotation.x,
                                                    lookRotation.eulerAngles.y - offsetRotation.y,
                                                    lookRotation.eulerAngles.z - offsetRotation.z);
            // 'Smoothly' rotate towards our target camera point
            transform.rotation = Quaternion.Slerp(transform.rotation, Quaternion.Euler(transformRotation), 30 * Time.deltaTime);
        }
        // Else if we want to "be" our dragon...
        else if ((lookAt == true) && (check == true))
        {
            // The camera needs to be in our object but rotated by 180 degrees
            Vector3 targetRotation = target.rotation.eulerAngles;
            Vector3 transformRotation = new Vector3(targetRotation.x, targetRotation.y + 180, targetRotation.z);
            transform.rotation = Quaternion.Euler(transformRotation);
        }
        else if ((lookAt == false) && (check == false))
        {
            Vector3 offset = new Vector3(0f, 1.5f, 1.5f);
            transform.position = target.TransformPoint(offset);
            transform.rotation = target.rotation;
        }
        else if ((lookAt == false) && (check == true))
        {
            Vector3 offset = new Vector3(0f, 1.5f, -1.5f);
            transform.position = target.TransformPoint(offset);

            Vector3 targetRotation = target.rotation.eulerAngles;
            Vector3 transformRotation = new Vector3(targetRotation.x, targetRotation.y + 180, targetRotation.z);
            transform.rotation = Quaternion.Euler(transformRotation);
        }
        else
        {
            Debug.Log("ERROR: No other options for camera view in CameraFollow script!");
        }      
    }
}