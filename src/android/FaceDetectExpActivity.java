package org.apache.cordova.aiface;

import android.Manifest;
import android.annotation.TargetApi;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Bundle;
import com.android.volley.RequestQueue;
import com.android.volley.toolbox.Volley;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.Request;
import com.android.volley.Response;
import android.util.Log;
import com.android.volley.VolleyError;
import com.android.volley.AuthFailureError;
import java.util.Map;

import com.baidu.idl.face.platform.FaceStatusEnum;
import com.baidu.idl.face.platform.ui.FaceDetectActivity;

import java.util.HashMap;

public class FaceDetectExpActivity extends FaceDetectActivity {

    @Override
    public void onCreate(Bundle savedInstanceState) {
        requestPermissions(99, Manifest.permission.CAMERA);
        super.onCreate(savedInstanceState);
    }

    @Override
    public void onDetectCompletion(FaceStatusEnum status, String message, HashMap<String, String> base64ImageMap) {
        super.onDetectCompletion(status, message, base64ImageMap);
        if (status == FaceStatusEnum.OK && mIsCompletion) {
            returnResult("采集成功", true);
			postStringRequest(base64ImageMap);
        } else if (status == FaceStatusEnum.Error_DetectTimeout ||
                status == FaceStatusEnum.Error_LivenessTimeout ||
                status == FaceStatusEnum.Error_Timeout) {
            returnResult("采集超时", false);
        }
    }
	//开始
private void postStringRequest(final HashMap<String, String> base64ImageMap) {

        String url="http://192.13.4.33:8080/FaceUpload/FaceContrast.do";

        RequestQueue queue= Volley.newRequestQueue(this);
        StringRequest request=new StringRequest(Request.Method.POST, url, new Response.Listener<String>() {
            @Override
            public void onResponse(String s) {
                Log.e("lz","success"+s);
            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError volleyError) {
                Log.e("lz","error"+volleyError.toString());
            }
        }){
            @Override
            protected Map<String, String> getParams() throws AuthFailureError {
                String mData="";
                for (int i=0;i<base64ImageMap.size();i++){
                   if (base64ImageMap.containsKey("bestImage"+i)){
                        mData=mData+base64ImageMap.get("bestImage"+i)+",";
                    }else {
                        break;
                    }
                }
               Map<String,String> map=new HashMap<String,String>();
               map.put("data",mData);//后台把这个取出来  解密这个

                return map;
            }
        };
           queue.add(request);
    }

//end

    public void requestPermissions(int requestCode, String permission) {
        if (permission != null && permission.length() > 0) {
            try {
                if (Build.VERSION.SDK_INT >= 23) {
                    // 检查是否有权限
                    int hasPer = checkSelfPermission(permission);
                    if (hasPer != PackageManager.PERMISSION_GRANTED) {
                        // 是否应该显示权限请求
                        boolean isShould = shouldShowRequestPermissionRationale(permission);
                        requestPermissions(new String[]{permission}, requestCode);
                    }
                } else {

                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }

    @TargetApi(Build.VERSION_CODES.M)
    @Override
    public void onRequestPermissionsResult(int requestCode, String[] permissions,
                                           int[] grantResults) {
        boolean flag = false;
        for (int i = 0; i < permissions.length; i++) {
            if (PackageManager.PERMISSION_GRANTED == grantResults[i]) {
                flag = true;
            }
        }
        if (!flag) {
            requestPermissions(99, Manifest.permission.CAMERA);
        }
    }

    @Override
    public void finish() {
        super.finish();
    }

    public void returnResult(String reason, boolean isSuccess) {
        Intent intent = new Intent();
        intent.putExtra("isSuccess", isSuccess);
        intent.putExtra("reason", reason);
        setResult(RESULT_OK, intent);
        super.finish();
    }
}
