/*
 * Author: Kaiser Slocum
 * Last Modified: 10/8/2022
 * Purpose: Controls player movements
 */

using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.InputSystem;
using TMPro;

public class PlayerController : MonoBehaviour
{
    // Variables for keeping the time
    private float boostTimer = 0.0f;
    public float boostTimeLength = 10f;
    public List<Material> materials;
    public Image speedBar;
    public TextMeshProUGUI speedText;
    // Dictates if the player is allowed to move
    private bool isPause = false;
    // Dictates if the player is on the Terrain
    private bool onTerrain = true;    

    // Dictates the name of the player
    [HideInInspector] public string username;
    private float time = 0.0f;
    // Dictates how many checkpoints the theSave has hit
    [HideInInspector] public int checkpointsReached = 0;
    [HideInInspector] public int lapsCompleted = 0;
    [HideInInspector] public float disToCheckpoint = 0.0f;
    // Dictates how many checkpoints there are
    public int numCheckpoints;
    public GameObject checkpoints;
    public TextMeshProUGUI distanceText;
    public GameObject finishLine;
    // Leaderboard parent object
    public GameObject ledBoard;
    public GameObject pauseMenu;
    // Camera Variables
    public GameObject mainCamera;
    private CameraFollow cf;    
    // These variables hold the animation title for the speedstinger
    private string animationRun = "Run";
    private string animationIdle = "IdleHappy";
    private string animationLeft = "WalkLeft";
    private string animationRight = "WalkRight";

    // Movement variables
    private float playerRotationSpeed = 200f;
    private float playerSpeed = 0;
    private float playerAcceleration = 0;
    public bool isAccelerating = false;
    private float playerMaxSpeed = 0;
    private float speedBoostMultiplier = 1.5f;
    private float jumpForce = 1000;  

    // Movement variables
    private float movementX = 0.0f;
    private float movementY = 0.0f;
    private float movementYBefore = 0.0f;
    // Dictates the last checkpoint that the player will reset to if it falls out of the map
    private Vector3 resetPos;
    private SaveGame theSave;

    // Object variables
    private Animation animator;
    private Rigidbody rb;
    private AudioSource audioRoar;

    // Text variables
    //public TextMeshProUGUI timeText;
    public TextMeshProUGUI messageText;    

    // Variables for raycasting
    private float maxDistCast = 0.1f;
    private float radius = 0.2f;

    private PlacementScript placScript;
    private CheckpointsScript checkpointScript;
    private PowerUpsScript powerUpsScript;

    void Start()
    {
        numCheckpoints = checkpoints.transform.childCount;

        string theName = NameTransfer.theName;
        if (theName != null)
            username = theName;
        else
            Debug.Log("ERROR: no username!");

        // Load/Create a new file for this theSave!
        theSave = GameObject.Find("SaveGameObject").GetComponent<SaveGame>();
        powerUpsScript = GameObject.Find("Powerups").GetComponent<PowerUpsScript>();

        // Load the correct dragon!
        int modelToUse = theSave.userSave.IndexOfDragonInUse();

        // Load the correct skin!
        for (int i = 0; i < theSave.userSave.dragons[modelToUse].GetSkinsLength(); i++)
        {
            if (theSave.userSave.dragons[modelToUse].GetSkin(i) == "Using")
            {
                gameObject.transform.GetChild(0).gameObject.GetComponent<Renderer>().material = materials[i];
            }
        }        

        animator = GetComponent<Animation>();
        rb = GetComponent<Rigidbody>();
        cf = mainCamera.GetComponent<CameraFollow>();
        audioRoar = GetComponent<AudioSource>();               

        //timeText.text = "Time: 0";
        speedText.text = "0 mph";
        messageText.text = "";
        resetPos = transform.position;       

        playerRotationSpeed = theSave.userSave.dragons[modelToUse].GetTurnSpeed();
        playerMaxSpeed = theSave.userSave.dragons[modelToUse].GetSpeedForce();
        speedBoostMultiplier = 1.5f;
        jumpForce = theSave.userSave.dragons[modelToUse].GetJumpForce();
        maxDistCast = theSave.userSave.dragons[modelToUse].GetMaxDistCast();
        radius = theSave.userSave.dragons[modelToUse].GetRadius();
        playerAcceleration = theSave.userSave.dragons[modelToUse].GetAccelForce();

        speedBar.fillAmount = 0f;

        placScript = GameObject.Find("PlacementText").GetComponent<PlacementScript>();
        checkpointScript = GameObject.Find("Checkpoints").GetComponent<CheckpointsScript>();
    }    

