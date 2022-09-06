using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class QuestDirectionScript : MonoBehaviour
{
    public Camera mainCamera;    

    // Update is called once per frame
    void FixedUpdate()
    {
        transform.up = mainCamera.transform.position - transform.position;
        transform.forward = -mainCamera.transform.up;
    }
}
