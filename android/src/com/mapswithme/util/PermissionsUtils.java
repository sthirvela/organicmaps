package com.mapswithme.util;

import static android.Manifest.permission.ACCESS_COARSE_LOCATION;
import static android.Manifest.permission.ACCESS_FINE_LOCATION;

import android.app.Activity;
import android.content.Context;
import android.content.pm.PackageManager;
import android.os.Build;

import androidx.annotation.NonNull;
import androidx.core.app.ActivityCompat;

import com.mapswithme.util.permissions.PermissionsResult;

import java.util.HashMap;
import java.util.Map;

public final class PermissionsUtils
{
  private static final String[] PERMISSIONS = new String[]
      {
          ACCESS_COARSE_LOCATION,
          ACCESS_FINE_LOCATION
      };

  private static final String[] LOCATION_PERMISSIONS = new String[]
      {
          ACCESS_COARSE_LOCATION,
          ACCESS_FINE_LOCATION
      };

  private PermissionsUtils() {}

  @NonNull
  public static PermissionsResult computePermissionsResult(@NonNull String[] permissions,
                                                           @NonNull int[] grantResults)
  {
    Map<String, Boolean> result = new HashMap<>();
    for (int i = 0; i < permissions.length; i++)
    {
      result.put(permissions[i], grantResults[i] == PackageManager.PERMISSION_GRANTED);
    }

    return getPermissionsResult(result);
  }

  public static boolean isLocationGranted(@NonNull Context context)
  {
    return checkPermissions(context).isLocationGranted();
  }

  @NonNull
  private static PermissionsResult checkPermissions(@NonNull Context context)
  {
    Context appContext = context.getApplicationContext();
    Map<String, Boolean> result = new HashMap<>();
    for (String permission: PERMISSIONS)
    {
      boolean granted = Build.VERSION.SDK_INT < Build.VERSION_CODES.M
          || appContext.checkSelfPermission(permission) == PackageManager.PERMISSION_GRANTED;
      result.put(permission, granted);
    }

    return getPermissionsResult(result);
  }

  @NonNull
  private static PermissionsResult getPermissionsResult(@NonNull Map<String, Boolean> result)
  {
    boolean locationGranted = (result.containsKey(ACCESS_COARSE_LOCATION)
                               ? result.get(ACCESS_COARSE_LOCATION) : false)
                              && (result.containsKey(ACCESS_FINE_LOCATION)
                                  ? result.get(ACCESS_FINE_LOCATION) : false);
    return new PermissionsResult(locationGranted);
  }

  public static void requestLocationPermission(@NonNull Activity activity, int code)
  {
    ActivityCompat.requestPermissions(activity, LOCATION_PERMISSIONS, code);
  }
}
