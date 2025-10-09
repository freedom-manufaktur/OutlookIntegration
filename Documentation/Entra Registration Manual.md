OutlookIntegration - Microsoft Entra Registration Manual
===
Version: `3.0.0` - `2025-10-09` \
Author: martin@freedom-manufaktur.com \
Link: [Documentation on GitHub](<https://github.com/freedom-manufaktur/OutlookIntegration/tree/main/Documentation/Entra Registration Manual.md>)

# Microsoft Entra Application registration
> ❗ Before you begin\
> You **should** know your *Outlook Integration Service URL*.

1.  Open the [Entra admin center - App registrations](https://entra.microsoft.com/#view/Microsoft_AAD_RegisteredApps/ApplicationsListBlade/quickStartType~/null/sourceType/Microsoft_AAD_IAM) portal.

2.  Add a **new registration** and give it a fitting **name**.\
    Under **Redirect URI** choose **Single-page application (SPA)** as platform and enter an URI in the form of\
    `brk-multihub://addin.MyCompany.com`.\
    Insert the domain name of **your** *Outlook Integration Service URL* after the `brk-multihub://`.\
    If your port number is non-standard, then also include it.\
    **Do not** include any path segments after the domain name.
    ![New App registration](Images/Entra%20App%20registration%20New.png)

3.  Write down the *Application ID* (e.g. `577b6e4c-c8a2-4d93-98d2-284e8fb55622`) and  *Tenant ID* (e.g. `9776b2ed-e415-439d-9582-85719af85979`).\
    ![App registration ID](Images/Entra%20App%20registration%20ID.png)

4.  Under **API permissions** make sure that you have at least `Mail.Read` and `User.Read` delegated permissions.\
    Once you have added the permissions, use **Grant admin consent for MyCompany** and make sure all permissions have admin consent.\
    ![App registration permissions](Images/Entra%20App%20registration%20Permissions.png)
    > [!NOTE]
    > Microsoft states that the `User.Read` permission can be replaced by `openid` and `profile` which is even less permissive. We do **not** recommend this, as we had the most reliable results with `User.Read`.\
    > Microsoft also states that the `Files.ReadWrite` permission is required. We do **not** need this permission.

# Summary
As a result of this chapter you should have the following information at your disposal:
* Entra Application ID (e.g. `577b6e4c-c8a2-4d93-98d2-284e8fb55622`)
* Entra Tenant ID (e.g. `9776b2ed-e415-439d-9582-85719af85979`)
