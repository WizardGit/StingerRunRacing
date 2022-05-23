/*
 * Author: Kaiser Slocum
 * Last Modified: 5/22/2022
 */

using System;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.Serialization.Formatters.Binary;
using System.IO;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.InputSystem;
using TMPro;
using UnityEngine.SceneManagement;

public class PlayerController : MonoBehaviour
{
    // Variables for keeping the time
    private float time = 0.0f;
    private float countdown = 0.0f;
    private float boostTimer = 0.0f;
    public float boostTimeLength = 10f;
    public List<Material> materials;
    public Image speedBar;
    // Dictates if the player is allowed to move
    private bool isPause = false;
    private bool isStart = true;
    // Dictates if the player is on the Terrain
    private bool onTerrain = true;
    // Dictates how many checkpoints there are
    private int numCheckpoints;
    // Dictates how many checkpoints the user has hit
    public int checkpointsReached = 0;
    public float disToCheckpoint = 0.0f;
    public GameObject checkpoints;
    public TextMeshProUGUI distanceText;
    public GameObject finishLine;
    // Leaderboard parent object
    public GameObject ledBoard;
    public GameObject pauseMenu;
    // Camera Variables
    public GameObject mainCamera;
    private CameraFollow cf;
    // Dictates the name of the player
    private string username;
    // These variables hold the animation title for the speedstinger
    private string animationRun = "Run";
    private string animationIdle = "IdleHappy";
    private string animationLeft = "WalkLeft";
    private string animationRight = "WalkRight";

    // Movement variables
    private float playerRotationSpeed;
    private float playerSpeed;
    private float playerAcceleration;
    private float playerMaxSpeed;
    private float speedBoostMultiplier = 1.5f;
    private float jumpForce;  

    // Movement variables
    private float movementX;
    private float movementY;
    // Dictates the last checkpoint that the player will reset to if it falls out of the map
    private Vector3 resetPos;
    private UserSave usersave;
    private LeaderboardSave ledsave;

    // Object variables
    private Animation animator;
    private Rigidbody rb;
    private AudioSource audioRoar;

    // Text variables
    public TextMeshProUGUI timeText;
    public TextMeshProUGUI messageText;

    // Variables for raycasting
    private float maxDistCast = 0.1f;
    private float radius = 0.2f;

    void Start()
    {
        numCheckpoints = checkpoints.transform.childCount;

        string theName = NameTransfer.theName;
        if (theName != null)
        {
            username = theName;
            Debug.Log("Username is " + username);            
        }
        else
            Debug.Log("ERROR: no username!");

        // Load/Create a new file for this user!
        usersave = new UserSave(username);
        ledsave = new LeaderboardSave();
        ledBoard.SetActive(false);

        // Load the correct dragon!
        int modelToUse = 0;
        for (int i = 0; i < usersave.dragons.Count; i++)
        {
            if (usersave.dragons[i].GetName() == gameObject.name)
                modelToUse = i;            
        }       
        
        // Load the correct skin!
        for (int i = 0; i < usersave.dragons[modelToUse].GetSkinsLength(); i++)
        {
            if (usersave.dragons[modelToUse].GetSkin(i) == "Using")
            {
                gameObject.transform.GetChild(0).gameObject.GetComponent<Renderer>().material = materials[i];
            }
        }        

        animator = GetComponent<Animation>();
        rb = GetComponent<Rigidbody>();
        cf = mainCamera.GetComponent<CameraFollow>();
        audioRoar = GetComponent<AudioSource>();               

        timeText.text = "Time: 0";
        resetPos = new Vector3(1737f, 107.79f, 1534f);       

        playerRotationSpeed = usersave.dragons[modelToUse].GetTurnSpeed();
        playerMaxSpeed = usersave.dragons[modelToUse].GetSpeedForce();
        speedBoostMultiplier = 1.5f;
        jumpForce = usersave.dragons[modelToUse].GetJumpForce();
        maxDistCast = usersave.dragons[modelToUse].GetMaxDistCast();
        radius = usersave.dragons[modelToUse].GetRadius();
        playerAcceleration = usersave.dragons[modelToUse].GetAccelForce();

        speedBar.fillAmount = 0.2f;
    }    

