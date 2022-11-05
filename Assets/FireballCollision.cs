using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FireballCollision : MonoBehaviour
{
    private ParticleSystem PSystem;
    private List<ParticleCollisionEvent> CollisionEvents;
    private AudioSource tada;

    // Start is called before the first frame update
    void Start()
    {
        tada = GetComponent<AudioSource>();
        CollisionEvents = new List<ParticleCollisionEvent>();
        PSystem = GetComponent<ParticleSystem>();
    }

    // Update is called once per frame
    void Update()
    {
        
    }
    public void OnParticleCollision(GameObject other)
    {
        Debug.Log("// " + other.tag + " //");
        int collCount = PSystem.GetSafeCollisionEventSize();

        if (collCount > CollisionEvents.Count)
            CollisionEvents = new List<ParticleCollisionEvent>();

        int eventCount = PSystem.GetCollisionEvents(other, CollisionEvents);

        for (int i = 0; i < eventCount; i++)
        {
            if (other.CompareTag("NPCRacer") == true)
                tada.Play();
            Debug.Log("// " + other.tag + " //");

            //TODO: Do your collision stuff here. 
            // You can access the CollisionEvent[i] to obtaion point of intersection, normals that kind of thing
            // You can simply use "other" GameObject to access it's rigidbody to apply force, or check if it implements a class that takes damage or whatever
        }
    }
}
