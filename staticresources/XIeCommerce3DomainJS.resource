
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
