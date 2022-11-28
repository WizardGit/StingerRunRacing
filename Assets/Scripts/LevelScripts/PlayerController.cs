/*
 * Author: Kaiser Slocum
 * Last Modified: 11/26/2022
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
    public Image speedBar;
    public TextMeshProUGUI speedText;
    public GameObject pauseMenu;
    public Camera mainCamera;
    [HideInInspector] public CameraFollow cf;
    [HideInInspector] public Animator anim;
    // Dictates if the player is allowed to move
    [HideInInspector] public bool isPause = false;
    // Variables for what kind of material the player is on
    public bool onTerrain = true;
    public bool inWater = false;
    // Describes if the speed reduction for being in water has been applied
    private bool waterBonusApp = false;

    // Dictates the name of the player
    [HideInInspector] public string username;
    [HideInInspector] public float time = 0.0f;   

    // Dragon stat variables that depends on the dragon's class stats
    private float playerRotationSpeed = 200f;
    [HideInInspector] public float playerSpeed = 0;
    private float playerAcceleration = 0;
    [HideInInspector] public bool isAccelerating = false;
    [HideInInspector] public float playerMaxSpeed = 0;
    [HideInInspector] public float playerMinOnWaterSpeed = 14;
    private float jumpForce = 1000;

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
    public TextMeshProUGUI messageText;    

    // Variables for raycasting
    private float maxDistCast = 0.1f;
    private float radius = 0.2f;

    // Water Box variables
    private GameObject waterBox;
    private float wbPos;
    private float wbWaterLvl;
    private float wbDragonSwimLvl;

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

        waterBox = GameObject.FindGameObjectWithTag("WaterCube");        
        if (waterBox != null)
        {
            wbPos = waterBox.transform.parent.gameObject.transform.position.y;
            wbWaterLvl = 2.1f;
            wbDragonSwimLvl = gameObject.GetComponent<CapsuleCollider>().height - 1.2f;
            waterBox.transform.position = new Vector3(waterBox.transform.position.x, wbPos - wbWaterLvl, waterBox.transform.position.z);
        }

        rb = GetComponent<Rigidbody>();
        cf = mainCamera.GetComponent<CameraFollow>();
        audioRoar = GetComponent<AudioSource>();
        anim = GetComponent<Animator>();

        //timeText.text = "Time: 0";
        speedText.text = "0 mph";
        speedBar.fillAmount = 0f;
        messageText.text = "";
        resetPos = transform.position;       

        playerRotationSpeed = theSave.userSave.dragons[modelToUse].GetTurnSpeed();
        playerMaxSpeed = theSave.userSave.dragons[modelToUse].GetSpeedForce() * (transform.localScale.x);
        
        jumpForce = theSave.userSave.dragons[modelToUse].GetJumpForce();
        maxDistCast = theSave.userSave.dragons[modelToUse].GetMaxDistCast();
        radius = theSave.userSave.dragons[modelToUse].GetRadius();
        playerAcceleration = theSave.userSave.dragons[modelToUse].GetAccelForce() * (transform.localScale.x);        

        SetAnimatorBool("isIdleHappy");
        // Set the fireball particle system to just go straight forward
        transform.GetChild(5).gameObject.transform.rotation = gameObject.transform.rotation;
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

        // If the user falls under the map
        if (rb.position.y <= 0)
        {
            OnRespawn();
        }

        if (isPause == false)
        {           
            Move();
        }        
    }
    
    private void Move()
    {
        if (inWater == true)
        {
            if (playerSpeed < playerMinOnWaterSpeed)
            {
                if (waterBonusApp == false)
                {
                    if (waterBox != null)
                        waterBox.transform.position = new Vector3(waterBox.transform.position.x, wbPos - wbDragonSwimLvl, waterBox.transform.position.z);
                    waterBonusApp = true;
                    playerMaxSpeed /= 2;
                }
                if (playerSpeed > 0)
                    SetAnimatorBool("isSwim");
                else
                    SetAnimatorBool("isSwimIdle");
            }
            else if ((playerSpeed >= playerMinOnWaterSpeed) && (waterBonusApp == true))
            {
                if (waterBox != null)
                    waterBox.transform.position = new Vector3(waterBox.transform.position.x, wbPos - wbWaterLvl, waterBox.transform.position.z);
                waterBonusApp = false;
                playerMaxSpeed *= 2;
                SetAnimatorBool("isRun");
            }
        }     
        else if (waterBox != null)
            waterBox.transform.position = new Vector3(waterBox.transform.position.x, wbPos - wbWaterLvl, waterBox.transform.position.z);

        // Animations - but only play if we're on ground
        if (((onTerrain == true) && (inWater == false)) || ((inWater == true) && (waterBonusApp == false)))
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

        if (!Mathf.Approximately(movementY, 0f) && (playerSpeed <= playerMaxSpeed) && ((onTerrain == true) || (inWater == true)))
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
            if (((Mathf.Approximately(movementY, 0f) && (playerSpeed > 0)) || (playerSpeed > playerMaxSpeed)) && ((onTerrain == true) || (inWater == true)))
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
        Quaternion deltaRotation = Quaternion.Euler(movementX * (new Vector3(0, playerRotationSpeed, 0)) * Time.deltaTime);
        rb.MoveRotation(rb.rotation * deltaRotation);

        // If the player is backing up, they shouldn't be able to go all that fast!
        if (movementY < 0)
            rb.MovePosition(rb.position + transform.forward * (playerSpeed/2) * movementYBefore * Time.deltaTime);
        else
            rb.MovePosition(rb.position + transform.forward * playerSpeed * movementYBefore * Time.deltaTime);
    }
    private void OnTriggerEnter(Collider triggerObj)
    {
        anim.SetBool("isJump", false);
        

        if (triggerObj.gameObject.CompareTag("Sheep"))
        {
            triggerObj.gameObject.SetActive(false);
            theSave.userSave.numSheep += 1;
            theSave.userSave.SaveUser();
        }        
        else if (triggerObj.gameObject.CompareTag("Water"))
        {
            inWater = true;
        }
    }

    private void OnTriggerExit(Collider triggerObj)
    {
        if (triggerObj.gameObject.CompareTag("Water"))
        {
            inWater = false;
            if (waterBonusApp == true)
            {
                playerMaxSpeed *= 2;
                waterBonusApp = false;
                anim.SetBool("isSwim", false);
                anim.SetBool("isSwimIdle", false);
            }
        }
    }

    // As long as we have a collision, we are "on the terrain"
    private void OnCollisionEnter(Collision collidingObj)
    {
        onTerrain = true;
        anim.SetBool("isJump", false);
    }
    // As long as we have exited a collision, we must be "in the air"
    private void OnCollisionExit(Collision collidingObj)
    {
        
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
            //onTerrain = false;
            anim.SetBool("isJump", true);
            onTerrain = false;
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
            cf.offsetPosition.z = cf.offsetPosition.z * -1.0f;
        }        
    }
    private void OnPause()
    {
        // Note sure how to handle when a theSave releases a key so this is my workaround! User pushes once to get the pause menu, then pushes again to get out of it
        isPause = !isPause;
        //animator.Stop();
        PauseMenu men = pauseMenu.GetComponent<PauseMenu>();
        if (isPause == true)
            men.PauseGame();
        else
            men.ResumeGame();
    }
    public void OnRoar()
    {
        audioRoar.Play();
    }
    
    private void OnFire()
    {
        gameObject.transform.GetChild(5).gameObject.GetComponent<ParticleSystem>().Play();
        OnRoar();
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
