<#-- 
Copyright (C) 2016 Axel Faust / Markus Joos
Copyright (C) 2016 Order of the Bee

This file is part of Community Support Tools

Community Support Tools is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Community Support Tools is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with Community Support Tools. If not, see <http://www.gnu.org/licenses/>.

Linked to Alfresco
Copyright (C) 2005-2016 Alfresco Software Limited.
 
  -->

<@page title=msg("log-settings.title") readonly=true>
<#-- close the dummy form -->
</form>

<#-- TODO Full I18N -->
<#-- TODO Need to offload CSS inline styles into proper classes for layout performance (admin-template.ftl does not provide access to <head>) -->
<div class="column-full">
    <p class="intro">${msg("log-settings.intro-text")?html}</p>
    <@section label=msg("log-settings.logging") />

    <div class="column-full">
        <div>Add logger:
            <form id="addPackageForm" action="${url.service}" method="POST" enctype="multipart/form-data" accept-charset="utf-8">
                <input name="packagename" size="35" placeholder="package.name"></input>
                <select name="priority">
                    <option style="background-color: Grey"        value="OFF">UNSET</option>
                    <option style="background-color: lightGrey"   value="TRACE">TRACE</option>
                    <option style="background-color: LightGreen"  value="DEBUG">DEBUG</option>
                    <option                                       value="INFO">INFO</option>
                    <option style="background-color: LightYellow" value="WARN">WARN</option>
                    <option style="background-color: LightPink"   value="ERROR">ERROR</option>
                    <option style="background-color: LightCoral"  value="FATAL">FATAL</option>
                </select>
                <input type="submit" value="Add" style="margin-right:1em;" />
                <@button id="tailRepoLog" label="Tail Repository Log" onclick="Admin.showDialog('${url.serviceContext}/admin/log4j-tail');"/>
            </form>
        <#if statusMessage?? && statusMessage != "">
            <div id="statusmessage" class="message ${messageStatus!""}">${.now?string("HH:mm:ss")} - ${statusMessage?html!""} <a href="#" onclick="this.parentElement.style.display='none';" title="${msg("admin-console.close")}">[X]</a></div>
        </#if>
        </div>
      
        <table>
            <tr><th><b>Logger Name</b></th><th><b>Parent Logger Name</b></th><th><b>Setting</b></th><th><b>Effective Value</b></th></tr>
            <#list loggerStates as loggerState>
                <tr>
                    <td>${loggerState.name?html}</td>
                    <td>${(loggerState.parent!"")?html}</td>
                    <td>
                        <form action="${url.service}" method="POST" enctype="multipart/form-data" accept-charset="utf-8">
                            <input type="hidden" name="logger" value="${loggerState.name?html}" />
                            <select name="level" onchange="this.form.submit();">
                                <option style="background-color: Grey"        value="OFF" <#if loggerState.level?? && loggerState.level == "OFF">selected</#if>>UNSET</option>
                                <option style="background-color: lightGrey"   value="TRACE" <#if loggerState.level?? && loggerState.level == "TRACE">selected</#if>>TRACE</option>
                                <option style="background-color: LightGreen"  value="DEBUG" <#if loggerState.level?? && loggerState.level == "DEBUG">selected</#if>>DEBUG</option>
                                <option                                       value="INFO" <#if loggerState.level?? && loggerState.level == "INFO">selected</#if>>INFO</option>
                                <option style="background-color: LightYellow" value="WARN" <#if loggerState.level?? && loggerState.level == "WARN">selected</#if>>WARN</option>
                                <option style="background-color: LightPink"   value="ERROR" <#if loggerState.level?? && loggerState.level == "ERROR">selected</#if>>ERROR</option>
                                <option style="background-color: LightCoral"  value="FATAL" <#if loggerState.level?? && loggerState.level == "FATAL">selected</#if>>FATAL</option>
                            </select>
                        </form>
                    </td>
                    <td><#compress><span style="display:block;text-align:right;background-color:
                        <#switch loggerState.effectiveLevel>
                            <#case "FATAL">LightCoral<#break>
                            <#case "ERROR">LightPink<#break>
                            <#case "TRACE">lightGrey<#break>
                            <#case "WARN">LightYellow<#break>
                            <#case "DEBUG">LightGreen<#break>
                            <#case "OFF">Grey<#break>
                            <#default>inherit</#switch>
                        </#compress>">${(loggerState.effectiveLevel)?html}</span></td>
                </tr>
            </#list>
        </table>
    </div>
</div>
</@page>