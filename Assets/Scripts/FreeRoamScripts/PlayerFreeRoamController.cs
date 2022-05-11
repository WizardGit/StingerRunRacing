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

public class PlayerFreeRoamController : MonoBehaviour
{
    // Variables for keeping the time
    private float time = 0.0f;
    // Dictates if the player is allowed to move
    private bool isPause = false;
    // Dictates if the player is on the Terrain
    private bool onTerrain = false;
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

    public TextMeshProUGUI messageText;

    // Variables for raycasting
    private float maxDistCast = 0.1f;
    private float radius = 0.2f;

    //Gem variables
    private int gemCount;

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

        resetPos = new Vector3(577f, 8f, 193f);

        // Load/Create a new file for this user!
        usersave = new UserSave(username);
        ledsave = new LeaderboardSave();
        ledBoard.SetActive(false);

        int modelToUse = 0;
        for (int i = 0; i < usersave.dragons.Count; i++)
        {
            if (usersave.dragons[i].GetUse() == "Using")
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
        if (PauseMenu.isPaused == false)
        {
            isPause = false;
        }

        if (isPause == false)
        {
            time += Time.deltaTime;          
            Move();           
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
        if (other.gameObject.CompareTag("Water"))
        {
            Debug.Log("Water");
        }
        else if (other.gameObject.CompareTag("Finish"))
        {
            isPause = true;
            animator.Play(animationIdle);
            messageText.text = "";       
            other.gameObject.SetActive(false);  
            
            GameObject text1 = ledBoard.transform.GetChild(0).gameObject;
            GameObject text2 = ledBoard.transform.GetChild(1).gameObject;
            text1.GetComponent<TextMeshProUGUI>().text = username + ": " + MathF.Round(time, 3);
            text2.GetComponent<TextMeshProUGUI>().text = ledsave.getLeaderboard(1);

            ledBoard.SetActive(true);
        }
        else if (other.gameObject.CompareTag("GemPickup"))
        {
            Debug.Log("Gem picked up!");
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