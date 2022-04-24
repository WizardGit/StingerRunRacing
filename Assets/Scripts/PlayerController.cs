/*
 * Author: Kaiser Slocum
 * Date last edited: 4/18/2022
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
    // Dictates if the player is allowed to move
    private bool start = false;
    // Dictates if the player is on the Terrain
    private bool onTerrain = false;
    // Dictates how many checkpoints there are
    public int numCheckpoints;
    // Dictates how many checkpoints the user has hit
    private int checkpointsReached = 0;
    // Dictates the name of the player
    public string username = "Kaiser";
    // These variables hold the animation title for the speedstinger
    private string animationRun = "Run";
    private string animationIdle = "IdleHappy";
    private string animationLeft = "WalkLeft";
    private string animationRight = "WalkRight";

    // Movement variables
    public float playerRotationSpeed = 100f;
    public float playerSpeed = 20f;
    public float speedBoostMultiplier = 1.5f;
    public float jumpForce = 400f;  

    // Movement variables
    private float movementX;
    private float movementY;
    // Dictates the last checkpoint that the player will reset to if it falls out of the map
    private Vector3 resetPos;

    // Object variables
    Animation animator;
    Rigidbody rb;

    // Text variables
    public TextMeshProUGUI timeText;
    public TextMeshProUGUI messageText;

    //Given a save object and a fileName, this method saves the save object to a local file
    private void SaveGame(Save save, string fileName)
    {
        BinaryFormatter bf = new BinaryFormatter();
        FileStream file = File.Create(Application.persistentDataPath + "/" + fileName + ".save");
        bf.Serialize(file, save);
        file.Close();
        Debug.Log("Game Saved");
    }
    //Given a fileName, this method checks to see if the file is available.
    //If not, it returns null.
    //If so, it returns the save object
    public Save LoadGame(string fileName)
    {
        if (File.Exists(Application.persistentDataPath + "/" + fileName + ".save"))
        {
            BinaryFormatter bf = new BinaryFormatter();
            FileStream file = File.Open(Application.persistentDataPath + "/" + fileName + ".save", FileMode.Open);
            Save save = (Save)bf.Deserialize(file);
            file.Close();

            Debug.Log("Game Loaded");
            return save;
        }
        else
        {
            Debug.Log("No game saved!");
        }
        return null;
    }

    void Start()
    {
        animator = GetComponent<Animation>();
        rb = GetComponent<Rigidbody>();
        timeText.text = "Time: 0";
        resetPos = new Vector3(1737f, 107.79f, 1534f);


        Debug.Log("Our file's path is here: " + Application.persistentDataPath);
        Save save = LoadGame(username); 
        if (save == null)
        {
            save = new Save();
            SaveGame(save,username);
        }
    }

    private void OnMove(InputValue movementValue)
    {
        Vector2 movementXY = movementValue.Get<Vector2>().normalized;
        movementX = movementXY.x;
        movementY = movementXY.y;        
    }

    private void OnJump()
    {
        if ((onTerrain == true) && (start == true))
        {            
            Vector3 jump = new Vector3(movementX, jumpForce, movementY);
            rb.AddForce(jump);
            animator.Play("Jump01");
        }     
    }

    private void FixedUpdate()
    {
        // This code is responsible for the "jerk"
        // However it's vital for keeping the dragon rotated with the terrain
        //https://answers.unity.com/questions/1347986/rotating-a-player-to-match-terrain-slope.html
        RaycastHit hit;
        if (Physics.SphereCast(transform.position, 0.4f, -(transform.up), out hit, 0.1f))
        {
            rb.MoveRotation(Quaternion.LookRotation(Vector3.Cross(transform.right, hit.normal)));
        }

        if (rb.position.y <= 0)
        {
            rb.MovePosition(resetPos);
        }
        if (((time - boostTimer) > 20f) && (boostTimer > 0))
        {
            playerSpeed = playerSpeed / speedBoostMultiplier;
            boostTimer = 0;
        }
        else if ((time - boostTimer) > 2f)
        {
            messageText.text = "";
        }

        if (start == false)
        {
            countdown += Time.deltaTime;
            messageText.text = (3-MathF.Round(countdown)).ToString();
            if (countdown >= 2.5f)
            {
                start = true;
                messageText.text = "<size=200%> GO!";
            }            
        }
        else
        {
            time += Time.deltaTime;
            timeText.text = "Time: " + MathF.Round(time, 2);            
            Move();

            if ((time > 3.0f) && (start == true) && (messageText.text == "<size=200%> GO!") && (messageText.text != ""))
            {
                messageText.text = "";
            }
            
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

        Vector3 vecRotation = new Vector3(0, playerRotationSpeed, 0);
        Quaternion deltaRotation = Quaternion.Euler(movementX * vecRotation * Time.deltaTime);
        rb.MoveRotation(rb.rotation * deltaRotation);   
        rb.MovePosition(rb.position + transform.forward * playerSpeed * movementY * Time.deltaTime);

        
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
            playerSpeed = playerSpeed * speedBoostMultiplier;
            messageText.text = "<size=200%> Double Speed!";
            boostTimer = time;
            //Maybe do random thing, we could do double jump?
        }
        else if ((other.gameObject.CompareTag("Finish")) && (checkpointsReached == numCheckpoints))
        {
            messageText.text = "<size=200%> Finished!";
            other.gameObject.SetActive(false);

            Save save = LoadGame(username);
            if (save == null)
            {
                Debug.Log("ERROR loading user's information file.  It should have already been created!");
            }
            else
            {
                Debug.Log("Your time: " + time.ToString());
                Debug.Log("Best time: " + save.levelOneTime.ToString());
                if (time < save.levelOneTime)
                {
                    save.levelOneTime = time;
                }                
                Debug.Log("Best time: " + save.levelOneTime.ToString());
                SaveGame(save, username);
            }
            Application.Quit();
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

        }
    }
}