    private void FixedUpdate()
    {
        time += Time.deltaTime;
        // This code is vital for keeping the dragon rotated with the terrain
        RaycastHit hit;        
        Physics.Raycast(transform.position, transform.TransformDirection(Vector3.forward), out hit, 1f);

        if (Physics.SphereCast(transform.position, radius, -(transform.up), out hit, maxDistCast))
        {
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

        if ((placScript.startTime <= 0) && (isPause == false))
        {           
            Move();
            // Don't bother calculating next checkpoint, if we aren't moving, there is nothing to calculate!
            if (playerSpeed > 0)
                CalcNextCheckpoint();
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
            else if ((!Mathf.Approximately(movementY, 0f) || !Mathf.Approximately(movementX, 0f) || (playerSpeed > 0)) && (onTerrain == true))
                animator.Play(animationRun);
            else
            {
                // The shoot-fireball animation should not be interrupted by animationIdle
                if (animator.IsPlaying("FlyAttackAdd") == false)
                    animator.Play(animationIdle);
            }
        }        

        if (!Mathf.Approximately(movementY, 0f) && (playerSpeed <= playerMaxSpeed))
        {
            // Check our player speed to see if we can add on more
            if ((playerSpeed + (playerAcceleration * Time.deltaTime)) > playerMaxSpeed)
            {
                playerSpeed = playerMaxSpeed;
                cf.GetComponent<CameraFollow>().isAccel = false;
            }                
            else if (onTerrain==true)
            {
                if (onTerrain == true)
                {
                    playerSpeed += playerAcceleration * Time.deltaTime;
                    cf.GetComponent<CameraFollow>().isAccel = true;
                }
            }                

            // If our boost time is done, reset our max speed
            if (((time - boostTimer) > boostTimeLength) && (boostTimer > 0) && (onTerrain == true))
            {
                boostTimer = 0;
                playerMaxSpeed = playerMaxSpeed / speedBoostMultiplier;
                if (playerMaxSpeed < 0)
                {
                    playerMaxSpeed = 0;
                    Debug.Log("Player Controller: We got curMaxSpeed < 0!");
                }

                cf.GetComponent<CameraFollow>().isAccel = false;
            }                
        }
        else if (((Mathf.Approximately(movementY, 0f) && (playerSpeed > 0)) || (playerSpeed > playerMaxSpeed)) && (onTerrain == true))
        {
            cf.GetComponent<CameraFollow>().isAccel = false;
            playerSpeed -= (playerAcceleration*2) * Time.deltaTime;
            if (playerSpeed < 0)
                playerSpeed = 0;
        }
        else
        {
            cf.GetComponent<CameraFollow>().isAccel = false;
        }

        speedBar.fillAmount = playerSpeed / playerMaxSpeed;
        speedText.text = MathF.Round(playerSpeed, 2).ToString() + " mph";

        // We can use transform instead of rigidbody
        //transform.Translate(0, 0, movementY * playerSpeed * Time.deltaTime);
        //transform.Rotate(0, movementX * playerRotationSpeed * Time.deltaTime, 0);

        // Move our rigid body's rotation
        Vector3 vecRotation = new Vector3(0, playerRotationSpeed, 0);
        Quaternion deltaRotation = Quaternion.Euler(movementX * vecRotation * Time.deltaTime);
        rb.MoveRotation(rb.rotation * deltaRotation);

        // If the player is backing up, they shouldn't be able to go all that fast!
        if (movementY < 0)
            rb.MovePosition(rb.position + transform.forward * (playerSpeed/2) * movementYBefore * Time.deltaTime);
        else
            rb.MovePosition(rb.position + transform.forward * playerSpeed * movementYBefore * Time.deltaTime);
    }
    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.CompareTag("RingTarget"))
        {
            // Set our reset position to this newest checkpoint
            resetPos = other.gameObject.transform.position;
            // Notify checkpoint script that we hit it! (Make sure to give it the INDEX of the checkpoint            
            if (checkpointScript.HitCheckpoint(other.gameObject.transform.parent.transform.GetSiblingIndex()) == true)
                checkpointsReached++;
        }
        else if (other.gameObject.CompareTag("FlyingBox"))
        {
            other.gameObject.SetActive(false);
            messageText.text = "<size=200%> Double Speed!";
            boostTimer = time;
            playerMaxSpeed *= speedBoostMultiplier;
            audioRoar.Play();
        }
        else if (other.gameObject.CompareTag("Sheep"))
        {
            other.gameObject.SetActive(false);
            theSave.userSave.numSheep += 1;
            theSave.userSave.SaveUser();
        }
        else if (other.gameObject.CompareTag("Finish"))
        {
            resetPos = other.gameObject.transform.position;
            if (checkpointScript.HitCheckpoint(other.gameObject.transform.parent.transform.GetSiblingIndex()) == true)
            {
                checkpointsReached++;
                lapsCompleted++;
                powerUpsScript.ResetCheckpoints();
                if (placScript.numLaps == lapsCompleted)
                {
                    isPause = true;
                    animator.Play(animationIdle);
                    messageText.text = "";
                    speedText.text = "0 mph";
                    speedBar.fillAmount = 0;
                    distanceText.text = "Next: 0";
                }                
            }    
        }
        else if (other.gameObject.CompareTag("CatapultArm"))
        {
            transform.position = resetPos; 
            audioRoar.Play();
        }
    }

    // As long as we have a collision, we are "on the terrain"
    private void OnCollisionEnter(Collision theCollision)
    {
        onTerrain = true;
        if (theCollision.gameObject.CompareTag("Water"))
        {
            playerMaxSpeed /=  2;
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
            playerMaxSpeed *= 2;
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
        if (!Mathf.Approximately(movementY, 0f))
            movementYBefore = movementY;
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
       if (placScript.startTime <= 0)
            cf.lookAt = !cf.lookAt;
    }
    private void OnFrontView()
    {
        if (placScript.startTime <= 0)
        {
            // If we're looking at the object, we need to get in front of it (so we'll reverse our z offset
            cf.lookForward = !cf.lookForward;
            cf.offsetPosition.z = cf.offsetPosition.z * -1.0f;
        }        
    }
    private void OnPause()
    {
        // Note sure how to handle when a theSave releases a key so this is my workaround! User pushes once to get the pause menu, then pushes again to get out of it
        // 
        if (ledBoard.activeSelf == false)
        {
            isPause = !isPause;
            animator.Stop();
            PauseMenu men = pauseMenu.GetComponent<PauseMenu>();
            if (isPause == true)
                men.PauseGame();
            else
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
        if ((finishLine.transform.GetChild(3).gameObject.activeSelf == false))
        {
            distanceText.text = "Next: 0";
        }
        else
        {
            Transform cp = checkpoints.transform.GetChild(checkpointsReached - (numCheckpoints*lapsCompleted)).transform;

            if ((cp.gameObject.tag == "Checkpoint") || (cp.gameObject.tag == "FinishLine"))
            {
                Vector3 disVec = cp.position - gameObject.transform.position;
                disToCheckpoint = MathF.Abs(disVec.x) + MathF.Abs(disVec.y) + MathF.Abs(disVec.z);
                distanceText.text = "Next: " + MathF.Round(disToCheckpoint, 2).ToString();
            }
            else
            {
                Debug.Log("PlayerController - Checkpoint Fail!");
            }
        }
    }
}
