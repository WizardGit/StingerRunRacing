/* Created by Kaiser Slocum
 * Last Edited on 9/23/2022 by Kaiser Slocum
 * Purpose: To set off finish line fireworks once player runs over trigger
 */

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FireworkTrigger : MonoBehaviour
{
    public GameObject fireworksLeft;
    public GameObject fireworksRight;    

    public void StartFireworks()
    {
        fireworksLeft.SetActive(true);
        fireworksRight.SetActive(true);
    }
}
