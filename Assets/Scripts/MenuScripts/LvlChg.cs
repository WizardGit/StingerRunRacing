using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;

public class LvlChg : MonoBehaviour
{
    public TextMeshProUGUI display;
    private LeaderboardSave ledsave;

    private void Start()
    {
        ledsave = new LeaderboardSave();
        display.text = ledsave.GetLeaderboard(1);
    }

    public void OnValueChanged()
    {        
        display.text = ledsave.GetLeaderboard((transform.GetComponent<TMP_Dropdown>().value)+1);
    }
}