    private void FixedUpdate()
    {
        CalcNextCheckpoint();
        // This code is vital for keeping the dragon rotated with the terrain
        RaycastHit hit;        
        Physics.Raycast(transform.position, transform.TransformDirection(Vector3.forward), out hit, 1f);
        //Debug.Log(hit.normal.ToString());

        if (Physics.SphereCast(transform.position, radius, -(transform.up), out hit, maxDistCast))
        {
            //rb.MoveRotation(Quaternion.LookRotation(Vector3.Cross(transform.right, hit.normal)));
            //Debug.Log(hit.normal.ToString());
            rb.MoveRotation(Quaternion.Slerp(transform.rotation, Quaternion.LookRotation(Vector3.Cross(transform.right, hit.normal)), 4 * Time.deltaTime));
        }

        if (rb.position.y <= 0)
        {
            OnRespawn();
        }
        else if (((time - boostTimer) > 2f) && (boostTimer > 0))
        {
            messageText.text = "";
        }

        if (isStart == true)
        {
            countdown += Time.deltaTime;
            messageText.text = (3-MathF.Truncate(countdown)).ToString();
            if (isPause == false)
            {
                isPause = true;
            }
            if (countdown >= 3f)
            {
                isStart = false;
                isPause = false;
                messageText.text = "<size=200%> GO!";
            }            
        }
        else if (isPause == false)
        {
            time += Time.deltaTime;
            float minutes = MathF.Truncate(time / 60);
            float seconds = MathF.Round(time - (minutes * 60),2);
            timeText.text = "Time: " + minutes + "." + seconds;            
            Move();

            if ((messageText.text == "<size=200%> GO!") && (time > 3))
            {
                messageText.text = "";
            }            
        }  
        else if (isPause == true)
        {
            if (checkpointsReached != numCheckpoints)
                isPause = PauseMenu.isPaused;
        }
    }

    private void Move()
    {        
        // Animations - but only play if we're on ground
        if (onTerrain == true)
        {
            if (movementX > 0.0f)
                animator.Play(animationRight);
            else if (movementX < 0.0f)
                animator.Play(animationLeft);
            else if ((!Mathf.Approximately(movementY, 0f) || !Mathf.Approximately(movementX, 0f)) && (onTerrain == true))
                animator.Play(animationRun);
            else
            {
                // The shoot-fireball animation should not be interrupted by animationIdle
                if (animator.IsPlaying("FlyAttackAdd") == false)
                    animator.Play(animationIdle);
            }
        }        

        if ((!Mathf.Approximately(movementY, 0f) || !Mathf.Approximately(movementX, 0f)) && (playerSpeed < playerMaxSpeed))
        {
            playerSpeed += playerAcceleration * Time.deltaTime;            

            if (((time - boostTimer) > boostTimeLength) && (boostTimer > 0))
                boostTimer = 0;
            else if (((time - boostTimer) < boostTimeLength) && (boostTimer > 0))
                playerSpeed = playerSpeed * speedBoostMultiplier;
        }
        else if (Mathf.Approximately(movementY, 0f) && Mathf.Approximately(movementX, 0f))
        {
            playerSpeed = 0f;
        }

        if (!Mathf.Approximately(movementY, 0f))
            speedBar.fillAmount = playerSpeed/playerMaxSpeed;
        else
            speedBar.fillAmount = 0.1f;

        // We can use transform instead of rigidbody
        //transform.Translate(0, 0, movementY * playerSpeed * Time.deltaTime);
        //transform.Rotate(0, movementX * playerRotationSpeed * Time.deltaTime, 0);

        // Move our rigid body's rotation
        Vector3 vecRotation = new Vector3(0, playerRotationSpeed, 0);
        Quaternion deltaRotation = Quaternion.Euler(movementX * vecRotation * Time.deltaTime);
        rb.MoveRotation(rb.rotation * deltaRotation);

        // If the player is backing up, they shouldn't be able to go all that fast!
        if (movementY < 0)
        {
            rb.MovePosition(rb.position + transform.forward * (playerSpeed/2) * movementY * Time.deltaTime);
        }
        else
        {
            rb.MovePosition(rb.position + transform.forward * playerSpeed * movementY * Time.deltaTime);
        }        
    }
    private void OnTriggerEnter(Collider other)
    {
        if ((other.gameObject.CompareTag("RingTarget")) && (other.gameObject.GetComponent<MeshRenderer>().material.color == Color.green))
        {
            // Set our reset position to this newest checkpoint
            resetPos = other.gameObject.transform.position;
            // Get rid of the target
            other.gameObject.SetActive(false);
            checkpointsReached++;            
        }
        else if (other.gameObject.CompareTag("FlyingBox"))
        {
            other.gameObject.SetActive(false);
            messageText.text = "<size=200%> Double Speed!";
            boostTimer = time;
            audioRoar.Play();
        }
        else if ((other.gameObject.CompareTag("Finish")) && (checkpointsReached == numCheckpoints))
        {
            Debug.Log("finish!");
            isPause = true;
            animator.Play(animationIdle);
            messageText.text = "";
            timeText.text = "";            
            other.gameObject.SetActive(false);

            string sName = SceneManager.GetActiveScene().name;
            int levelNum = 0;
            if (sName == "LevelOne")
            {
                levelNum = 1;
                if ((time < usersave.levelOneTime) || (usersave.levelOneTime < 0))
                    usersave.levelOneTime = time;
            }
            else if (sName == "LevelTwo")
            {
                levelNum = 2;
                if ((time < usersave.levelTwoTime) || (usersave.levelTwoTime < 0))
                    usersave.levelTwoTime = time;
            }
            else if (sName == "LevelThree")
            {
                levelNum = 3;
                if ((time < usersave.levelThreeTime) || (usersave.levelThreeTime < 0))
                    usersave.levelThreeTime = time;
            }
            else
            {
                Debug.Log("Scene name unrecognized in player controller!");
            }

            usersave.SaveUser();
            ledsave.SaveTime(levelNum, username, time);
            ledBoard.transform.GetChild(0).gameObject.GetComponent<TextMeshProUGUI>().text = username + ": " + MathF.Round(time, 3);
            ledBoard.transform.GetChild(1).gameObject.GetComponent<TextMeshProUGUI>().text = ledsave.getLeaderboard(levelNum);

            ledBoard.SetActive(true);
        }        
    }

