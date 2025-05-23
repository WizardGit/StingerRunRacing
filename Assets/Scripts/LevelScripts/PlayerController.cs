/*
 * Author: Kaiser Slocum
 * Last Modified: 5/22/2025
 * Purpose: Controls player movements
 */

using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.InputSystem;
using TMPro;

public class PlayerController : MonoBehaviour
{
    // Variables for keeping the time
    [HideInInspector] public float boostTimer = 0.0f;
    [HideInInspector] public float boostTimeLength = 10f;
    // Objects that need to be assigned in the scene
    public List<Material> materials;
    [HideInInspector] public Image speedBar;
    [HideInInspector] public TextMeshProUGUI speedText;
    [HideInInspector] public PauseMenu pauseMenu;
    [HideInInspector] public Camera mainCamera;
    [HideInInspector] public CameraFollow cf;
    [HideInInspector] public Animator anim;
    // Dictates if the player is allowed to move
    [HideInInspector] public bool isPause = false;
    [HideInInspector] public bool canRun = false;
    // Variables for what kind of material the player is on
    public bool onTerrain = true;
    public bool inWater = false;
    public bool onWaterCube = false;

    // Dictates the name of the player
    [HideInInspector] public string username;
    [HideInInspector] public float time = 0.0f;   

    // Dragon stat variables that depends on the dragon's class stats
    private float playerRotationSpeed = 200f;
    [HideInInspector] public float playerSpeed = 0;
    private float playerAcceleration = 0;
    [HideInInspector] public bool isAccelerating = false;
    [HideInInspector] public float playerMaxSpeed = 0;
    [HideInInspector] public float origPlayerMaxSpeed = 0;
    [HideInInspector] public float playerMinOnWaterSpeed = 14;
    private float jumpForce = 1000;
    public int fireBallSpeed = 20;

    // Movement variables
    [HideInInspector] public float movementX = 0.0f;
    [HideInInspector] public float movementY = 0.0f;
    private float movementYBefore = 0.0f;
    // Dictates the last checkpoint that the player will reset to if it falls out of the map
    [HideInInspector] public Vector3 resetPos;
    // The object that holds the save file for the user
    private SaveGame theSave;

    // Object variables
    private Rigidbody rb;
    private AudioSource audioRoar;

    // Text variables
    [HideInInspector] public TextMeshProUGUI messageText;    

    // Variables for raycasting
    private float maxDistCast = 0.1f;
    private float radius = 0.2f;

    // Water Box variables
    private float waterPos;
    public float dragonWaterHeight;

    void Start()
    {
        string theName = NameTransfer.theName;
        if (theName != null)
            username = theName;
        else
            Debug.Log("ERROR: no username!");

        // Load/Create a new file for this theSave!
        theSave = GameObject.Find("SaveGameObject").GetComponent<SaveGame>();
        
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

        waterPos = GameObject.FindGameObjectWithTag("Water").gameObject.transform.position.y;

        rb = GetComponent<Rigidbody>();
        cf = mainCamera.GetComponent<CameraFollow>();
        audioRoar = GetComponent<AudioSource>();
        anim = GetComponent<Animator>();
        mainCamera = GameObject.FindGameObjectWithTag("MainCamera").GetComponent<Camera>();
        speedBar = GameObject.FindGameObjectWithTag("SpeedBar").GetComponent<Image>();
        speedText = GameObject.FindGameObjectWithTag("SpeedText").GetComponent<TextMeshProUGUI>();
        pauseMenu = GameObject.FindGameObjectWithTag("PauseMenu").GetComponent<PauseMenu>();
        messageText = GameObject.FindGameObjectWithTag("MessageText").GetComponent<TextMeshProUGUI>();

        speedText.text = "0 mph";
        speedBar.fillAmount = 0f;
        messageText.text = "";
        resetPos = transform.position;       

        playerRotationSpeed = theSave.userSave.dragons[modelToUse].GetTurnSpeed();
        playerMaxSpeed = theSave.userSave.dragons[modelToUse].GetSpeedForce() * (transform.localScale.x);
        origPlayerMaxSpeed = theSave.userSave.dragons[modelToUse].GetSpeedForce() * (transform.localScale.x);

        jumpForce = theSave.userSave.dragons[modelToUse].GetJumpForce();
        maxDistCast = theSave.userSave.dragons[modelToUse].GetMaxDistCast();
        radius = theSave.userSave.dragons[modelToUse].GetRadius();
        playerAcceleration = theSave.userSave.dragons[modelToUse].GetAccelForce() * (transform.localScale.x);   
        dragonWaterHeight = theSave.userSave.dragons[modelToUse].GetWaterHeight();

        SetAnimatorBool("isIdleHappy");
        // Set the fireball particle system to just go straight forward
        transform.GetChild(5).gameObject.transform.rotation = gameObject.transform.rotation;
    }    

