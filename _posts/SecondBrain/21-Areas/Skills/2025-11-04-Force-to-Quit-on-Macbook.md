---
layout: post
title: Force to Quit on Macbook
categories: SecondBrain
status: completed
tags:
  - perplexity
---
2025-11-04 14:41

Tags: [[macbook]], [[bugfix]]

# Force to Quit on Macbook

Your issue with Microsoft Edge failing to start or quit on your Mac is common, especially if the app becomes unresponsive or corrupted. Here are some effective steps to resolve this problem:

## Force Quit Microsoft Edge

- Open the **Apple menu** and select **Force Quit** or press **Command-Option-Esc**.
- In the window that opens, select “Microsoft Edge” and click **Force Quit**.
- Alternatively, open **Activity Monitor** from Applications > Utilities, find “Microsoft Edge” under the CPU tab, select it, and click the **Stop (X)** button, then choose **Force Quit**.[apple+2](https://support.apple.com/en-my/102586)​

## Clear Edge Cache and Settings (if it opens at all)

- If Edge opens but doesn’t work properly, try clearing the cache and cookies from the Edge settings. This can often resolve startup issues by removing corrupt data.[helpdeskgeek+1](https://helpdeskgeek.com/microsoft-edge-not-opening-11-fixes-to-try/)​
    
## Reset or Reinstall Microsoft Edge

If force-quitting doesn’t help and Edge won’t start:

- **Delete Edge Cache**:
    - In Finder, press **Command-Shift-G** and type `~/Library/Caches/` then find and delete the “Microsoft Edge” folder.[teqiq+1](https://www.teqiq.com/2024/11/27/how-to-fix-microsoft-edge-not-opening/)​
        
- **Reinstall Microsoft Edge**:
    - Go to **Applications** in Finder, right-click on Microsoft Edge, and move it to Trash.
    - Download the latest version of Edge from Microsoft’s official website and reinstall it. For a thorough removal, you can use an app uninstaller like AppCleaner to get rid of leftover files before reinstalling.[reddit+2](https://www.reddit.com/r/edge/comments/13obxgq/cant_start_up_edge_on_mac/)​

## Run Microsoft AutoUpdate

- To ensure you have the latest and most stable version, use **Microsoft AutoUpdate**:
    - Go to `/Library/Application Support/Microsoft/MAU2.0`, and run the “Microsoft AutoUpdate” app to check for updates to Edge.[helpdeskgeek](https://helpdeskgeek.com/microsoft-edge-not-opening-11-fixes-to-try/)​

## Update macOS

- Make sure your system software is up to date. OS bugs or incompatibilities can sometimes cause app launch failures.[teqiq+1](https://www.teqiq.com/2024/11/27/how-to-fix-microsoft-edge-not-opening/)​

## Advanced: Collect Crash Logs (for persistent issues)

- If Edge keeps failing after all these steps, you can collect logs for Microsoft support:
    - In Finder, go to `/Users/[your user]/Library/Application Support/Microsoft Edge/Crashpad/pending` and `.../completed`.
    - Send these .dmp files to Microsoft for further assistance if requested.[reddit](https://www.reddit.com/r/edge/comments/13obxgq/cant_start_up_edge_on_mac/)​

By following these steps, you should be able to fix Microsoft Edge’s startup or quitting issues on your Mac. If Edge still fails to work after a clean reinstall and system update, consider contacting Microsoft Support for deeper troubleshooting.[microsoft+2](https://support.microsoft.com/en-us/microsoft-edge/what-to-do-if-microsoft-edge-isn-t-working-cc0657a6-acd2-cbbd-1528-c0335c71312a)​

## References
1. https://www.perplexity.ai/search/edge-is-keep-failed-to-start-o-B5MDd_t_SUa6niRXChBORA
2. [https://support.apple.com/en-my/102586](https://support.apple.com/en-my/102586)
3. [https://helpdeskgeek.com/microsoft-edge-not-opening-11-fixes-to-try/](https://helpdeskgeek.com/microsoft-edge-not-opening-11-fixes-to-try/)
4. [https://www.hellotech.com/guide/for/how-to-force-quit-on-mac](https://www.hellotech.com/guide/for/how-to-force-quit-on-mac)
5. [https://www.teqiq.com/2024/11/27/how-to-fix-microsoft-edge-not-opening/](https://www.teqiq.com/2024/11/27/how-to-fix-microsoft-edge-not-opening/)
6. [https://www.reddit.com/r/edge/comments/13obxgq/cant_start_up_edge_on_mac/](https://www.reddit.com/r/edge/comments/13obxgq/cant_start_up_edge_on_mac/)
7. [https://support.microsoft.com/en-us/microsoft-edge/what-to-do-if-microsoft-edge-isn-t-working-cc0657a6-acd2-cbbd-1528-c0335c71312a](https://support.microsoft.com/en-us/microsoft-edge/what-to-do-if-microsoft-edge-isn-t-working-cc0657a6-acd2-cbbd-1528-c0335c71312a)
8. [https://ppl-ai-file-upload.s3.amazonaws.com/web/direct-files/attachments/images/141423171/461fa66f-32c2-403a-a556-7bcc07ca72e6/image.jpg?AWSAccessKeyId=ASIA2F3EMEYE7JDQHMN2&Signature=WU8ZHBZzgpYPU2VE0jgcV6BY3Pw%3D&x-amz-security-token=IQoJb3JpZ2luX2VjEK7%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJIMEYCIQDne9HSH6cETpNDyZBL9dMz5sk1n0clzZZQASQwW%2BGJXQIhAPISH%2BnHGPOI0HDbZl4neidXmHCVLyqVJvKx3EdVO2iRKvMECHYQARoMNjk5NzUzMzA5NzA1IgyQVfTFQUR9rkAyTpsq0ARzXsH5G4aRJLeXSLmBTitSH0tLJty0%2F%2Fsj%2Bx1564h%2BJwy%2FtGCpV5%2B981X8as0kXwMTk8W0Nx18of3jQ05UEv2Q7fcjGPTBy96PV%2FwxZU7SqX%2BxUQabtD7vz1l%2Fd9Jz5V%2BhPNissIO0CcMpMRedlG857IIMb08ZaASyrB6nNfcykatT9XYXv%2BXAmW3IK3RQFO46n6Gj9sjrqrMIkTClccaw8l8WOjLlf8iQB6UWlTAbxKeiJO2zrv3pELIU9e6wFadij%2FmE95GmVXc13X5MPITG3dR2y%2FQ1VZlYOR6LyOIO%2Ft2X%2FhJjS9XNDY%2BulLkms1n%2B87PfngwnHBbL3T7UiI3CRVb05Pnho9icuG7pNMt44vPSIeZ1amZcpZk6w7zul7Wz0gaNHfJ5KRzfvSn2ZpDJvgLgNDCUGeLEOQcr%2BTx8BuaMouDnAVhvjaPfLPlZGsA9A0JqTR%2BgM6S5ooCQyV0HGNX90TB4Uct6OXRLfFny12h%2B7EE2tj%2F2YglXGUULZq49LHh0%2FOt9gvW6hf%2B8JomLpqoTHU3UwMpHQ3czhCZTMio3YVWts6heN1wORBwA%2BzTLE%2Bqth4H6L7FqYnWkcZ8PxxYXWNOV3pK3YRUTO43Q10Bl3hsFJ16S43Ns6jU5f1uAyEbJLXeNDgX%2Bgei2yadWYUCGwOAlInL3jtZKmWAdR6BDr%2BDgHdlSWLlihDjgSiO2FUJNUm2m2%2FojkBVepzMQ17MgEKTL0%2F4xBe5SyTgyu%2F0f38dmOjeZ4sgElAB2YvUpzBEHiN%2Fj8HwXAe6BIB%2FlML%2F5p8gGOpcBvohGIwyKnxPvEQR8py%2FCO310ST35weZ2%2FALQkz9lnNrkbJE4zSG%2BUHDUznPp7WchzahtZxbjAzlgwMb6TYApQewOv%2FoI1jTfNq5cEDjImiAdsh%2B3upkUz5ggqzUXwmvapnvlw61v43hzCf94Nm5F9m27ZcEs09h%2BpDQeJfFIOH7Uasbkf925BPP8V8FoiKHIGXBVEDetmA%3D%3D&Expires=1762264085](https://ppl-ai-file-upload.s3.amazonaws.com/web/direct-files/attachments/images/141423171/461fa66f-32c2-403a-a556-7bcc07ca72e6/image.jpg?AWSAccessKeyId=ASIA2F3EMEYE7JDQHMN2&Signature=WU8ZHBZzgpYPU2VE0jgcV6BY3Pw%3D&x-amz-security-token=IQoJb3JpZ2luX2VjEK7%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJIMEYCIQDne9HSH6cETpNDyZBL9dMz5sk1n0clzZZQASQwW%2BGJXQIhAPISH%2BnHGPOI0HDbZl4neidXmHCVLyqVJvKx3EdVO2iRKvMECHYQARoMNjk5NzUzMzA5NzA1IgyQVfTFQUR9rkAyTpsq0ARzXsH5G4aRJLeXSLmBTitSH0tLJty0%2F%2Fsj%2Bx1564h%2BJwy%2FtGCpV5%2B981X8as0kXwMTk8W0Nx18of3jQ05UEv2Q7fcjGPTBy96PV%2FwxZU7SqX%2BxUQabtD7vz1l%2Fd9Jz5V%2BhPNissIO0CcMpMRedlG857IIMb08ZaASyrB6nNfcykatT9XYXv%2BXAmW3IK3RQFO46n6Gj9sjrqrMIkTClccaw8l8WOjLlf8iQB6UWlTAbxKeiJO2zrv3pELIU9e6wFadij%2FmE95GmVXc13X5MPITG3dR2y%2FQ1VZlYOR6LyOIO%2Ft2X%2FhJjS9XNDY%2BulLkms1n%2B87PfngwnHBbL3T7UiI3CRVb05Pnho9icuG7pNMt44vPSIeZ1amZcpZk6w7zul7Wz0gaNHfJ5KRzfvSn2ZpDJvgLgNDCUGeLEOQcr%2BTx8BuaMouDnAVhvjaPfLPlZGsA9A0JqTR%2BgM6S5ooCQyV0HGNX90TB4Uct6OXRLfFny12h%2B7EE2tj%2F2YglXGUULZq49LHh0%2FOt9gvW6hf%2B8JomLpqoTHU3UwMpHQ3czhCZTMio3YVWts6heN1wORBwA%2BzTLE%2Bqth4H6L7FqYnWkcZ8PxxYXWNOV3pK3YRUTO43Q10Bl3hsFJ16S43Ns6jU5f1uAyEbJLXeNDgX%2Bgei2yadWYUCGwOAlInL3jtZKmWAdR6BDr%2BDgHdlSWLlihDjgSiO2FUJNUm2m2%2FojkBVepzMQ17MgEKTL0%2F4xBe5SyTgyu%2F0f38dmOjeZ4sgElAB2YvUpzBEHiN%2Fj8HwXAe6BIB%2FlML%2F5p8gGOpcBvohGIwyKnxPvEQR8py%2FCO310ST35weZ2%2FALQkz9lnNrkbJE4zSG%2BUHDUznPp7WchzahtZxbjAzlgwMb6TYApQewOv%2FoI1jTfNq5cEDjImiAdsh%2B3upkUz5ggqzUXwmvapnvlw61v43hzCf94Nm5F9m27ZcEs09h%2BpDQeJfFIOH7Uasbkf925BPP8V8FoiKHIGXBVEDetmA%3D%3D&Expires=1762264085)
9. [https://learn.microsoft.com/en-us/answers/questions/2365069/edge-crashes-repeatedly-on-macos](https://learn.microsoft.com/en-us/answers/questions/2365069/edge-crashes-repeatedly-on-macos)
10. [https://www.youtube.com/watch?v=BBoCvKDVoW0](https://www.youtube.com/watch?v=BBoCvKDVoW0)
11. [https://learn.microsoft.com/en-us/answers/tags/1157/microsoft-edge-browser-crashes-stops-working-macos](https://learn.microsoft.com/en-us/answers/tags/1157/microsoft-edge-browser-crashes-stops-working-macos)
12. [https://www.reddit.com/r/MicrosoftEdge/comments/wakpj3/microsoft_edge_for_mac_is_not_opening/](https://www.reddit.com/r/MicrosoftEdge/comments/wakpj3/microsoft_edge_for_mac_is_not_opening/)