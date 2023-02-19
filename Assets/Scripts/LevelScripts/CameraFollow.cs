/*
 * Author: Kaiser Slocum
 * Last Modified: 2/19/2023
 * Purpose: To constantly modify the camera's positioning on the object
 */

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraFollow : MonoBehaviour
{
    [HideInInspector] public GameObject models;
    private GameObject targetObject;

    public Vector3 offsetPosition;
    public Vector3 tmpOffsetPos;
    public Vector3 tmpOffsetPos2;
    public Vector3 offsetRotation;

    [HideInInspector] public bool lookAt = true;
    [HideInInspector] public bool lookForward = true;

    private float yLookFrom = 0.0f;
    private float zLookFrom = 0.0f;
    public float slerpNum = 1.0f;    

    // Variables used for camera affects when theSave is accelerating
    public float shakePower = 0.2f;
    public float lagPower = 1.0f;
    [HideInInspector] public bool isAccel = false;
    private bool canShake = false;
    private bool canLag = false;
    private int count = 0;
    private void Start()
    {
        models = GameObject.FindGameObjectWithTag("DragonPlayers");
        UserSave usersave = new(NameTransfer.theName);
        canShake = usersave.screenShake;
        canLag = usersave.cameraLag;
        Debug.Log(canLag);
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
        tmpOffsetPos.y += 10f;
        offsetPosition.y += 20f;
        offsetPosition.z += 10f;        
        
        StartSwerve();
    }

    private void FixedUpdate()
    {
        FollowPlayer();
    }

    private void FollowPlayer()
    {
        if ((lookForward == true) && (count < 2))
        {

            if (Vector3.Angle(offsetPosition, tmpOffsetPos) < 4)
            {
                count++;
                tmpOffsetPos = tmpOffsetPos2;
            }

            offsetPosition = Vector3.Slerp(offsetPosition, tmpOffsetPos, slerpNum * Time.deltaTime);

            if (count >= 2)
                offsetPosition = tmpOffsetPos;
        }
        

        // If we want to look at our dragon...
        if (lookAt == true)
        {
            // Get where our camera needs to be
            if ((isAccel == true) && (canLag == true))
                transform.position = Vector3.Slerp(transform.position, targetObject.transform.TransformPoint(offsetPosition), lagPower * Time.deltaTime);
            else if ((isAccel == false) && (canLag == true))
                transform.position = Vector3.Slerp(transform.position, targetObject.transform.TransformPoint(offsetPosition), lagPower * 6 * Time.deltaTime);
            else
                transform.position = targetObject.transform.TransformPoint(offsetPosition);

            // Calculate the angle that our gcamera needs to be at
            Quaternion lookRotation = Quaternion.LookRotation(targetObject.transform.position - transform.position);
            // Add in our offset values
            Vector3 transformRotation = new(lookRotation.eulerAngles.x - offsetRotation.x,
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
                if ((isAccel == true) && (canLag == true))
                    transform.position = Vector3.Slerp(transform.position, targetObject.transform.TransformPoint(new Vector3(0, yLookFrom, zLookFrom)), lagPower * Time.deltaTime);
                else if ((isAccel == false) && (canLag == true))
                    transform.position = Vector3.Slerp(transform.position, targetObject.transform.TransformPoint(new Vector3(0, yLookFrom, zLookFrom)), lagPower * 6 * Time.deltaTime);
                else
                    transform.position = targetObject.transform.TransformPoint(new Vector3(0, yLookFrom, zLookFrom));
                transform.rotation = targetObject.transform.rotation;
            }
            else if (lookForward == false)
            {
                if ((isAccel == true) && (canLag == true))
                    transform.position = Vector3.Slerp(transform.position, targetObject.transform.TransformPoint(new Vector3(0, yLookFrom, -zLookFrom)), lagPower * Time.deltaTime);
                else if ((isAccel == false) && (canLag == true))
                    transform.position = Vector3.Slerp(transform.position, targetObject.transform.TransformPoint(new Vector3(0, yLookFrom, -zLookFrom)), lagPower * 6 * Time.deltaTime);
                else
                    transform.position = targetObject.transform.TransformPoint(new Vector3(0, yLookFrom, -zLookFrom));
                Vector3 targetRotation = targetObject.transform.rotation.eulerAngles;
                transform.rotation = Quaternion.Euler(new Vector3(targetRotation.x, targetRotation.y + 180, targetRotation.z));
            }
        }
        if ((isAccel == true) && (canShake == true))
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
        Vector3 transformRotation = new(lookRotation.eulerAngles.x - offsetRotation.x,
                                                lookRotation.eulerAngles.y - offsetRotation.y,
                                                lookRotation.eulerAngles.z - offsetRotation.z);
        // 'Smoothly' rotate towards our target camera point
        transform.rotation = Quaternion.Euler(transformRotation); 
    }
}