    private void FixedUpdate()
    {
        time += Time.deltaTime;
        //Physics.Raycast(transform.position, transform.TransformDirection(Vector3.forward), out hit, 1f);
        // This code is vital for keeping the dragon rotated with the terrain
        if (Physics.SphereCast(transform.position, radius, -(transform.up), out RaycastHit hit, maxDistCast))
            rb.MoveRotation(Quaternion.Slerp(transform.rotation, Quaternion.LookRotation(Vector3.Cross(transform.right, hit.normal)), 4 * Time.deltaTime));

        // If the user falls under the map
        if (rb.position.y <= -2)
            OnRespawn();

        if (isPause == false)
            Move();
    }
    
    private void Move()
    {
        if (inWater == true)
        {
            if (playerSpeed < playerMinOnWaterSpeed)
            {
                ClampVelocity(waterPos - dragonWaterHeight);

                if (rb.position.y <= waterPos)
                {
                    if (playerSpeed > 0)
                        SetAnimatorBool("isSwim");
                    else
                        SetAnimatorBool("isSwimIdle");
                }                
            }
            else if (playerSpeed >= playerMinOnWaterSpeed)
            {
                Debug.Log("Clamp speed!");
                ClampVelocity(waterPos);
                SetAnimatorBool("isRun");
            }
        }     

        // Animations - but only play if we're on ground
        if (((onTerrain == true) && (inWater == false)) || ((inWater == true) && (playerSpeed >= playerMinOnWaterSpeed)))
        {    
            if (movementX > 0.0f)
                SetAnimatorBool("isTurnRight");
            else if (movementX < 0.0f)
                SetAnimatorBool("isTurnLeft");
            else if (!Mathf.Approximately(movementY, 0f) || !Mathf.Approximately(movementX, 0f) || (playerSpeed > 0))
                SetAnimatorBool("isRun");
            else
                SetAnimatorBool("isIdleHappy");
        }
        // &&((onTerrain==true) || (inWater==true))
        if (!Mathf.Approximately(movementY, 0f) && (playerSpeed <= playerMaxSpeed))
        {
            // Check our player speed to see if we can add on more
            if ((playerSpeed + (playerAcceleration * Time.deltaTime)) > playerMaxSpeed)
            {
                playerSpeed = playerMaxSpeed;
                cf.GetComponent<CameraFollow>().isAccel = false;
            }                
            else
            {
                playerSpeed += playerAcceleration * Time.deltaTime;
                cf.GetComponent<CameraFollow>().isAccel = true;
            }                
        }
        else
        {
            cf.GetComponent<CameraFollow>().isAccel = false;

            if (((Mathf.Approximately(movementY, 0f) && (playerSpeed > 0)) || (playerSpeed > playerMaxSpeed)) )
            {
                playerSpeed -= (playerAcceleration * 2) * Time.deltaTime;
                if (playerSpeed < 0)
                    playerSpeed = 0;
            }
        }

        speedBar.fillAmount = playerSpeed / playerMaxSpeed;
        speedText.text = MathF.Round(playerSpeed, 2).ToString() + " mph";

        // We can use transform instead of rigidbody
        //transform.Translate(0, 0, movementY * playerSpeed * Time.deltaTime);
        //transform.Rotate(0, movementX * playerRotationSpeed * Time.deltaTime, 0);

        // Move our rigid body's rotation
        Quaternion deltaRotation = Quaternion.Euler(movementX * Time.deltaTime * (new Vector3(0, playerRotationSpeed, 0)));
        rb.MoveRotation(rb.rotation * deltaRotation);

        // If the player is backing up, they shouldn't be able to go all that fast!
        if (movementY < 0)
            rb.MovePosition(rb.position + (playerSpeed/2) * movementYBefore * Time.deltaTime * transform.forward);
        else
            rb.MovePosition(rb.position + movementYBefore * playerSpeed * Time.deltaTime * transform.forward);
    }

