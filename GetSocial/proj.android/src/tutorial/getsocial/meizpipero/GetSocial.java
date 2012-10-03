/****************************************************************************
Copyright (c) 2010-2012 cocos2d-x.org

http://www.cocos2d-x.org

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
****************************************************************************/
package tutorial.getsocial.meizpipero;

import tutorial.getsocial.meizpipero.FacebookConnector;
import com.facebook.android.Facebook;

import java.io.IOException;
import java.net.MalformedURLException;
import java.util.Date;

import org.cocos2dx.lib.Cocos2dxActivity;
import org.cocos2dx.lib.Cocos2dxEditText;
import org.cocos2dx.lib.Cocos2dxGLSurfaceView;
import org.cocos2dx.lib.Cocos2dxRenderer;

import tutorial.getsocial.meizpipero.SessionEvents;

import android.app.ActivityManager;
import android.content.Context;
import android.content.Intent;
import android.content.pm.ConfigurationInfo;
import android.net.Uri;
import android.os.Bundle;
import android.os.Handler;
import android.util.Log;
import android.widget.FrameLayout;
import android.widget.TextView;
import android.widget.Toast;
import android.view.ViewGroup;

public class GetSocial extends Cocos2dxActivity

{

	private static final String FACEBOOK_APPID = "317764948310799";	// Pipero Test app
	private static final String FACEBOOK_PERMISSION = "publish_stream";
	private static final String TAG = "FacebookSample";
	private static final String MSG = "Message from FacebookSample";
	
	private final static Handler mFacebookHandler = new Handler();
	private TextView loginStatus;
	static private FacebookConnector facebookConnector;
	
	static Context myContext;
	
	final static Runnable mUpdateFacebookNotification = new Runnable() 
	{
        public void run() 
        {
        	//Toast.makeText(getBaseContext(), "Facebook updated !", Toast.LENGTH_LONG).show();
        }
    };
    
	protected void onCreate(Bundle savedInstanceState)
	{
		super.onCreate(savedInstanceState);
		
		myContext = getApplicationContext();
		
		//
		this.facebookConnector = new FacebookConnector(FACEBOOK_APPID, this, getApplicationContext(), new String[] {FACEBOOK_PERMISSION});
		
		if (detectOpenGLES20()) 
		{
			// get the packageName,it's used to set the resource path
			String packageName = getApplication().getPackageName();
			super.setPackageName(packageName);
			
            // FrameLayout
            ViewGroup.LayoutParams framelayout_params =
                new ViewGroup.LayoutParams(ViewGroup.LayoutParams.FILL_PARENT,
                                           ViewGroup.LayoutParams.FILL_PARENT);
            FrameLayout framelayout = new FrameLayout(this);
            framelayout.setLayoutParams(framelayout_params);

            // Cocos2dxEditText layout
            ViewGroup.LayoutParams edittext_layout_params =
                new ViewGroup.LayoutParams(ViewGroup.LayoutParams.FILL_PARENT,
                                           ViewGroup.LayoutParams.WRAP_CONTENT);
            Cocos2dxEditText edittext = new Cocos2dxEditText(this);
            edittext.setLayoutParams(edittext_layout_params);

            // ...add to FrameLayout
            framelayout.addView(edittext);

            // Cocos2dxGLSurfaceView
	        mGLView = new Cocos2dxGLSurfaceView(this);

            // ...add to FrameLayout
            framelayout.addView(mGLView);

	        mGLView.setEGLContextClientVersion(2);
	        mGLView.setCocos2dxRenderer(new Cocos2dxRenderer());
            mGLView.setTextField(edittext);

            // Set framelayout as the content view
			setContentView(framelayout);
		}
		else {
			Log.d("activity", "don't support gles2.0");
			finish();
		}	

		// Make a Call to Java
		this.testCallFromJava();
		
		//tweet();
		//postMessage();
	}
	
	 @Override
	 protected void onPause() {
	     super.onPause();
	     mGLView.onPause();
	 }

	 @Override
	 protected void onResume() {
	     super.onResume();
	     mGLView.onResume();
	 }
	 
	 private boolean detectOpenGLES20() 
	 {
	     ActivityManager am =
	            (ActivityManager) getSystemService(Context.ACTIVITY_SERVICE);
	     ConfigurationInfo info = am.getDeviceConfigurationInfo();
	     return (info.reqGlEsVersion >= 0x20000);
	 }
	
	 private native void testCallFromJava();
	 
     static 
     {
         System.loadLibrary("game");
     }
     
     //
     protected void onActivityResult(int requestCode, int resultCode, Intent data) 
     {
 		this.facebookConnector.getFacebook().authorizeCallback(requestCode, resultCode, data);
 	}
     
     public void updateLoginStatus() {
 		loginStatus.setText("Logged into Twitter : " + facebookConnector.getFacebook().isSessionValid());
 	}
 	

 	private static String getFacebookMsg() 
 	{
 		return MSG + " at " + new Date().toLocaleString();
 	}	
 	
 	static public void postMessage() 
 	{
 		Log.d("activity", "postMessage (FB) on Java");
 		if (facebookConnector.getFacebook().isSessionValid()) 
 		{
 			postMessageInThread();
 		} 
 		else 
 		{
 			SessionEvents.AuthListener listener = new SessionEvents.AuthListener() 
 			{
 				
 				@Override
 				public void onAuthSucceed() 
 				{
 					postMessageInThread();
 				}
 				
 				@Override
 				public void onAuthFail(String error) 
 				{
 					
 				}
 			};
 			SessionEvents.addAuthListener(listener);
 			facebookConnector.login();
 		}
 	}

 	private static void postMessageInThread() 
 	{
 		Thread t = new Thread() {
 			public void run() {
 		    	
 		    	try {
 		    		facebookConnector.postMessageOnWall(getFacebookMsg());
 					mFacebookHandler.post(mUpdateFacebookNotification);
 				} catch (Exception ex) {
 					Log.e(TAG, "Error sending msg",ex);
 				}
 		    }
 		};
 		t.start();
 	}

 	private void clearCredentials() 
 	{
 		try 
 		{
 			facebookConnector.getFacebook().logout(getApplicationContext());
 		} 
 		catch (MalformedURLException e) 
 		{
 			e.printStackTrace();
 		} 
 		catch (IOException e) 
 		{
 			e.printStackTrace();
 		}
 	}
 	private static void tweet()
 	{
 		Log.d("activity", "Tweet on Java");
 		String score = "123";
 		String tweetUrl = "https://twitter.com/intent/tweet?text=Hello ! I have just got " + score + " points in mygame for Android !!!!";
 		Uri uri = Uri.parse(tweetUrl);
 		Intent i = new Intent(Intent.ACTION_VIEW, uri);
        i.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
 		myContext.startActivity(i);
 	}
 	private static void sendEMail()
 	{
 		Log.d("activity", "Send a email on Java");
 		Intent i = new Intent(Intent.ACTION_SEND);
 		//i.setType("text/plain"); //use this line for testing in the emulator
 		i.setType("message/rfc822") ; // use from live device
 		i.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
 		i.putExtra(Intent.EXTRA_EMAIL, new String[]{"test@gmail.com"});
 		i.putExtra(Intent.EXTRA_SUBJECT,"Subject goes here");
 		i.putExtra(Intent.EXTRA_TEXT,"Test body goes here");
 		myContext.startActivity(i);
 	}
}
