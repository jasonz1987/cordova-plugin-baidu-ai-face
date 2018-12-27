package org.apache.cordova.aiface;

import android.app.Activity;
import android.content.Intent;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaWebView;
import org.json.JSONArray;
import org.json.JSONException;

/**
 * Created by vince_huang on 2018/7/15.
 */

public class FaceLivenessExpPlugin extends CordovaPlugin {
    private CallbackContext callbackContext;

    @Override
    public void initialize(CordovaInterface cordova, CordovaWebView webView) {
        super.initialize(cordova, webView);
      //  Config config = new Config(cordova.getContext().getApplicationContext());
        Config config=new Config(cordova.getActivity().getApplicationContext());
        config.initLib();
    }

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        this.callbackContext = callbackContext;
        if (action.equals("FaceLivenessExp")) {
            faceLivenessExp();
        } else if (action.equals("FaceDetectExp")) {
            faceDetectExp();
        }
        return super.execute(action, args, callbackContext);
    }

    private void faceDetectExp() {
        Intent intent = new Intent(cordova.getActivity(), FaceDetectExpActivity.class);
        cordova.startActivityForResult(this, intent, 0);
    }

    private void faceLivenessExp() {
        Intent intent = new Intent(cordova.getActivity(), FaceLivenessExpActivity.class);
        cordova.startActivityForResult(this, intent, 0);
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent intent) {
        super.onActivityResult(requestCode, resultCode, intent);
        if (resultCode == Activity.RESULT_OK) {
            String reason = intent.getStringExtra("reason");
            boolean isSuccess = intent.getBooleanExtra("isSuccess", false);
            if (isSuccess) {
                callbackContext.success(reason);
                return;
            }
            callbackContext.error(reason);
        }
    }
}
