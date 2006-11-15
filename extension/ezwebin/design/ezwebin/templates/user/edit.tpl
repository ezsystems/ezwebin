<div class="box">
<div class="tl"><div class="tr"><div class="br"><div class="bl"><div class="box-content float-break">

<form action={concat($module.functions.edit.uri,"/",$userID)|ezurl} method="post" name="Edit">

<div class="user-edit">

<div class="attribute-header">
  <h1 class="long">{"User profile"|i18n("design/standard/user")}</h1>
</div>

<div class="block">
  <label>{"Username"|i18n("design/standard/user")}</label><div class="labelbreak"></div>
  <p class="box">{$userAccount.login|wash}</p>
</div>

<div class="block">
  <label>{"E-mail"|i18n("design/standard/user")}</label><div class="labelbreak"></div>
  <p class="box">{$userAccount.email|wash(email)}</p>
</div>

<div class="block">
  <label>{"Name"|i18n("design/standard/user")}</label><div class="labelbreak"></div>
  <p class="box">{$userAccount.contentobject.name|wash}</p>
</div>

<p><a href={"content/draft"|ezurl}>{"My drafts"|i18n("design/standard/content/view")}</a></p>
<p><a href={concat("/shop/customerorderview/", $userID, "/", $userAccount.email)|ezurl}>{"Orders"|i18n("design/admin/parts/shop/menu")}</a></p>
<p><a href={"notification/settings"|ezurl}>{"My notification settings"|i18n("design/admin/notification/settings")}</a></p>
<p><a href={"/shop/wishlist"|ezurl}>{"My wish list"|i18n("design/admin/parts/my/menu")}</a></p>

<div class="buttonblock">
<input class="button" type="submit" name="EditButton" value="{'Edit profile'|i18n('design/standard/user')}" />
<input class="button" type="submit" name="ChangePasswordButton" value="{'Change password'|i18n('design/standard/user')}" />
</div>

</div>

</form>

</div></div></div></div></div>
</div>