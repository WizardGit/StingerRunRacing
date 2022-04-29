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

    private bool check = false;

    private void OnFrontView()
    {
        if (lookAt)
        {
            // If we're looking at the object, we need to get in front of it (so we'll reverse our z offset
            offsetPosition.z = offsetPosition.z * -1.0f;
        }  
        else
        {
            // We need to signal to Update method to rotate by 180 degrees
            check = !check;
        }
    }

    private void FixedUpdate()
    {                
        // If we want to look at our dragon...
        if (lookAt)
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
            transform.rotation = Quaternion.Slerp(transform.rotation, Quaternion.Euler(transformRotation), 30* Time.deltaTime);
        }
        // Else if we want to "be" our dragon...
        else
        {
            if (check)
            {
                // The camera needs to be in our object but rotated by 180 degrees
                // This is leftover code from when we could use 'tab' to change view
                Vector3 targetRotation = target.rotation.eulerAngles;
                Vector3 transformRotation = new Vector3(targetRotation.x, targetRotation.y + 180, targetRotation.z);
                transform.rotation = Quaternion.Euler(transformRotation);
            }
            else
            {
                Vector3 offset = new Vector3(0f, 1.5f, 1.5f);
                transform.position = target.TransformPoint(offset);
                transform.rotation = target.rotation;
            }            
        }            
    }
}