    private void ClampVelocity(float heightPos)
    {        
        // Clamp Y position to minimum of heightPos
        if (rb.position.y < heightPos)
        {
            Vector3 velocity = rb.velocity;

            if (velocity.y < 0)
            {
                velocity.y = 0;
                rb.velocity = velocity;
            }
            rb.AddForce(-Physics.gravity * rb.mass);

            Vector3 pos = rb.position;
            pos.y = heightPos;
            rb.MovePosition(Vector3.Lerp(rb.position, pos, 0.05f));

            // Current rotation
            Quaternion currentRotation = rb.rotation;

            // Desired upright rotation: keep Y, zero out X and Z
            Vector3 currentEuler = currentRotation.eulerAngles;
            Quaternion targetRotation = Quaternion.Euler(0f, currentEuler.y, 0f);

            // Smoothly interpolate to upright rotation
            Quaternion newRotation = Quaternion.Slerp(currentRotation, targetRotation, Time.deltaTime * 4);

            rb.MoveRotation(newRotation);
        }
    }
    private void OnTriggerEnter(Collider triggerObj)
    {
        if (triggerObj.gameObject.CompareTag("Sheep"))
        {
            triggerObj.gameObject.SetActive(false);
            theSave.userSave.numSheep += 1;
            theSave.userSave.SaveUser();
        }        
        else if (triggerObj.gameObject.CompareTag("Water"))
        {
            Debug.Log("Water!");
            onTerrain = false;
            inWater = true;            
        }
    }

    private void OnTriggerExit(Collider triggerObj)
    {
        if (triggerObj.gameObject.CompareTag("Water"))
        {
            //Leave Water
            if (waterPos < rb.position.y)
                inWater = false;

            anim.SetBool("isSwim", false);
            anim.SetBool("isSwimIdle", false);
        }
    }

    // As long as we have a collision, we are "on the terrain"
    private void OnCollisionEnter(Collision collidingObj)
    {
        if ((collidingObj.gameObject.tag == "GroundTerrain") || (collidingObj.gameObject.layer == 3))
        {
            onTerrain = true;
            anim.SetBool("isJump", false);
        }
    }
    // As long as we have exited a collision, we must be "in the air"
    private void OnCollisionExit(Collision collidingObj)
    {
        Debug.Log(collidingObj.gameObject.name);
        if ((collidingObj.gameObject.tag == "GroundTerrain") || (collidingObj.gameObject.layer == 3))
            onTerrain = false;
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
        Debug.Log("OnTerrain: " + onTerrain);
        if ((onTerrain == true) && (isPause == false))
        {
            onTerrain = false;
            Vector3 jump = new(movementX, jumpForce, movementY);
            rb.AddForce(jump);            
            SetAnimatorBool("isJump");            
        }
        else if ((inWater == true) && (isPause == false) && (playerSpeed >= playerMinOnWaterSpeed))
        {
            onTerrain = false;
            Vector3 jump = new(movementX, jumpForce, movementY);
            rb.AddForce(jump);
            SetAnimatorBool("isJump");
        }
    }
    private void OnRespawn()
    {
        rb.MovePosition(resetPos);
    }
    private void OnLookAt()
    {
       if (isPause == false)
            cf.lookAt = !cf.lookAt;
    }
    private void OnFrontView()
    {
        if (isPause == false)
        {
            // If we're looking at the object, we need to get in front of it (so we'll reverse our z offset
            cf.lookForward = !cf.lookForward;
            cf.offsetPosition.z *= -1.0f;
        }        
    }
    public void CanStart(bool canStart)
    {
        canRun = canStart;
        if (canStart == true)
            isPause = false;
        else
            isPause = true;
    }
    private void OnPause()
    {
        // Note sure how to handle when a theSave releases a key so this is my workaround! User pushes once to get the pause menu, then pushes again to get out of it
        //If canRun is false that means the race has not started so certain action should not be run
        if (canRun == false)
            isPause = true;  
        else
            isPause = !isPause;
        //By directly referencing the pause menu's isPaused variable, I am decoupling if the pause menu is shown or not from the local isPause variable
        //Any time OnPause() is called we should always be toggling between the pause menu and no pause menu
        if (PauseMenu.isPaused == false)
            pauseMenu.PauseGame();
        else
            pauseMenu.ResumeGame();
    }
    public void OnRoar()
    {        
        if (audioRoar.isPlaying == false)
            audioRoar.Play();
    }
    
    private void OnFire()
    {
        if (audioRoar.isPlaying == false)
        {
            ParticleSystem fireBall = gameObject.transform.GetChild(5).gameObject.GetComponent<ParticleSystem>();
            ParticleSystem.MainModule fbMain = fireBall.main;
            fbMain.startSpeed = playerSpeed + fireBallSpeed;
            fireBall.Play();
            audioRoar.Play();
        }        
    }    

    public void SetAnimatorBool(string blnAnim)
    {
        // This works assuming that we don't directly set the bools anywhere else in the code...
        if (anim.GetBool(blnAnim) == false)
        {
            anim.SetBool("isJump", false);
            anim.SetBool("isSwimIdle", false);
            anim.SetBool("isSwim", false);
            anim.SetBool("isRun", false);
            anim.SetBool("isWalk", false);
            anim.SetBool("isTurnLeft", false);
            anim.SetBool("isTurnRight", false);
            anim.SetBool("isIdleHappy", false);
            anim.SetBool(blnAnim, true);
        }        
    }
}
