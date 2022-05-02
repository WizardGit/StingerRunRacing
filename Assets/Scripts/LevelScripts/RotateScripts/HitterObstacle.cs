using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HitterObstacle : MonoBehaviour
{
    void Update()
    {
        transform.Rotate(new Vector3(200, 0, 0) * Time.deltaTime);
    }
}
