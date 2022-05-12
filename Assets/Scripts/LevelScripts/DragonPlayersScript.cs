using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DragonPlayersScript : MonoBehaviour
{
    
    // Start is called before the first frame update
    void Start()
    {
        UserSave usersave = new UserSave(NameTransfer.theName);

        // Load the correct dragon!
        for (int i = 0; i < usersave.dragons.Count; i++)
        {
            if (usersave.dragons[i].GetUse() == "Using")
            {
                for (int j = 0; j < gameObject.transform.childCount; j++)
                {
                    if (j == i)
                        gameObject.transform.GetChild(j).gameObject.SetActive(true);
                }
            }
        }        
    }
}
