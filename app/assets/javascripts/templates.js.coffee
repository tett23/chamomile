class Templates
  @get: (name) ->
    defer = $.Deferred()
    $.get('/api/templates/'+name+'.html').done (r) ->
      defer.resolve(r)

    defer
  @load: (arr) ->
    defer = $.Deferred()
    templates = for name in arr
      Templates.get(name)
    $.when.apply($, templates).done () ->
      defer.resolve(arguments)

    defer
window.Templates = Templates
