OutlookIntegration - Exchange Server Registration Manual
===
Version: `3.0.0` - `2025-10-09` \
Author: martin@freedom-manufaktur.com \
Link: [Documentation on GitHub](<https://github.com/freedom-manufaktur/OutlookIntegration/tree/main/Documentation/Exchange Server Registration Manual.md>)


# Exchange Server Registration
1.  On Exchange Server we assume that the application ID is `00000002-0000-0ff1-ce00-000000000000`. No registration is required.
2.  When the [OutlookIntegration Manual](<OutlookIntegration Installation and Registration Manual.md>) talks about the **Entra Application ID**, just use this GUID.

## Summary
As a result of this chapter you should have the following information at your disposal:
- Entra Application ID (e.g. `00000002-0000-0ff1-ce00-000000000000`)

> ℹ️ Now continue with the [OutlookIntegration Manual](<OutlookIntegration Installation and Registration Manual.md>).


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

> 🎉 Congratulations on successfully installing, configuring, registering and using the **OutlookIntegration** and **Outlook Add-in**.
