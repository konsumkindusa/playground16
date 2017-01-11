///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Boolean flags which control the implementastion behaviour
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
var gv_Reload = true;
var gv_3DS = false;
var gv_Mask = false;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// XiIntercept v3 required state variables
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
var gv_xiURL = "";
var gv_xiGUID = "";
var gv_xiAccess = "";
var gv_XIFrameURL = "";

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Credit Card required fields
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
var gv_CardNo = null;
var gv_strToken = "";
var gv_strLast4 = "";

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 3DS required variables
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
var gv_CardMonth = null;
var gv_CardYear = null;
var gv_OrderNumber = null;
var gv_OrderAmount = null;
var gv_OrderCurrency = null;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Regular Expressions to validate/identify XiSecure Tokens and MASKED tokens
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
var strTokenFormats = "(^[\*]{11,12}[0-9]{4})";             // Masked Token
strTokenFormats += "|(^-[E]803-[0-9]{4}-([0-9]|[A-Z]){14})";// E803
strTokenFormats += "|(^[7,8][3456][0-9]{12,14})";           // CC_F2_L4_14_7 and CC_F2_L4_16_8
strTokenFormats += "|(^11[0-9]{14,17})";                    // CC_F0_L4_16_11 and CC_F0_L4_19_11
strTokenFormats += "|(^[8,T][3456][0-9]{17})";              // CC_F2_L4_19_8  and CC_F4_L4_19_T
strTokenFormats += "|(^[8,T][3456][0-9]{18})";              // CC_F2_L4_20_8  and CC_F2_L4_20_T
strTokenFormats += "|(^804424[3456][0-9]{17})";             // CC_F2_L4_24_804424
strTokenFormats += "|(^T[3456][0-9]{23})";                  // CC_F2_L4_25_T
strTokenFormats += "|(^T[0-9]{8})";                         // SS_F0_L4_9_T
strTokenFormats += "|(^SS[0-9]{9})";                        // SS11
strTokenFormats += "|(^00[0-9]{7})";                        // SS9
var gv_IsToken = new RegExp(strTokenFormats, "mig");

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// This function is used to produce java console logging
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function attachConsole()
{
    if (typeof console === "undefined")
    {
        var head = document.getElementsByTagName('head')[0];
        var script = document.createElement('script');
        script.type = 'text/javascript';
        script.src = 'http://getfirebug.com/releases/lite/1.2/firebug-lite-compressed.js';
        head.appendChild(script);
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// This function generically displays or hides a DIV section which is useful to display error or informational messages
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function DisplayDiv(strDivName, bDisplay)
{
    var strDisp = (bDisplay == true ? 'block' : 'none');

    document.getElementById(strDivName).style.display = strDisp;
    document.getElementById('xiFadeDiv').style.display = strDisp;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// This function displays all exceptions details
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function DisplayException(strWhere, err)
{
    DisplayMessage(strWhere, "ERROR", err.message);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// This function display all messages needed to present to the front-end
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function DisplayMessage(strWhere, strType, strMsg)
{
    var strDesc = "    Function:  " + strWhere + "\n";
    strDesc += "Message Type:  " + strType + "\n";
    strDesc += " Description:  " + strMsg + "\n\n";
    strDesc += "Click OK to continue.\n\n";
    alert(strDesc);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// This function enables real-time tokenization for credit cards
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function InitForTokenizationCC(CardNo, bMask)
{
    var strWhere = "InitForTokenizationCC()";
    var xiFrame = null;


    try
    {
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        // Get an object reference to the IFRAME where XiIntercept has been implemented
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        DisplayDiv("xiFrameDiv", false);    // Hide the XiIntercept IFRAME
        gv_Mask = bMask;                    // Enable Token Masking?
        gv_3DS = false;                     // Enable 3D Secure?
        gv_Reload = true;                   // Reload IFRAME?
        reloadIFrame(false);                // Save the IFRAME URL for future use

        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        // Get an object reference to th IFRAME where XiIntercept has been implemented
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        xiFrame = GetIFrame();
        if (xiFrame == null) return false;

        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        // Get a reference to each HTML control needed and enable real-time tokenization
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        if ((gv_CardNo = document.getElementById(CardNo)) != null)
        {
            gv_CardNo.onblur = function () { return OnTokenizeCC(); };
        }
    }
    catch (err)
    {
        DisplayException(strWhere, err);
    }
    finally {
    }
    return true;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Event handler to trigger real-time tokenization
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function OnTokenizeCC()
{
    var strWhere = "OnTokenizeCC()";
    var xiFrame = null;
    var bResult = false;

    try
    {
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        // Get an object reference to the IFRAME where XiIntercept has been implemented
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        if ((xiFrame = GetIFrame()) != null)
        {
            ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            // Make sure the credit card field is in a good state to achieve tokenization
            ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            if (gv_CardNo.value.length == 0)
                return bResult;
            if (gv_CardNo.value.indexOf("************") != -1)
                return bResult;
            if (IsToken(gv_CardNo.value))
                return true;

            ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            // Tokenization has not taken place, copy the data entered on the required field
            ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            xiFrame.getElementById("CardNo").value = gv_CardNo.value;
            gv_CardNo.value = "";

            ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            // Trigger tokenization within the containing IFRAME
            ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            xiFrame.getElementById("xiTokenize").click();
            bResult = true;
        }
    }
    catch (err) {
        DisplayException(strWhere, err);
    }
    finally {
    }

    return bResult;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Reloads the contents of the IFRAME containing the XiIntercept implementation
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function reloadIFrame(bAction)
{
    var strWhere = "reloadIFrame()";
    var xiFrame = null;
    var iPos = 0;


    try
    {
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        // Do we need to reload the contents of the IFRAME?
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        if (gv_Reload)
        {
            ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            // Get an object reference to the IFRAME control
            ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            if ((xiFrame = GetIFrame()) != null)
            {
                if (bAction == true)                        // Reload the IFRAME now?
                {
                	iPos = gv_XIFrameURL.indexOf("?");
                	if(iPos != -1)
                	{
                		gv_XIFrameURL = gv_XIFrameURL.substr(0, iPos);
                	}
                    xiFrame.location.href = gv_XIFrameURL + '?rnd=' + Math.random();  // YES, use the saved URL
                }
                else gv_XIFrameURL = xiFrame.location.href; // NO, simply save the current URL
            }
        }
    }
    catch (err)
    {
        DisplayException(strWhere, err);
    }

    return false;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Get a object reference to the IFRAME which contains the XiIntercept implementation
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function GetIFrame()
{
    var objTmp = null;
    var xiFrame = null;

    try
    {
        objTmp = document.getElementById("xiFrame");
        if (objTmp == null && document.title.indexOf("XiIntercept") != -1)
            return document;

        xiFrame = (objTmp.contentWindow || objTmp.contentDocument);
        if (xiFrame.document)
            xiFrame = xiFrame.document;

        // Safari browsers do not trigger an exception with the above code
        // The line below triggers an exception for Safari if the xiFrame
        // is pointing to a different document.domain, which is the trigger
        // To determine if we currently displaying the 3DS authentication page
        objTmp = xiFrame.getElementById("xiTokenize");
    }
    catch (err) {
        var strMsg = err.message.toUpperCase();
        if (strMsg.indexOf("DENIED") != -1 || strMsg.indexOf("BLOCKED") != -1 || strMsg.indexOf("GETELEMENTBYID") != -1) {
            DisplayDiv("xiFrameDiv", true);
            return null;
        }
        else throw err;
    }

    return xiFrame;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Determine if the supplied argument is an actual token or a masked token
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function IsToken(strCardNo)
{
    var bResult = gv_IsToken.test(strCardNo);

    if (bResult)
    {
        strCardNo = strCardNo.toUpperCase();
        if (strCardNo.length == 15 && strCardNo.indexOf("*****") == 0)
            gv_strLast4 = strCardNo.substr(strCardNo.length - 4);
        else if (strCardNo.length == 16 && strCardNo.indexOf("*****") == 0)
            gv_strLast4 = strCardNo.substr(strCardNo.length - 4);
        else if (strCardNo.length == 25 && strCardNo.indexOf("-E") == 0)
            gv_strLast4 = strCardNo.substr(6, 4);
        else if (strCardNo.length == 14 && strCardNo.indexOf("7") == 0)
            gv_strLast4 = strCardNo.substr(strCardNo.length - 4);
        else if (strCardNo.length == 16 && strCardNo.indexOf("8") == 0)
            gv_strLast4 = strCardNo.substr(strCardNo.length - 4);
        else if (strCardNo.length == 16 && strCardNo.indexOf("11") == 0)
            gv_strLast4 = strCardNo.substr(strCardNo.length - 4);
        else if (strCardNo.length == 19 && strCardNo.indexOf("8") == 0)
            gv_strLast4 = strCardNo.substr(strCardNo.length - 4);
        else if (strCardNo.length == 19 && strCardNo.indexOf("11") == 0)
            gv_strLast4 = strCardNo.substr(strCardNo.length - 4);
        else if (strCardNo.length == 19 && strCardNo.indexOf("T") == 0)
            gv_strLast4 = strCardNo.substr(strCardNo.length - 4);
        else if (strCardNo.length == 16 && strCardNo.indexOf("T") == 0)
            gv_strLast4 = strCardNo.substr(strCardNo.length - 4);
        else if (strCardNo.length == 20 && strCardNo.indexOf("8") == 0)
            gv_strLast4 = strCardNo.substr(strCardNo.length - 4);
        else if (strCardNo.length == 20 && strCardNo.indexOf("T") == 0)
            gv_strLast4 = strCardNo.substr(strCardNo.length - 4);
        else if (strCardNo.length == 24 && strCardNo.indexOf("804424") == 0)
            gv_strLast4 = strCardNo.substr(strCardNo.length - 4);
        else if (strCardNo.length == 25 && strCardNo.indexOf("T") == 0)
            gv_strLast4 = strCardNo.substr(strCardNo.length - 4);
    }

    return bResult;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Copy the generated token to the user-supplied credit card number field, called BEFORE submition of the form
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function swapToken()
{
    var strWhere = "swapToken()";

    try
    {
        gv_CardNo.value = gv_strToken;
    }
    catch (err)
    {
        DisplayException(strWhere, err);
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Copy the generated token and display the masked token in the user-supplied credit card number field
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function showToken(strToken)
{
    var strWhere = "showToken()";


    try
    {
        gv_strToken = strToken;
        gv_CardNo.value = (gv_Mask ? maskToken(gv_strToken) : gv_strToken);
    }
    catch (err)
    {
        DisplayException(strWhere, err);
    }
    finally
    {
        reloadIFrame(true);
    }

    return false;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Determine the current "document.domain" based on the domain level specified
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function getRelaxedDomain(strDomain, iLevel)
{
    attachConsole();
    var strLevels = strDomain.split(".");
    var strRelaxed = "";

    if (strLevels.length > iLevel)
    {
        while (iLevel > 0)
        {
            strRelaxed += strLevels[strLevels.length - iLevel] + ".";
            iLevel--;
        }
        strRelaxed = strRelaxed.substr(0, strRelaxed.length - 1);
    }
    else strRelaxed = strDomain;
    return strRelaxed;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Mask the supplied card number or token
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function maskToken(strCardNo)
{
    var strWhere = "maskToken()";
    var strMasked = "";


    try
    {
        if (IsToken(strCardNo))
        {
            strMasked = "************" + gv_strLast4;
        }
        else
        {
            strMasked = strCardNo;
        }
    }
    catch (err)
    {
        DisplayException(strWhere, err);
    }

    return strMasked;
}
