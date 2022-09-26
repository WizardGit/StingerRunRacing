/* Created by Kaiser Slocum
 * Last Edited on 9/20/2022 by Kaiser Slocum
 * Purpose: To constantly modify the camera's positioning on the object
 */

using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

public class CameraFollow : MonoBehaviour
{
    public GameObject models;
    private GameObject targetObject;

    public Vector3 offsetPosition;
    public Vector3 tmpOffsetPos;
    public Vector3 tmpOffsetPos2;
    public Vector3 offsetRotation;

    public bool lookAt = true;
    public bool lookForward = true;

    private float yLookFrom = 0.0f;
    private float zLookFrom = 0.0f;
    public float slerpNum = 1.0f;
    public bool isShake = false;
    public float shakePower = 0.2f;
    private void Start()
    {
        UserSave usersave = new UserSave(NameTransfer.theName);
        // Get our target
        for (int i = 0; i < usersave.dragons.Count; i++)
        {
            if (usersave.dragons[i].GetUse() == "Using")
            {
                targetObject = models.transform.GetChild(i).gameObject;
                yLookFrom = usersave.dragons[i].GetYLookFrom();
                zLookFrom = usersave.dragons[i].GetZLookFrom();
                break;
            }
        }
        
        tmpOffsetPos = offsetPosition;
        tmpOffsetPos2 = offsetPosition;
        tmpOffsetPos.x = 7;
        tmpOffsetPos.z = 0;
        tmpOffsetPos.y = tmpOffsetPos.y + 10f;
        offsetPosition.y = offsetPosition.y + 20f;
        offsetPosition.z = offsetPosition.z + 10f;        
        
        StartSwerve();
    }

    private void FixedUpdate()
    {
            FollowPlayer();
    }

    private void FollowPlayer()
    {
        if (Vector3.Angle(offsetPosition, tmpOffsetPos) < 4)
            tmpOffsetPos = tmpOffsetPos2;
        offsetPosition = Vector3.Slerp(offsetPosition, tmpOffsetPos, slerpNum * Time.deltaTime);

        // If we want to look at our dragon...
        if (lookAt == true)
        {
            // Get where our camera needs to be
            transform.position = targetObject.transform.TransformPoint(offsetPosition);

            // Calculate the angle that our gcamera needs to be at
            Quaternion lookRotation = Quaternion.LookRotation(targetObject.transform.position - transform.position);
            // Add in our offset values
            Vector3 transformRotation = new Vector3(lookRotation.eulerAngles.x - offsetRotation.x,
                                                    lookRotation.eulerAngles.y - offsetRotation.y,
                                                    lookRotation.eulerAngles.z - offsetRotation.z);
            // 'Smoothly' rotate towards our target camera point
            transform.rotation = Quaternion.Euler(transformRotation);
        }
        // Else if we want to "be" our dragon...
        else if (lookAt == false)
        {
            if (lookForward == true)
            {
                transform.position = targetObject.transform.TransformPoint(new Vector3(0, yLookFrom, zLookFrom));
                transform.rotation = targetObject.transform.rotation;
            }
            else if (lookForward == false)
            {
                transform.position = targetObject.transform.TransformPoint(new Vector3(0, yLookFrom, -zLookFrom));
                Vector3 targetRotation = targetObject.transform.rotation.eulerAngles;
                transform.rotation = Quaternion.Euler(new Vector3(targetRotation.x, targetRotation.y + 180, targetRotation.z));
            }
        }
        if (isShake == true)
        {
            float xAmount = Random.Range(-1f, 1f) * shakePower;
            float yAmount = Random.Range(-1f, 1f) * shakePower;
            transform.position += new Vector3(xAmount, yAmount, 0f);
        }
    }

    private void StartSwerve()
    {
        // Get where our camera needs to be
        transform.position = targetObject.transform.TransformPoint(offsetPosition);

        // Calculate the angle that our gcamera needs to be at
        Quaternion lookRotation = Quaternion.LookRotation(targetObject.transform.position - transform.position);
        // Add in our offset values
        Vector3 transformRotation = new Vector3(lookRotation.eulerAngles.x - offsetRotation.x,
                                                lookRotation.eulerAngles.y - offsetRotation.y,
                                                lookRotation.eulerAngles.z - offsetRotation.z);
        // 'Smoothly' rotate towards our target camera point
        transform.rotation = Quaternion.Euler(transformRotation);

        // If we're looking at the object, we need to get in front of it (so we'll reverse our z offset
        

    }
}