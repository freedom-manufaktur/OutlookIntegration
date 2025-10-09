OutlookIntegration - Microsoft Entra Registration Manual (Legacy Identity API)
---
Version: `3.0.0` - `2025-10-09` \
Author: martin@freedom-manufaktur.com \
Link: [Documentation on GitHub](<https://github.com/freedom-manufaktur/OutlookIntegration/tree/main/Documentation/Legacy/Entra Registration Manual.md>)

# Entra ID (Azure AD) Application registration
> [!WARNING] This is legacy
> [Nested app authentication (NAA)](<../Entra Registration Manual.md>) should be used instead.

> [!IMPORTANT] Before you begin
> You **should** know your *Outlook Integration Service URL*.

1.  Open the [Entra ID - App registrations](https://entra.microsoft.com/#view/Microsoft_AAD_RegisteredApps/ApplicationsListBlade/quickStartType~/null/sourceType/Microsoft_AAD_IAM) portal.

2.  Add a new registration and give it a fitting name.\
    ![New App registration](Images/Entra%20App%20registration%20New.png)

3.  Write down the *Application ID* (e.g. `4796b8e0-b713-42f7-9d9e-b5abb6dd49c2`) and  *Tenant ID* (e.g. `9776b2ed-e415-439d-9582-85719af85979`).\
    ![App registration ID](Images/Entra%20App%20registration%20ID.png)

4.  Under **Certificates & secrets** → **Client secrets** add a client secret and write it down (e.g. `UUC8Q[...]`).\
    ![App registration secret](Images/Entra%20App%20registration%20Secret.png)

5.  Under **API permissions** make sure that you have at least `Mail.Read` and `User.Read` delegated permissions.\
    Once you have added the permissions, use **Grant admin consent for MyCompany** and make sure all permissions have admin consent.\
    ![App registration permissions](Images/Entra%20App%20registration%20Permissions.png)
    > Note: Microsoft states that the `User.Read` permission can be replaced by `openid` and `profile` which is even less permissive. We do **not** recommend this, as we had the most reliable results with `User.Read`.
      
    > Note: Microsoft states that the `Files.ReadWrite` permission is required. We do **not** need this permission.

6.  Under **Manifest** choose **Microsoft Graph App Manifest** and change `api` → `accessTokenAcceptedVersion` to `2` (default: `null`) and **Save**.\
    ![App registration token version](Images/Entra%20App%20registration%20TokenVersion.png)

7.  Under **Expose an API**
    1.  Under **Application ID URI** click **Add**.\
    You should see something like `api://4796b8e0-b713-42f7-9d9e-b5abb6dd49c2`. Insert the public domain name of your *Add-in* service URL between `api://` and the application ID (e.g. `api://addin.MyCompany.com/4796b8e0-b713-42f7-9d9e-b5abb6dd49c2`).
    2.  Under **Scopes defined by this API** click **Add a scope** and set
        - Scope name: `access_as_user`
        - Who can consent: `Admins and users`
        - Admin consent display name: `Read user email`
        - Admin consent description: `Allows the app to read user's email.`
        - User consent display name: `Read your email`
        - User consent description: `Allows the app to read your email.`
    3.  Under **Authorized client applications** click **Add a client application** and enter *Client ID*: `ea5a67f6-b6f3-4338-b240-c655ddc3cc8e` (Outlook) for the created scope.\
    ![App registration expose an API](Images/Entra%20App%20registration%20Expose.png)
    > If you want to know more about the process you can read the Microsoft article [Register an Office Add-in that uses single sign-on (SSO) with the Microsoft identity platform](https://learn.microsoft.com/en-us/office/dev/add-ins/develop/register-sso-add-in-aad-v2).

As a result of this chapter you should have the following information at your disposal:
* Entra ID Application ID (e.g. `4796b8e0-b713-42f7-9d9e-b5abb6dd49c2`)
* Entra ID Application ID URI (e.g. `api://addin.MyCompany.com/4796b8e0-b713-42f7-9d9e-b5abb6dd49c2`)
* Entra ID Tenant ID (e.g. `9776b2ed-e415-439d-9582-85719af85979`)
* Entra ID Client Secret (e.g. `UUC8Q[...]`)