    // As long as we have a collision, we are "on the terrain"
    private void OnCollisionEnter(Collision theCollision)
    {
        onTerrain = true;
        if (theCollision.gameObject.CompareTag("Water"))
        {
            // We are in water, so switch our animations
            animationRun = "Swim";
            animationIdle = "SwimIdle";
            animationLeft = "Swim";
            animationRight = "Swim";
        }       
    }
    // As long as we have exited a collision, we must be "in the air"
    private void OnCollisionExit(Collision theCollision)
    {
        if (theCollision.gameObject.CompareTag("Water"))
        {
            // We are exiting the water, so switch our animations
            animationRun = "Run";
            animationIdle = "IdleHappy";
            animationLeft = "WalkLeft";
            animationRight = "WalkRight";
        }
    }
    // Some extra Key Bindings
    private void OnMove(InputValue movementValue)
    {
        Vector2 movementXY = movementValue.Get<Vector2>().normalized;
        movementX = movementXY.x;
        movementY = movementXY.y;
    }
    private void OnJump()
    {
        if ((onTerrain == true) && (isPause == false))
        {
            Vector3 jump = new Vector3(movementX, jumpForce, movementY);
            rb.AddForce(jump);
            onTerrain = false;
            animator.Play("Jump01");            
        }
    }
    private void OnRespawn()
    {
        rb.MovePosition(resetPos);
    }
    private void OnLookAt()
    {       
        cf.lookAt = !cf.lookAt;
    }
    private void OnFrontView()
    {
        // If we're looking at the object, we need to get in front of it (so we'll reverse our z offset
        cf.lookForward = !cf.lookForward;
        cf.offsetPosition.z = cf.offsetPosition.z * -1.0f;
    }
    private void OnPause()
    {
        // Note sure how to handle when a user releases a key so this is my workaround! User pushes once to get the pause menu, then pushes again to get out of it        
        isPause = !isPause;
        animator.Stop();
        PauseMenu men = pauseMenu.GetComponent<PauseMenu>();
        if (isPause == true)
        {
            men.PauseGame();
        }
        else
        {
            men.ResumeGame();
        }
    }
    private void OnRoar()
    {
        audioRoar.Play();
    }
    private void OnFire()
    {
        if (Mathf.Approximately(movementY, 0f) && Mathf.Approximately(movementX, 0f) && (animator.IsPlaying("FlyAttackAdd") == false))
        {
            animator.Play("FlyAttackAdd");
            gameObject.transform.GetChild(4).gameObject.GetComponent<ParticleSystem>().Play();
            OnRoar();
        }
    }

    private void CalcNextCheckpoint()
    {
        if ((finishLine.transform.GetChild(3).gameObject.activeSelf == true) && (checkpointsReached == numCheckpoints))
        {
            Vector3 disVec = finishLine.transform.GetChild(3).transform.position - gameObject.transform.position;
            disToCheckpoint = MathF.Abs(disVec.x) + MathF.Abs(disVec.y) + MathF.Abs(disVec.z);
            distanceText.text = "Next: " + MathF.Round(disToCheckpoint, 2).ToString();
        }
        else if ((finishLine.transform.GetChild(3).gameObject.activeSelf == false))
        {
            distanceText.text = "Next: 0";
        }
        else
        {
            for (int i = 0; i < checkpoints.transform.childCount; i++)
            {
                if (checkpoints.transform.GetChild(i).transform.GetChild(4).GetComponent<MeshRenderer>().material.color == Color.green)
                {
                    Vector3 disVec = checkpoints.transform.GetChild(i).transform.position - gameObject.transform.position;
                    disToCheckpoint = MathF.Abs(disVec.x) + MathF.Abs(disVec.y) + MathF.Abs(disVec.z);
                    distanceText.text = "Next: " + MathF.Round(disToCheckpoint, 2).ToString();
                }
            }
        }
    }
}
