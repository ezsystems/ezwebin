<?php /*

# Settings related to Website Toolbar
[WebsiteToolbarSettings]
# Controls for which content classes eZODF buttons are displayed in the Website Toolbar.
ODFDisplayClasses[]
ODFDisplayClasses[]=documentation_page
ODFDisplayClasses[]=blog
ODFDisplayClasses[]=blog_post
ODFDisplayClasses[]=folder
ODFDisplayClasses[]=article
ODFDisplayClasses[]=article_mainpage
ODFDisplayClasses[]=article_subpage
ODFDisplayClasses[]=event

# List of container classes where we don't want to show eZODF buttons
# e.g for Article content class
HideODFContainerClasses[]=article

# This list contains content class identifiers,
# which will not be displayed in the drop down menu of the Website Toolbar.
HiddenContentClasses[]=banner
HiddenContentClasses[]=common_ini_settings

# This setting enables you to include custom templates within the Website Toolbar
# Custom templates are included after the default Website Toolbar buttons
[CustomTemplateSettings]
# List of names with available custom templates
# Template should be placed in design/<design_name>/templates/parts/websitetoolbar
# Example: design/<design_name>/templates/parts/websitetoolbar/customtemplateexample.tpl
# NOTE: do not use .tpl extension in the setting value
# CustomTemplateList[]=customtemplateexample
CustomTemplateList[]=object_states

# Website Toolbar is available for 3 views: full, edit and versionview
# This setting indicates where custom templates should be included
# Array keys correspond to the custom template names defined in CustomTemplateList[]
# Separate each view name with a semi-colon
IncludeInView[]
# Example: customtemplateexample template will be included in Website Toolbar
# in the full, edit, and versionview views
# IncludeInView[customtemplateexample]=full;edit;versionview
IncludeInView[object_states]=full

*/ ?>