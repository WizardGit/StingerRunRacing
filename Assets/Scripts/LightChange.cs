/*
 * Author: Kaiser Slocum
 * Last Modified: 9/25/2022
 */

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LightChange : MonoBehaviour
{
    private List<Color> colors;
    private float time = 0.0f;
    private int colorI = 0;
    private Light theLight;

    // Start is called before the first frame update
    void Start()
    {
        colors = new List<Color>();
        colors.Add(Color.green);
        colors.Add(Color.red);
        colors.Add(Color.blue);
        colors.Add(Color.yellow);
        colors.Add(Color.cyan);
        colors.Add(Color.magenta);
        colors.Add(Color.white);
        colors.Add(Color.gray);
        theLight = gameObject.transform.GetComponent<Light>();
    }

    // Update is called once per frame
    void FixedUpdate()
    {
        time += Time.deltaTime;
        if (time >= 3)
        {
            theLight.color = colors[colorI++];
            time = 0.0f;
            if (colorI == colors.Count-1)
            {
                colorI = 0;
            }
        }
    }
}
