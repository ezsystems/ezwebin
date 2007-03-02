<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc float-break">

<div class="content-view-full">
    <div class="class-{$node.object.class_identifier}">

    {foreach $node.object.contentobject_attributes as $attribute}
    <div class="attribute-{$attribute.contentclass_attribute_identifier}">
        {attribute_view_gui attribute=$attribute}
    </div>
    {/foreach}

    </div>
</div>

</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>