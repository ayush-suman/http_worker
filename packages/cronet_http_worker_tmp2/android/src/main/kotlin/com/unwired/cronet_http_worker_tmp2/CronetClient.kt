package com.unwired.cronet_http_worker_tmp2

import android.content.Context
import android.util.Log
import com.google.android.gms.net.CronetProviderInstaller
import com.google.android.gms.tasks.Tasks
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import org.chromium.net.CronetEngine
import org.chromium.net.CronetException
import org.chromium.net.UrlRequest
import org.chromium.net.UrlRequest.Callback
import org.chromium.net.UrlResponseInfo
import java.nio.ByteBuffer
import java.util.concurrent.Executors

class CronetClient {

    private lateinit var cronetEngine: CronetEngine
    suspend fun initialise(context: Context) {
        withContext(Dispatchers.IO) {
            val task = CronetProviderInstaller.installProvider(context)
            Tasks.await(task)
            cronetEngine = CronetEngine.Builder(context).enableQuic(true).build()
            Log.d("Cronet", "Cronet initialised")
        }
    }

    fun get(url: String) {
        cronetEngine.newUrlRequestBuilder(url, RequestCallback(), Executors.newSingleThreadExecutor()).build().start()
    }
}

class RequestCallback: Callback() {
    override fun onRedirectReceived(
        request: UrlRequest?,
        info: UrlResponseInfo?,
        newLocationUrl: String?
    ) {
        Log.d("Cronet", newLocationUrl.toString())
    }

    override fun onResponseStarted(request: UrlRequest?, info: UrlResponseInfo?) {
        Log.d("Cronet", info.toString())
    }

    override fun onReadCompleted(
        request: UrlRequest?,
        info: UrlResponseInfo?,
        byteBuffer: ByteBuffer?
    ) {
        Log.d("Cronet", byteBuffer.toString())
    }

    override fun onSucceeded(request: UrlRequest?, info: UrlResponseInfo?) {
        Log.d("Cronet", info.toString())
    }

    override fun onFailed(request: UrlRequest?, info: UrlResponseInfo?, error: CronetException?) {
        Log.d("Cronet", error.toString())
    }

}
