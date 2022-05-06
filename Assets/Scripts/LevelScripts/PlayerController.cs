/*
 * Author: Kaiser Slocum
 * Last Modified: 5/6/2022
 */

using System;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.Serialization.Formatters.Binary;
using System.IO;
using UnityEngine;
using UnityEngine.InputSystem;
using TMPro;

public class PlayerController : MonoBehaviour
{
    // Variables for keeping the time
    private float time = 0.0f;
    private float countdown = 0.0f;
    private float boostTimer;
    public float boostTimeLength = 10f;
    // Dictates if the player is allowed to move
    private bool isPause = true;
    private bool isStart = true;
    // Dictates if the player is on the Terrain
    private bool onTerrain = false;
    // Dictates how many checkpoints there are
    public int numCheckpoints = 6;
    // Dictates how many checkpoints the user has hit
    private int checkpointsReached = 0;
    // Leaderboard parent object
    public GameObject ledBoard;
    public GameObject pauseMenu;
    // Camera Variables
    public GameObject mainCamera;
    private CameraFollow cf;
    // Dictates the name of the player
    public string username;
    // These variables hold the animation title for the speedstinger
    private string animationRun = "Run";
    private string animationIdle = "IdleHappy";
    private string animationLeft = "WalkLeft";
    private string animationRight = "WalkRight";

    // Movement variables
    private float playerRotationSpeed;
    private float playerSpeed;
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
    Animation animator;
    Rigidbody rb;

    // Text variables
    public TextMeshProUGUI timeText;
    public TextMeshProUGUI messageText;

    // Variables for raycasting
    private float maxDistCast = 0.1f;
    private float radius = 0.2f;

    void Start()
    {
        animator = GetComponent<Animation>();
        rb = GetComponent<Rigidbody>();
        cf = mainCamera.GetComponent<CameraFollow>();

        string theName = NameTransfer.theName;
        if (theName == null)
        {
            Debug.Log("ERROR: no username!");
        }
        else
        {
            username = theName;
            Debug.Log("Username is " + username);
        }        

        timeText.text = "Time: 0";
        resetPos = new Vector3(1737f, 107.79f, 1534f);

        // Load/Create a new file for this user!
        usersave = new UserSave(username);
        ledsave = new LeaderboardSave();
        ledBoard.SetActive(false);

        int modelToUse = 0;
        for (int i = 0; i < usersave.dragons.Count; i++)
        {
            if (usersave.dragons[i].GetUse() == true)
            {
                modelToUse = i;
                if (usersave.dragons[modelToUse].GetName() == gameObject.name)
                    gameObject.SetActive(true);
                else
                    gameObject.SetActive(false);
            }
        }

        playerRotationSpeed = usersave.dragons[modelToUse].GetTurnSpeed();
        playerSpeed = usersave.dragons[modelToUse].GetSpeedForce();
        speedBoostMultiplier = 1.5f;
        jumpForce = usersave.dragons[modelToUse].GetJumpForce();
        maxDistCast = usersave.dragons[modelToUse].GetMaxDistCast();
        radius = usersave.dragons[modelToUse].GetRadius();
    }    

    private void FixedUpdate()
    {
        // This code is vital for keeping the dragon rotated with the terrain
        RaycastHit hit;        
        Physics.Raycast(transform.position, transform.TransformDirection(Vector3.forward), out hit, 1f);
        //Debug.Log(hit.normal.ToString());

        if (Physics.SphereCast(transform.position, radius, -(transform.up), out hit, maxDistCast))
        {
            //rb.MoveRotation(Quaternion.LookRotation(Vector3.Cross(transform.right, hit.normal)));
            //Debug.Log(hit.normal.ToString());
            rb.MoveRotation(Quaternion.Slerp(transform.rotation, Quaternion.LookRotation(Vector3.Cross(transform.right, hit.normal)), 10 * Time.deltaTime));
        }

        if (rb.position.y <= 0)
        {
            OnRespawn();
        }
        if (((time - boostTimer) > boostTimeLength) && (boostTimer > 0))
        {
            playerSpeed = playerSpeed / speedBoostMultiplier;
            boostTimer = 0;
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
        // Animations
        if (movementX > 0.0f)
            animator.Play(animationRight);
        else if (movementX < 0.0f)
            animator.Play(animationLeft);
        else if (!Mathf.Approximately(movementY, 0f))
            animator.Play(animationRun);
        else
            animator.Play(animationIdle);

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
        else if (other.gameObject.CompareTag("Water"))
        {
            Debug.Log("Water");
        }
        else if (other.gameObject.CompareTag("FlyingBox"))
        {
            other.gameObject.SetActive(false);
            playerSpeed = playerSpeed * speedBoostMultiplier;
            messageText.text = "<size=200%> Double Speed!";
            boostTimer = time;
            //Maybe do random thing, we could do double jump?
        }
        else if ((other.gameObject.CompareTag("Finish")) && (checkpointsReached == numCheckpoints))
        {
            isPause = true;
            animator.Play(animationIdle);
            messageText.text = "";
            timeText.text = "";            
            other.gameObject.SetActive(false);            
            
            Debug.Log("Your time: " + time.ToString());
            Debug.Log("Your Best time: " + usersave.levelOneTime.ToString());
            if ((time < usersave.levelOneTime) || (usersave.levelOneTime < 0))
            {
                usersave.levelOneTime = time;
                usersave.SaveGame();                
            }
            ledsave.SaveTime(1, username, time);
            Debug.Log("Your Best time now: " + usersave.levelOneTime.ToString());

            GameObject text1 = ledBoard.transform.GetChild(0).gameObject;
            GameObject text2 = ledBoard.transform.GetChild(1).gameObject;
            text1.GetComponent<TextMeshProUGUI>().text = username + ": " + MathF.Round(time, 3);
            text2.GetComponent<TextMeshProUGUI>().text = ledsave.getLeaderboard(1);

            ledBoard.SetActive(true);
        }        
    }
    private void OnTriggerExit(Collider other)
    {
        Debug.Log("Exit water");
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
        onTerrain = false;
        
        if (theCollision.gameObject.CompareTag("Water"))
        {
            // We are exiting the water, so switch our animations
            animationRun = "Run";
            animationIdle = "IdleHappy";
            animationLeft = "WalkLeft";
            animationRight = "WalkRight";

            transform.Translate(0,1,0);
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
            animator.Play("Jump01");
        }
    }
    private void OnRespawn()
    {
        rb.MovePosition(resetPos);
    }
    private void OnLookAt()
    {
        CameraFollow cf = mainCamera.GetComponent<CameraFollow>();        
        cf.lookAt = !cf.lookAt;
    }
    private void OnFrontView()
    {        
        if (cf.lookAt == true)
        {
            // If we're looking at the object, we need to get in front of it (so we'll reverse our z offset
            cf.offsetPosition.z = cf.offsetPosition.z * -1.0f;
        }
        else
        {
            // We need to signal to Update method to rotate by 180 degrees
            cf.check = !cf.check;
        }
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
}