using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PropellerController : MonoBehaviour
{
    public GameObject boxPropeller;

    void FixedUpdate()
    {
        boxPropeller.transform.Rotate(new Vector3(0, 200, 0) * Time.deltaTime);
    }
}
