<#--

    Copyright 2019 XEBIALABS

    Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

-->
@echo off
setlocal

<#import "/sql/commonFunctions.ftl" as cmn>
<#include "/generic/templates/windowsSetEnvVars.ftl">

<#assign commandOpts='-b -S ${container.serverName}' />

<#if cmn.lookup('username')?? && cmn.lookup('password')??>
  <#assign commandOpts="${commandOpts} -U ${cmn.lookup('username')} -P \"${cmn.lookup('password')}\"" />
</#if>

<#if (container.databaseName?has_content) >
  <#assign commandOpts="${commandOpts} -d ${container.databaseName}" />
</#if>

<#if (cmn.lookup('additionalOptions')??) >
  <#assign commandOpts="${commandOpts} ${cmn.lookup('additionalOptions')!}" />
</#if>

sqlcmd ${commandOpts} -Q "${container.testSql}"

set RES=%ERRORLEVEL%
if not %RES% == 0 (
  exit %RES%
)

endlocal
