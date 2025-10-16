OutlookIntegration - Exchange Server Registration Manual
===
Version: `3.1.0` - `2025-10-13` \
Author: martin@freedom-manufaktur.com \
Link: [Documentation on GitHub](<https://github.com/freedom-manufaktur/OutlookIntegration/blob/main/Documentation/Exchange Server Registration Manual.md>)


# Exchange Server Registration
1.  (Optional) Open the **Exchange Management Shell** and run the command `Get-AuthConfig | Select ServiceName`.\
    You should see the following output:
    ```
    PS> Get-AuthConfig | Select ServiceName
    
    ServiceName
    -----------
    00000002-0000-0ff1-ce00-000000000000
    ```
2.  Write down the **ServiceName** value. On Exchange Server the default should be `00000002-0000-0ff1-ce00-000000000000`.
3.  When the [OutlookIntegration Manual](<OutlookIntegration Installation and Registration Manual.md>) talks about the **Entra Application ID**, use this **ServiceName**.
4.  When the [OutlookIntegration Manual](<OutlookIntegration Installation and Registration Manual.md>) talks about the **Entra Tenant ID**, use your *Active Directory* domain name.

## Summary
As a result of this chapter you should have the following information at your disposal:
- Entra Application ID (e.g. `00000002-0000-0ff1-ce00-000000000000`)
- Entra Tenant ID (e.g. `MyCompany.com`)


> ➡️ Now continue with the [OutlookIntegration Manual](<OutlookIntegration Installation and Registration Manual.md#3-whoosh-oktopus-installation>).


# Add-in installation

## How to install (for personal use)
1.  Visit your Outlook Web Access (OWA) https://exchange.MyCompany.com/owa/
2.  Open the settings (⚙️ icon) in the top-right corner and choose **Manage add-ins**
    ![My Add-ins](<Images/Exchange Server My Add-ins.png>)
3.  Click **Add** (➕ icon) and choose **Add from a file**
4.  Select your Add-in manifest (e.g. `MyCompany.xml`)

## How to install (for organization)
1.  Open the [**Exchange Admin Center**](https://localhost/ecp/) (typically directly on the Exchange Server).
2.  Navigate to **organization** → **add-ins**
    ![Exchange Server Add-ins](<Images/Exchange Server Add-ins.png>)
3.  Click **Add** (➕ icon) and choose **Add from file**
4.  Select your Add-in manifest (e.g. `MyCompany.xml`)
5.  After the Add-in has been added, select the Add-in and configure it (✏️ icon). Choose the publishing option that fits best for you.
    ![Enable Add-in](<Images/Exchange Server Add-ins Enable.png>)

## Use the Add-in
As a Microsoft Outlook user of your organization.
1.  Visit your Outlook Web Access (OWA) https://exchange.MyCompany.com/owa/
1.  Select an email in your Inbox.
1.  Click on your Dispatcher app icon.
    ![Outlook Add-in](<Images/Exchange Server Add-in open.png>)

> 🎉 **Congratulations**\
> You have successfully installed, configured and registered the **OutlookIntegration** and **Outlook Add-in**.

> ℹ️ You may continue to look at the [OutlookIntegration Manual](<OutlookIntegration Installation and Registration Manual.md#whats-new>).