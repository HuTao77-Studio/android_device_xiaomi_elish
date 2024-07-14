/*
 * Copyright (C) 2024 The LineageOS Project
 *
 * SPDX-License-Identifier: Apache-2.0
 */

package org.lineageos.xiaomiperipheralmanager;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.util.Log;

import vendor.xiaomi.hardware.touchfeature.V1_0.ITouchFeature;

import org.lineageos.xiaomiperipheralmanager.utils.FileUtils;

public class BootCompletedReceiver extends BroadcastReceiver {

    private static final boolean DEBUG = true;
    private static final String TAG = "XiaomiPeripheralManager";

    public static final String SHARED_STYLUS = "shared_stylus";
    public static final String SHARED_KEYBOARD = "shared_keyboard";

    private ITouchFeature mTouchFeature;

    @Override
    public void onReceive(final Context context, Intent intent) {
        if (!intent.getAction().equals(Intent.ACTION_LOCKED_BOOT_COMPLETED)) {
            return;
        }
        if (DEBUG) Log.d(TAG, "Received boot completed intent");
        SharedPreferences stylus_prefs = context.getSharedPreferences(SHARED_STYLUS, Context.MODE_PRIVATE);
        SharedPreferences keyboard_prefs = context.getSharedPreferences(SHARED_KEYBOARD, Context.MODE_PRIVATE);
        try {
            mTouchFeature = ITouchFeature.getService();
            mTouchFeature.setTouchMode(20, stylus_prefs.getInt(SHARED_STYLUS, 0));
        } catch (Exception e) {
        }
        if (keyboard_prefs.getInt(SHARED_KEYBOARD, 1) == 0)
            FileUtils.writeLine("/sys/devices/platform/soc/soc:xiaomi_keyboard/xiaomi_keyboard_conn_status", "enable_keyboard");
        else
            FileUtils.writeLine("/sys/devices/platform/soc/soc:xiaomi_keyboard/xiaomi_keyboard_conn_status", "disable_keyboard");
    }
}
