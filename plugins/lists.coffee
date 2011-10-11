#     Hallo - a rich text editing jQuery UI widget
#     (c) 2011 Henri Bergius, IKS Consortium
#     Hallo may be freely distributed under the MIT license
((jQuery) ->
    jQuery.widget "IKS.hallolists",
        options:
            editable: null
            toolbar: null
            uuid: ""

        _create: ->
            widget = this
            buttonset = jQuery "<span id=\"#{@options.uuid}-" + widget.widgetName + "\"></span>"
            buttonize = (type, label) =>
                id = "#{@options.uuid}-#{type}"
                buttonset.append jQuery("<input id=\"#{id}\" type=\"checkbox\" /><label for=\"#{id}\" class=\"#{type}_button\">#{label}</label>").button()
                button = jQuery "##{id}", buttonset
                button.attr "hallo-command", "insert" + type + "List"
                button.bind "change", (event) ->
                    list = jQuery(this).attr "hallo-command"
                    widget.options.editable.execute list
                @element.bind "keyup paste change mouseup", (event) ->
                    if document.queryCommandState "insert" + type + "List"
                        button.attr "checked", true
                        button.button "refresh"
                    else
                        button.attr "checked", false
                        button.button "refresh"
            #buttonize "Ordered", "OL"
            buttonize "Unordered", "UL"

            buttonset.buttonset()
            @options.toolbar.append buttonset

        _init: ->

)(jQuery)