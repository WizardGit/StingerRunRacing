using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class NarwhalPod : MonoBehaviour
{
    //public NavMeshAgent navMeshAgent;
    public GameObject waypoints;

    private int onWaypoint = 0;
    public int podSpeed = 4;
    public float arriveThreshold = 0.2f;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void FixedUpdate()
    {
        Vector3 target = waypoints.transform.GetChild(onWaypoint).gameObject.transform.position;

        Vector3 direction = (target - transform.position).normalized;

        // Move
        transform.position += direction * podSpeed * Time.deltaTime;

        // Face direction (optional)
        if (direction != Vector3.zero)
        {
            Quaternion lookRot = Quaternion.LookRotation(direction);
            transform.rotation = Quaternion.Slerp(transform.rotation, lookRot, Time.deltaTime * 3f);
        }

        // Check arrival
        if (Vector3.Distance(transform.position, target) < arriveThreshold)
        {
            onWaypoint++;
            if (onWaypoint >= waypoints.transform.childCount)
                onWaypoint = 0;
        }
    }
}
