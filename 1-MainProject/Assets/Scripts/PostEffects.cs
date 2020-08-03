using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent (typeof (Camera))]
[ExecuteInEditMode]

public class PostEffects : MonoBehaviour {

	public Shader curShader;
	private Material curMaterial;
	public bool InvertEffect;
	public bool DepthEffect;

	Material material
	{
		get
		{
			if (curMaterial == null){
				curMaterial = new Material(curShader);
				curMaterial.hideFlags = HideFlags.HideAndDontSave;
			}
			return curMaterial;
		}
	}

	void Start () {
		curShader = Shader.Find("Hidden/PostEffects");
		GetComponent<Camera>().allowHDR = true;
		if(!SystemInfo.supportsImageEffects){
			enabled = false;
			Debug.Log("not supported");
			return;
		}
		if (!curShader && !curShader.isSupported){
			enabled = false;
			Debug.Log("not supported");
		}
		GetComponent<Camera>().depthTextureMode = DepthTextureMode.Depth;
	}

	void OnRenderImage(RenderTexture sourceTexture, RenderTexture destTexture) {
		if (curShader != null)
		{
			if (InvertEffect) { 
				Graphics.Blit(sourceTexture, destTexture, material, 0);
			} else if (DepthEffect) {
				Graphics.Blit(sourceTexture, destTexture, material, 1);
			} else {
				Graphics.Blit(sourceTexture, destTexture);
			}
		}
	}

	// Update is called once per frame
	void Update () {
		if (!GetComponent<Camera>().enabled)
			return;
	}

	void OnDisable(){

		if(curMaterial){
			DestroyImmediate(curMaterial);
		}
	}
}
